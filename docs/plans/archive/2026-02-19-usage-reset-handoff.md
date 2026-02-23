# Usage-Reset Handoff (2026-02-19)

Status: Historical handoff. Superseded for active execution by:
- `docs/plans/archive/2026-02-20-checkpoint6-go-packet.md`
- `docs/plans/archive/2026-02-20-usage-block-handoff.md`

## Current State

- Work-in-progress changes are local and not yet committed.
- Usage cap interrupted retest execution during targeted run v3.
- Primary docs and evidence are preserved in repo.

## What Was Completed

1. Added automated retest runner:
- `dev/testing/scripts/retest-runner.ps1`

2. Ran targeted retest v2:
- Evidence root: `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2`
- Key result: Scenario 4 looked good for preview-before-approval vs canonical-after-approval.
- Key failures remained in Scenarios 2/3/5.

3. Applied minimal skill-level fixes (Bitter Lesson style):
- `skills/landscape-design/SKILL.md`
  - read-first guard,
  - stricter single-line final `Saved:` rule,
  - no false save claims,
  - Windows note to launch Chrome directly (not `.svg` app association).
- `skills/garden-expert/SKILL.md`
  - read-first/no-false-missing-data guard,
  - stricter single-line final `Saved:` rule,
  - no false save claims.

4. Fixed harness isolation bug:
- Runner now creates run-local `plugin-under-test` bundle (`CLAUDE.md` + `skills/`) to avoid contamination from repo test artifacts.

5. Started targeted retest v3:
- Evidence root: `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v3`
- Interrupted at:
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/turn3.txt`
  - contains usage reset message.

## Current Analysis Artifacts

- Main rolling handoff:
  - `docs/plans/archive/2026-02-19-session-handoff.md`
- Partial strict matrix:
  - `docs/testing/results/archive/retest-matrix-2026-02-19-partial.md`
- Environment/open-behavior evidence:
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/environment-check.txt`

## Checkpoint Analysis Artifacts (Latest)

- Evidence inventory (Checkpoint 1):
  - `docs/testing/results/archive/retest-evidence-inventory-2026-02-19.md`
- Severity matrix (Checkpoint 2):
  - `docs/testing/results/archive/retest-severity-matrix-2026-02-19-checkpoint2.md`
- Root-cause map (Checkpoint 3):
  - `docs/testing/results/archive/retest-root-cause-map-2026-02-19-checkpoint3.md`
- Improvement plan (Checkpoint 4):
  - `docs/plans/archive/2026-02-19-checkpoint4-improvement-plan.md`
- Retest matrix/checklist (Checkpoint 5):
  - `docs/plans/archive/2026-02-19-checkpoint5-retest-matrix.md`
- Go packet (Checkpoint 6):
  - `docs/plans/archive/2026-02-19-checkpoint6-go-packet.md`

## Latest Execution Update (2026-02-20)

1. Targeted run v4 completed:
- Run root: `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4`
- Matrix: `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v4.md`
- Finding: multiple `Saved:` vs diff mismatches.

2. Isolation flaw discovered and fixed in runner:
- Root cause: Claude turns were not forced to execute from scenario directory.
- Fix applied in `dev/testing/scripts/retest-runner.ps1`:
  - `Push-Location $ScenarioDir` / `Pop-Location` around `claude` invocation.
  - snapshot tracking now includes all scenario files except harness artifacts (`turn*`, `snap*`, `diff-*`, `process-*`), so preview SVGs at scenario root are captured.

3. Leaked root artifacts from v4 were archived:
- `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/leakage-artifacts/`
- Repo root was cleaned of leaked test outputs (`areas/`, `plants/`, `profile.md`, layout SVGs, etc.).

4. Targeted run v5 started with fixed isolation:
- Run root: `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5`
- Partial matrix: `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v5-partial.md`
- Improvement proven: scenario-local preview writes captured (`scenario3/front-yard-option-a.svg`, `scenario3/front-yard-option-b.svg`).
- User-observed open evidence captured in:
  - `docs/testing/results/archive/open-target-evidence-2026-02-20.md`
  - Confirms scenario3 preview SVGs opened in Chrome (not Illustrator).
- Blocker: interrupted at `scenario3/turn3.txt` due usage cap reset message.

5. Targeted run v6 also interrupted by usage cap:
- Run root: `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v6`
- Partial matrix: `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v6-partial.md`
- Interruption evidence: `scenario3/turn3.txt` now reports reset at **Feb 23, 4pm (America/Los_Angeles)**.
- Important: despite failure, partial canonical writes occurred in scenario3 and were captured in:
  - `scenario3/diff-snap2-current-after-failed-turn3.txt`

6. Additional harness hardening applied:
- `dev/testing/scripts/retest-runner.ps1` now captures a failure snapshot and failure diff automatically on non-zero Claude turn exit.

## Remaining Work

1. Re-run targeted sequence using updated runner (fresh run, post-usage reset):
- Scenario 3
- Scenario 4
- Scenario 2
- Scenario 5

2. Rebuild strict pass/fail matrix against every invariant in:
- `dev/testing/regression-harness.md`

3. If any failures remain:
- apply minimum structural skill edits only,
- rerun failed scenarios first.

4. Run full harness 1-5 after targeted passes.

5. Confirm actual open behavior on host (Chrome/browser vs Illustrator) with user-observed evidence.

6. Commit changes in logical commits once retest is green.

## Canonical Next-Step Source

Use `docs/plans/archive/2026-02-20-checkpoint6-go-packet.md` as the primary execution guide after reset.

## Resume Commands

From repo root (`C:\Users\Ben\dev\garden-bot`):

```powershell
git status --short

powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode targeted `
  -RunName garden-bot-retest-20260219-targeted-v7
```

After targeted passes:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode full `
  -RunName garden-bot-retest-20260219-full-v1
```

## Files Currently Modified/Added (expected)

- `skills/landscape-design/SKILL.md`
- `skills/garden-expert/SKILL.md`
- `dev/testing/scripts/retest-runner.ps1`
- `docs/plans/archive/2026-02-19-session-handoff.md`
- `docs/testing/results/archive/retest-matrix-2026-02-19-partial.md`
- this file: `docs/plans/archive/2026-02-19-usage-reset-handoff.md`
- evidence dirs:
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/`
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v3/`

