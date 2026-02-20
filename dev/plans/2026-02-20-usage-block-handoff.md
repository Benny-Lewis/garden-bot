# Usage-Block Handoff (2026-02-20)

## Current Status

- Testing is blocked by Claude usage cap.
- Latest interruption evidence:
  - `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/turn3.txt`
  - Message indicates reset at **Feb 23, 2026, 4:00 PM (America/Los_Angeles)**.

## What Was Completed

1. Targeted `v4` run completed:
- Run: `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v4`
- Matrix: `dev/testing/results/retest-matrix-2026-02-19-targeted-v4.md`

2. Harness isolation issue identified and fixed:
- Root-cause: Claude turn execution context allowed writes outside scenario directory.
- Fixes in `dev/testing/scripts/retest-runner.ps1`:
  - Claude now runs from scenario CWD (`Push-Location $ScenarioDir` / `Pop-Location`).
  - Snapshot scope expanded to all scenario files except harness artifacts.

3. Leaked root artifacts archived:
- `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v4/leakage-artifacts/`

4. Targeted `v5` run started with isolation fix:
- Run: `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v5`
- Partial matrix: `dev/testing/results/retest-matrix-2026-02-19-targeted-v5-partial.md`
- Confirmed scenario-local preview writes captured.

5. Browser-open evidence captured from user screenshots:
- `dev/testing/results/open-target-evidence-2026-02-20.md`
- Confirms Chrome opened scenario preview SVGs.

6. Targeted `v6` run attempted:
- Run: `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6`
- Partial matrix: `dev/testing/results/retest-matrix-2026-02-19-targeted-v6-partial.md`
- Interrupted again at scenario3 turn3 due usage cap.

7. Additional hardening after v6:
- Non-zero Claude turn exits now trigger automatic failure snapshot + failure diff in runner.
- Captured partial-write-on-failure evidence:
  - `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/diff-snap2-current-after-failed-turn3.txt`

8. Track A structural improvements implemented (2026-02-20):
- `dev/testing/scripts/retest-runner.ps1`
  - writes `saved-contract-turn*.txt` after each turn,
  - writes `open-evidence.md` stubs for design scenarios,
  - keeps failure snapshots and now uses predictable failure diff naming (`diff-<turn>-failure-vs-<baseline>.txt`),
  - enforces UTF-8 output defaults.
- `skills/landscape-design/SKILL.md`
  - preview/canonical path convention normalized to `areas/`.
- `dev/testing/regression-harness.md`
  - requires saved-contract artifacts and `open-evidence.md` proof for design scenarios,
  - normalizes preview/canonical path expectations to `areas/`.
- `dev/testing/results/retest-matrix-template.md`
  - new matrix template with explicit gate block (`GO/NO-GO` + status counts).
- `dev/testing/results/retest-matrix-2026-02-19-targeted-v4.md`
- `dev/testing/results/retest-matrix-2026-02-19-targeted-v5-partial.md`
- `dev/testing/results/retest-matrix-2026-02-19-targeted-v6-partial.md`
  - gate blocks standardized.

## Current Risks

- Interrupted turns can still partially write files before failing (must inspect failure diffs).
- Targeted suite is still incomplete; Scenario 4/2/5 remains unrated in authoritative post-fix run.

## Next Steps After Reset

1. Run targeted rerun:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode targeted `
  -RunName garden-bot-retest-20260219-targeted-v7
```

2. Build authoritative targeted matrix:
- `dev/testing/results/retest-matrix-2026-02-19-targeted-v7.md`

3. If targeted passes, run full harness:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode full `
  -RunName garden-bot-retest-20260219-full-v1
```

4. Build full matrix:
- `dev/testing/results/retest-matrix-2026-02-19-full-v1.md`

5. If failures remain:
- apply minimum structural prompt/skill changes only,
- rerun failed scenarios first,
- rerun full harness.

## Canonical Reference Docs

- `dev/plans/2026-02-20-checkpoint6-go-packet.md`
- `dev/plans/2026-02-20-checkpoint5-retest-plan.md`
- `dev/plans/2026-02-20-checkpoint4-improvement-plan.md`
- `dev/plans/2026-02-20-commit-plan.md`
- `dev/testing/results/retest-evidence-lock-2026-02-20.md`
