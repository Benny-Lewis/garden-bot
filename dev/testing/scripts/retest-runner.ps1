param(
  [ValidateSet("targeted", "full", "all")]
  [string]$Mode = "all",
  [string]$RunName = "",
  [string]$RunDate = "2026-02-19"
)

$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'
$PSDefaultParameterValues['Export-Csv:Encoding'] = 'utf8'

function Get-RepoRoot {
  return (Resolve-Path (Join-Path $PSScriptRoot "..\..\..")).Path
}

function Get-RunRoot {
  param(
    [string]$RepoRootPath,
    [string]$DateFolder,
    [string]$Label
  )
  $base = Join-Path $RepoRootPath "dev\testing\runs\$DateFolder"
  New-Item -ItemType Directory -Force -Path $base | Out-Null
  return (Join-Path $base $Label)
}

function New-PluginBundle {
  param(
    [string]$RepoRootPath,
    [string]$RunRootPath
  )

  $bundle = Join-Path $RunRootPath "plugin-under-test"
  New-Item -ItemType Directory -Force -Path $bundle | Out-Null
  Copy-Item (Join-Path $RepoRootPath "CLAUDE.md") (Join-Path $bundle "CLAUDE.md") -Force
  Copy-Item (Join-Path $RepoRootPath "skills") (Join-Path $bundle "skills") -Recurse -Force
  return $bundle
}

function Write-TrackedSnapshot {
  param(
    [string]$ScenarioDir,
    [string]$SnapshotName
  )

  $root = (Resolve-Path $ScenarioDir).Path
  $tracked = Get-ChildItem -Path $ScenarioDir -Recurse -File -ErrorAction SilentlyContinue |
    Where-Object {
      $_.Name -notmatch '^turn\d+\.txt$' -and
      $_.Name -notmatch '^saved-contract-turn\d+\.txt$' -and
      $_.Name -notmatch '^open-evidence\.md$' -and
      $_.Name -notmatch '^snap\d+\.csv$' -and
      $_.Name -notmatch '^snap-failure-.*\.csv$' -and
      $_.Name -notmatch '^diff-snap\d+-snap\d+\.txt$' -and
      $_.Name -notmatch '^diff-.*-failure-vs-.*\.txt$' -and
      $_.Name -notmatch '^process-.*\.csv$'
    }

  $rows = $tracked |
    Sort-Object FullName |
    Select-Object @{
      Name = "Path"
      Expression = {
        if ($_.FullName.StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase)) {
          $_.FullName.Substring($root.Length + 1)
        } else {
          $_.FullName
        }
      }
    }, Length, LastWriteTimeUtc, @{
      Name = "Sha256"
      Expression = { (Get-FileHash $_.FullName -Algorithm SHA256).Hash }
    }

  $snapshotPath = Join-Path $ScenarioDir $SnapshotName
  $rows | Export-Csv -NoTypeInformation -Path $snapshotPath
}

function Write-SnapshotDiff {
  param(
    [string]$ScenarioDir,
    [string]$From,
    [string]$To,
    [string]$OutputName
  )

  $a = Import-Csv (Join-Path $ScenarioDir $From)
  $b = Import-Csv (Join-Path $ScenarioDir $To)

  $ah = @{}
  foreach ($row in $a) {
    $ah[$row.Path] = $row
  }

  $bh = @{}
  foreach ($row in $b) {
    $bh[$row.Path] = $row
  }

  $changes = @()
  $all = ($ah.Keys + $bh.Keys | Sort-Object -Unique)
  foreach ($path in $all) {
    if (-not $ah.ContainsKey($path)) {
      $changes += "ADDED`t$path"
    } elseif (-not $bh.ContainsKey($path)) {
      $changes += "DELETED`t$path"
    } elseif ($ah[$path].Sha256 -ne $bh[$path].Sha256) {
      $changes += "MODIFIED`t$path"
    }
  }

  if ($changes.Count -eq 0) {
    $changes = @("NO_CHANGES")
  }

  Set-Content -Path (Join-Path $ScenarioDir $OutputName) -Value $changes
}

function Write-ProcessSnapshot {
  param(
    [string]$ScenarioDir,
    [string]$OutputName
  )

  $names = @("chrome", "msedge", "firefox", "brave", "illustrator", "lightroom", "photoshop")
  Get-Process -ErrorAction SilentlyContinue |
    Where-Object { $_.ProcessName -in $names } |
    Select-Object ProcessName, Id, StartTime, Path |
    Export-Csv -NoTypeInformation -Path (Join-Path $ScenarioDir $OutputName)
}

function Write-SavedContractStatus {
  param(
    [string]$ScenarioDir,
    [string]$OutputFile,
    [string]$OutputText
  )

  $turnTag = [System.IO.Path]::GetFileNameWithoutExtension($OutputFile)
  $artifact = Join-Path $ScenarioDir "saved-contract-$turnTag.txt"
  $lines = $OutputText -split "`r?`n"
  $finalNonEmpty = $lines | Where-Object { $_.Trim().Length -gt 0 } | Select-Object -Last 1

  $status = "FAIL"
  $reason = "no-non-empty-output"
  if ($finalNonEmpty) {
    if ($finalNonEmpty -match '^Saved: none - .+$') {
      $status = "PASS"
      $reason = "matches-none-format"
    } elseif ($finalNonEmpty -match '^Saved: .+$') {
      $status = "PASS"
      $reason = "matches-paths-format"
    } else {
      $reason = "final-line-not-saved-contract"
    }
  }

  @(
    "Status: $status",
    "Reason: $reason",
    "FinalNonEmptyLine: $finalNonEmpty",
    'Rule: final non-empty line must be Saved: <paths> or Saved: none - <reason>'
  ) | Set-Content -Path $artifact
}

function Write-OpenEvidenceStub {
  param(
    [string]$ScenarioDir,
    [string]$ScenarioLabel
  )

  $artifact = Join-Path $ScenarioDir "open-evidence.md"
  @(
    "# Open Target Evidence - $ScenarioLabel",
    "",
    "Status: PENDING",
    "Opened file path:",
    "Observed app:",
    "Timestamp (local):",
    "Screenshot reference or note:",
    "",
    "Rules:",
    "- PASS only with direct user-observed evidence.",
    "- Process snapshots are supporting evidence only."
  ) | Set-Content -Path $artifact
}

function Invoke-ClaudeTurn {
  param(
    [string]$ScenarioDir,
    [string]$PluginDir,
    [string]$Prompt,
    [string]$OutputFile,
    [switch]$Continue
  )

  $bashCandidates = @(
    "C:\Program Files\Git\bin\bash.exe",
    "C:\Program Files\Git\usr\bin\bash.exe"
  )
  $bashPath = $bashCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
  if (-not $bashPath) {
    throw "Could not find Git bash path for CLAUDE_CODE_GIT_BASH_PATH."
  }

  $env:CLAUDE_CODE_GIT_BASH_PATH = $bashPath
  $baseArgs = @(
    "-p",
    "--dangerously-skip-permissions",
    "--output-format", "text",
    "--plugin-dir", $PluginDir,
    "--add-dir", $ScenarioDir
  )
  if ($Continue) {
    $baseArgs = @("-p", "-c", "--dangerously-skip-permissions", "--output-format", "text", "--plugin-dir", $PluginDir, "--add-dir", $ScenarioDir)
  }

  $args = $baseArgs + @("--", $Prompt)
  Push-Location $ScenarioDir
  try {
    $result = & claude @args 2>&1
  } finally {
    Pop-Location
  }
  $resultText = if ($result -is [System.Array]) { $result -join [Environment]::NewLine } else { [string]$result }
  Set-Content -Path (Join-Path $ScenarioDir $OutputFile) -Value $resultText
  Write-SavedContractStatus -ScenarioDir $ScenarioDir -OutputFile $OutputFile -OutputText $resultText

  if ($LASTEXITCODE -ne 0) {
    $failureTag = ($OutputFile -replace '\.txt$', '')
    $failureSnap = "snap-failure-$failureTag.csv"
    Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName $failureSnap

    $latestBaseline = Get-ChildItem -Path $ScenarioDir -Filter "snap*.csv" -File |
      Where-Object { $_.Name -ne $failureSnap } |
      Sort-Object LastWriteTimeUtc -Descending |
      Select-Object -First 1

    if ($latestBaseline) {
      $failureDiff = "diff-$failureTag-failure-vs-$($latestBaseline.BaseName).txt"
      Write-SnapshotDiff -ScenarioDir $ScenarioDir -From $latestBaseline.Name -To $failureSnap -OutputName $failureDiff
    }
    throw "Claude turn failed in $ScenarioDir ($OutputFile)."
  }
}

function Ensure-ScenarioDirs {
  param([string]$ScenarioDir)
  New-Item -ItemType Directory -Force -Path $ScenarioDir | Out-Null
  New-Item -ItemType Directory -Force -Path (Join-Path $ScenarioDir "areas"), (Join-Path $ScenarioDir "plants"), (Join-Path $ScenarioDir "log") | Out-Null
}

function Seed-Scenario1 {
  param([string]$ScenarioDir)
  Ensure-ScenarioDirs -ScenarioDir $ScenarioDir
  if (Test-Path (Join-Path $ScenarioDir "profile.md")) { Remove-Item (Join-Path $ScenarioDir "profile.md") -Force }
  @"
# Calendar
- 2026-02-20: Placeholder only.
"@ | Set-Content (Join-Path $ScenarioDir "calendar.md")
}

function Seed-Scenario2 {
  param([string]$ScenarioDir)
  Ensure-ScenarioDirs -ScenarioDir $ScenarioDir
  @"
# Garden Profile
- Location: Portland, OR
- Zone: 8b
- Soil: Clay loam
- Frost dates: last frost Apr 15, first frost Oct 31
"@ | Set-Content (Join-Path $ScenarioDir "profile.md")
  @"
# Backyard
- Area: 40x30 ft
- Sun: Full sun in south half, shade under north oak
- Tomatoes: 12 seedlings in south raised bed
"@ | Set-Content (Join-Path $ScenarioDir "areas\backyard.md")
  @"
# Calendar
- 2026-02-20: Check tomato seedling moisture and airflow.
"@ | Set-Content (Join-Path $ScenarioDir "calendar.md")
  @"
# Tomatoes 2026
- Variety: mixed slicer types
- Location: backyard south raised bed
- Date planted: 2026-02-10
- Notes: seedlings started indoors then transplanted
"@ | Set-Content (Join-Path $ScenarioDir "plants\tomatoes-2026.md")
  @"
# 2026-02
- 2026-02-18: Transplanted tomato seedlings to raised bed.
"@ | Set-Content (Join-Path $ScenarioDir "log\2026-02.md")
}

function Seed-Scenario3 {
  param([string]$ScenarioDir)
  Ensure-ScenarioDirs -ScenarioDir $ScenarioDir
  @"
# Garden Profile
- Location: Portland, OR
- Zone: 8b
"@ | Set-Content (Join-Path $ScenarioDir "profile.md")
  @"
# Front Yard
- Dimensions: 30x15 ft
- Orientation: South-facing
- Existing: Lawn and walkway to front door
- Goal: Better curb appeal with some edible plants
"@ | Set-Content (Join-Path $ScenarioDir "areas\front-yard.md")
  @"
# Calendar
- 2026-03-01: Review front yard design options.
"@ | Set-Content (Join-Path $ScenarioDir "calendar.md")
  @"
# 2026-02
- 2026-02-18: Noted front yard redesign goal.
"@ | Set-Content (Join-Path $ScenarioDir "log\2026-02.md")
}

function Seed-Scenario4 {
  param([string]$ScenarioDir)
  Ensure-ScenarioDirs -ScenarioDir $ScenarioDir
  @"
# Garden Profile
- Location: Portland, OR
- Zone: 8b
"@ | Set-Content (Join-Path $ScenarioDir "profile.md")
  @"
# Backyard
- Dimensions: 40x30 ft
- Zones: backyard-south near patio and backyard-north under oak
"@ | Set-Content (Join-Path $ScenarioDir "areas\backyard.md")
  @"
# Backyard South
- Dimensions: 20x18 ft
- Orientation: South edge at patio, north edge to lawn
- Existing features: fire pit on west side, 4 raised beds on east side, seating near patio

## Design
![Layout](backyard-south-layout.svg)

- Fire pit: west side
- Raised beds: 4 total on east side
- Seating: near patio with clear path
"@ | Set-Content (Join-Path $ScenarioDir "areas\backyard-south.md")
  @"
<svg xmlns="http://www.w3.org/2000/svg" width="800" height="520" viewBox="0 0 800 520">
  <rect x="0" y="0" width="800" height="520" fill="#f6f3ea" />
  <rect x="40" y="40" width="720" height="440" fill="none" stroke="#333" stroke-width="2" />
  <text x="50" y="30" font-size="14" fill="#111">Backyard South Existing Layout</text>
  <circle cx="180" cy="250" r="55" fill="#9e9e9e" stroke="#333" />
  <text x="135" y="255" font-size="14" fill="#111">Fire Pit</text>
  <rect x="480" y="120" width="80" height="60" fill="#8b5a2b" stroke="#333" />
  <rect x="580" y="120" width="80" height="60" fill="#8b5a2b" stroke="#333" />
  <rect x="480" y="210" width="80" height="60" fill="#8b5a2b" stroke="#333" />
  <rect x="580" y="210" width="80" height="60" fill="#8b5a2b" stroke="#333" />
  <text x="500" y="105" font-size="13" fill="#111">Raised Beds (4)</text>
  <rect x="250" y="360" width="180" height="70" fill="#d0d0d0" stroke="#333" />
  <text x="285" y="402" font-size="13" fill="#111">Seating</text>
  <line x1="40" y1="495" x2="760" y2="495" stroke="#333" />
  <text x="45" y="512" font-size="12" fill="#111">South (Patio Side)</text>
</svg>
"@ | Set-Content (Join-Path $ScenarioDir "areas\backyard-south-layout.svg")
  @"
# Calendar
- 2026-03-05: Review updated backyard-south design.
"@ | Set-Content (Join-Path $ScenarioDir "calendar.md")
  @"
# 2026-02
- 2026-02-18: Saved backyard-south design with fire pit west and 4 raised beds east.
"@ | Set-Content (Join-Path $ScenarioDir "log\2026-02.md")
}

function Seed-Scenario5 {
  param([string]$ScenarioDir)
  Ensure-ScenarioDirs -ScenarioDir $ScenarioDir
  @"
# Garden Profile
- Location: Portland, OR
- Zone: 8b
"@ | Set-Content (Join-Path $ScenarioDir "profile.md")
  @"
# Side Yard
- Dimensions: 24x8 ft
- Orientation: East-west corridor with partial shade
- Existing: Narrow path, fence on north edge
- Goal: Improve identity and usability
"@ | Set-Content (Join-Path $ScenarioDir "areas\side-yard.md")
  @"
# Calendar
- 2026-03-10: Evaluate side yard concept directions.
"@ | Set-Content (Join-Path $ScenarioDir "calendar.md")
  @"
# 2026-02
- 2026-02-18: Noted side yard redesign goal.
"@ | Set-Content (Join-Path $ScenarioDir "log\2026-02.md")
}

function Run-Scenario1 {
  param([string]$ScenarioDir, [string]$PluginDir)
  Seed-Scenario1 -ScenarioDir $ScenarioDir
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap0.csv"
  Invoke-ClaudeTurn -ScenarioDir $ScenarioDir -PluginDir $PluginDir -Prompt "I just moved to Portland, OR zone 8b. Front yard is 30x15 south-facing lawn. Backyard is 40x30 with a large oak on the north half and a 10x12 patio. Help me start tracking my garden." -OutputFile "turn1.txt"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap1.csv"
  Write-SnapshotDiff -ScenarioDir $ScenarioDir -From "snap0.csv" -To "snap1.csv" -OutputName "diff-snap0-snap1.txt"
  Invoke-ClaudeTurn -ScenarioDir $ScenarioDir -PluginDir $PluginDir -Continue -Prompt "Goals: low maintenance, some edible production, and better pollinator habitat. Soil is heavy clay, irrigation is one hose bib near patio, and I am a beginner. Please continue and save what is needed." -OutputFile "turn2.txt"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap2.csv"
  Write-SnapshotDiff -ScenarioDir $ScenarioDir -From "snap1.csv" -To "snap2.csv" -OutputName "diff-snap1-snap2.txt"
}

function Run-Scenario2 {
  param([string]$ScenarioDir, [string]$PluginDir)
  Seed-Scenario2 -ScenarioDir $ScenarioDir
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap0.csv"
  Invoke-ClaudeTurn -ScenarioDir $ScenarioDir -PluginDir $PluginDir -Prompt "My tomato seedlings have yellow lower leaves with dark brown concentric spots. What is this and what should I do?" -OutputFile "turn1.txt"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap1.csv"
  Write-SnapshotDiff -ScenarioDir $ScenarioDir -From "snap0.csv" -To "snap1.csv" -OutputName "diff-snap0-snap1.txt"
  Invoke-ClaudeTurn -ScenarioDir $ScenarioDir -PluginDir $PluginDir -Continue -Prompt "More details: these are outdoors in the backyard raised bed, overhead watered in the evening, and we had cool wet weather last week. Symptoms started on lower leaves and moved up slowly. No fertilizer recently. Please provide diagnosis, actions, and record all time-based follow-ups." -OutputFile "turn2.txt"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap2.csv"
  Write-SnapshotDiff -ScenarioDir $ScenarioDir -From "snap1.csv" -To "snap2.csv" -OutputName "diff-snap1-snap2.txt"
}

function Run-Scenario3 {
  param([string]$ScenarioDir, [string]$PluginDir)
  Seed-Scenario3 -ScenarioDir $ScenarioDir
  Write-OpenEvidenceStub -ScenarioDir $ScenarioDir -ScenarioLabel "Scenario 3"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap0.csv"
  Write-ProcessSnapshot -ScenarioDir $ScenarioDir -OutputName "process-before-turn1.csv"
  Invoke-ClaudeTurn -ScenarioDir $ScenarioDir -PluginDir $PluginDir -Prompt "Design my front yard for curb appeal with some edible plants." -OutputFile "turn1.txt"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap1.csv"
  Write-SnapshotDiff -ScenarioDir $ScenarioDir -From "snap0.csv" -To "snap1.csv" -OutputName "diff-snap0-snap1.txt"
  Write-ProcessSnapshot -ScenarioDir $ScenarioDir -OutputName "process-after-turn1.csv"
  Invoke-ClaudeTurn -ScenarioDir $ScenarioDir -PluginDir $PluginDir -Continue -Prompt "Details: location Portland OR zone 8b. Front yard is 30 ft wide by 15 ft deep, south-facing full sun. No driveway in this section. Walkway is straight, 4 ft wide, and the front door is slightly right of center. There is a 2 ft foundation strip along the house. At the street there is a 5 ft planting strip between sidewalk and curb. Style preference is clean modern PNW native. Edible priority is stealth edibles integrated with ornamentals. Please show two SVG layout options with tradeoffs as preview only; do not save canonical files yet." -OutputFile "turn2.txt"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap2.csv"
  Write-SnapshotDiff -ScenarioDir $ScenarioDir -From "snap1.csv" -To "snap2.csv" -OutputName "diff-snap1-snap2.txt"
  Write-ProcessSnapshot -ScenarioDir $ScenarioDir -OutputName "process-after-turn2.csv"
  Invoke-ClaudeTurn -ScenarioDir $ScenarioDir -PluginDir $PluginDir -Continue -Prompt "I pick option B. Keep the stronger edible density and open sightline to the door. Approved: save this design now." -OutputFile "turn3.txt"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap3.csv"
  Write-SnapshotDiff -ScenarioDir $ScenarioDir -From "snap2.csv" -To "snap3.csv" -OutputName "diff-snap2-snap3.txt"
}

function Run-Scenario4 {
  param([string]$ScenarioDir, [string]$PluginDir)
  Seed-Scenario4 -ScenarioDir $ScenarioDir
  Write-OpenEvidenceStub -ScenarioDir $ScenarioDir -ScenarioLabel "Scenario 4"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap0.csv"
  Write-ProcessSnapshot -ScenarioDir $ScenarioDir -OutputName "process-before-turn1.csv"
  Invoke-ClaudeTurn -ScenarioDir $ScenarioDir -PluginDir $PluginDir -Prompt "Move the fire pit to the opposite side and reduce raised beds from 4 to 2." -OutputFile "turn1.txt"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap1.csv"
  Write-SnapshotDiff -ScenarioDir $ScenarioDir -From "snap0.csv" -To "snap1.csv" -OutputName "diff-snap0-snap1.txt"
  Write-ProcessSnapshot -ScenarioDir $ScenarioDir -OutputName "process-after-turn1.csv"
  Invoke-ClaudeTurn -ScenarioDir $ScenarioDir -PluginDir $PluginDir -Continue -Prompt "Looks good. Approved: save this update now." -OutputFile "turn2.txt"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap2.csv"
  Write-SnapshotDiff -ScenarioDir $ScenarioDir -From "snap1.csv" -To "snap2.csv" -OutputName "diff-snap1-snap2.txt"
}

function Run-Scenario5 {
  param([string]$ScenarioDir, [string]$PluginDir)
  Seed-Scenario5 -ScenarioDir $ScenarioDir
  Write-OpenEvidenceStub -ScenarioDir $ScenarioDir -ScenarioLabel "Scenario 5"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap0.csv"
  Write-ProcessSnapshot -ScenarioDir $ScenarioDir -OutputName "process-before-turn1.csv"
  Invoke-ClaudeTurn -ScenarioDir $ScenarioDir -PluginDir $PluginDir -Prompt "I want a PNW native look with Japanese influence in this side yard." -OutputFile "turn1.txt"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap1.csv"
  Write-SnapshotDiff -ScenarioDir $ScenarioDir -From "snap0.csv" -To "snap1.csv" -OutputName "diff-snap0-snap1.txt"
  Write-ProcessSnapshot -ScenarioDir $ScenarioDir -OutputName "process-after-turn1.csv"
  Invoke-ClaudeTurn -ScenarioDir $ScenarioDir -PluginDir $PluginDir -Continue -Prompt "Details: the side yard is 24x8 ft, east-west corridor, partial shade, with a fence on the north edge and a narrow path to keep clear. I want a PNW native look with Japanese influence and low maintenance. Please show two SVG layout options with tradeoffs as preview only; do not save canonical files yet." -OutputFile "turn2.txt"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap2.csv"
  Write-SnapshotDiff -ScenarioDir $ScenarioDir -From "snap1.csv" -To "snap2.csv" -OutputName "diff-snap1-snap2.txt"
  Invoke-ClaudeTurn -ScenarioDir $ScenarioDir -PluginDir $PluginDir -Continue -Prompt "Approved option B. Save it now." -OutputFile "turn3.txt"
  Write-TrackedSnapshot -ScenarioDir $ScenarioDir -SnapshotName "snap3.csv"
  Write-SnapshotDiff -ScenarioDir $ScenarioDir -From "snap2.csv" -To "snap3.csv" -OutputName "diff-snap2-snap3.txt"
}

function Write-EnvironmentInfo {
  param(
    [string]$RunRoot
  )
  $output = Join-Path $RunRoot "environment-check.txt"
  $lines = @()
  $lines += "Timestamp: $(Get-Date -Format o)"
  $lines += "SVG user choice:"
  try {
    $choice = Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice"
    $lines += ($choice | Format-List | Out-String).TrimEnd()
  } catch {
    $lines += "UserChoice key not found or inaccessible."
  }
  $lines += ""
  $lines += "Chrome paths:"
  $chromeCandidates = @(
    "C:\Program Files\Google\Chrome\Application\chrome.exe",
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
  )
  foreach ($candidate in $chromeCandidates) {
    $lines += "$candidate => $(Test-Path $candidate)"
  }
  Set-Content -Path $output -Value $lines
}

$repoRoot = Get-RepoRoot

if ([string]::IsNullOrWhiteSpace($RunName)) {
  $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
  $RunName = "garden-bot-retest-$stamp-$Mode"
}

$runRoot = Get-RunRoot -RepoRootPath $repoRoot -DateFolder $RunDate -Label $RunName
New-Item -ItemType Directory -Force -Path $runRoot | Out-Null
Write-EnvironmentInfo -RunRoot $runRoot
$pluginDir = New-PluginBundle -RepoRootPath $repoRoot -RunRootPath $runRoot

if ($Mode -in @("targeted", "all")) {
  Run-Scenario3 -ScenarioDir (Join-Path $runRoot "scenario3") -PluginDir $pluginDir
  Run-Scenario4 -ScenarioDir (Join-Path $runRoot "scenario4") -PluginDir $pluginDir
  Run-Scenario2 -ScenarioDir (Join-Path $runRoot "scenario2") -PluginDir $pluginDir
  Run-Scenario5 -ScenarioDir (Join-Path $runRoot "scenario5") -PluginDir $pluginDir
}

if ($Mode -in @("full", "all")) {
  Run-Scenario1 -ScenarioDir (Join-Path $runRoot "full-scenario1") -PluginDir $pluginDir
  Run-Scenario2 -ScenarioDir (Join-Path $runRoot "full-scenario2") -PluginDir $pluginDir
  Run-Scenario3 -ScenarioDir (Join-Path $runRoot "full-scenario3") -PluginDir $pluginDir
  Run-Scenario4 -ScenarioDir (Join-Path $runRoot "full-scenario4") -PluginDir $pluginDir
  Run-Scenario5 -ScenarioDir (Join-Path $runRoot "full-scenario5") -PluginDir $pluginDir
}

Write-Output "Retest run completed at $runRoot"
