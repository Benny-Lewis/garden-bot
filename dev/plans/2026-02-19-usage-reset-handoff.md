# Usage-Reset Handoff (2026-02-19)

## Current State

- Work-in-progress changes are local and not yet committed.
- Usage cap interrupted retest execution during targeted run v3.
- Primary docs and evidence are preserved in repo.

## What Was Completed

1. Added automated retest runner:
- `dev/testing/scripts/retest-runner.ps1`

2. Ran targeted retest v2:
- Evidence root: `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2`
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
- Evidence root: `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v3`
- Interrupted at:
  - `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/turn3.txt`
  - contains usage reset message.

## Current Analysis Artifacts

- Main rolling handoff:
  - `dev/plans/2026-02-19-session-handoff.md`
- Partial strict matrix:
  - `dev/testing/results/retest-matrix-2026-02-19-partial.md`
- Environment/open-behavior evidence:
  - `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/environment-check.txt`

## Checkpoint Analysis Artifacts (Latest)

- Evidence inventory (Checkpoint 1):
  - `dev/testing/results/retest-evidence-inventory-2026-02-19.md`
- Severity matrix (Checkpoint 2):
  - `dev/testing/results/retest-severity-matrix-2026-02-19-checkpoint2.md`
- Root-cause map (Checkpoint 3):
  - `dev/testing/results/retest-root-cause-map-2026-02-19-checkpoint3.md`
- Improvement plan (Checkpoint 4):
  - `dev/plans/2026-02-19-checkpoint4-improvement-plan.md`
- Retest matrix/checklist (Checkpoint 5):
  - `dev/plans/2026-02-19-checkpoint5-retest-matrix.md`
- Go packet (Checkpoint 6):
  - `dev/plans/2026-02-19-checkpoint6-go-packet.md`

## Remaining Work

1. Re-run targeted sequence using updated runner:
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

Use `dev/plans/2026-02-19-checkpoint6-go-packet.md` as the primary execution guide after reset.

## Resume Commands

From repo root (`C:\Users\Ben\dev\garden-bot`):

```powershell
git status --short

powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode targeted `
  -RunName garden-bot-retest-20260219-targeted-v4
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
- `dev/plans/2026-02-19-session-handoff.md`
- `dev/testing/results/retest-matrix-2026-02-19-partial.md`
- this file: `dev/plans/2026-02-19-usage-reset-handoff.md`
- evidence dirs:
  - `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/`
  - `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v3/`
