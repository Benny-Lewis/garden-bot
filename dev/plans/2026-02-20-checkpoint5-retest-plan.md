# Checkpoint 5 Retest Plan and Gates

Date: 2026-02-20  
Inputs:
- `dev/plans/2026-02-20-checkpoint4-improvement-plan.md`
- `dev/testing/results/retest-evidence-lock-2026-02-20.md`
- `dev/testing/results/retest-issue-matrix-2026-02-20-checkpoint2.md`
- `dev/testing/results/retest-root-cause-map-2026-02-20-checkpoint3.md`

## Objective

Run a clean, authoritative rerun sequence after usage reset with stronger structural evidence requirements and deterministic gating.

## Current Readiness

- Track A structural fixes are implemented.
- Immediate next execution step is `targeted-v7` when usage allows.

## Pre-Execution Changes Required (Track A)

Before retest execution, complete Track A items in:
- `dev/plans/2026-02-20-checkpoint4-improvement-plan.md`

At minimum:
1. deterministic `Saved:` contract artifacts,
2. preserved failure-path snapshot/diff behavior,
3. normalized preview path convention (`areas/{area}-option-*.svg`),
4. deterministic open-evidence artifact requirement,
5. matrix gate block (`GO/NO-GO` + status counts),
6. UTF-8 output normalization.

## Status Classes

- `PASS`: invariant satisfied with direct evidence.
- `FAIL`: invariant violated with direct evidence.
- `INCONCLUSIVE`: evidence insufficient.
- `INCOMPLETE`: interrupted by runtime/usage issue.

`INCOMPLETE` blocks signoff and blocks progression to full run.

## Evidence Artifacts Required Per Design Scenario

For each of scenarios 3/4/5:
1. snapshot diffs (`diff-snap*.txt`),
2. turn transcripts (`turn*.txt`),
3. `saved-contract-turn*.txt`,
4. process snapshots (`process-*.csv`),
5. `open-evidence-scenario{n}.md` containing:
- opened file path,
- observed app,
- timestamp,
- screenshot reference or explicit note.

## Phase A: Targeted Authoritative Rerun

Run:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode targeted `
  -RunName garden-bot-retest-20260219-targeted-v7
```

Output matrix:
- `dev/testing/results/retest-matrix-2026-02-19-targeted-v7.md`

### Targeted Gate (must all hold)

1. No `FAIL` on high-severity invariants:
- save-claim vs diff consistency,
- pre/post approval write gating,
- strict final-line `Saved:` contract,
- citation requirement (scenario2),
- approved-option-only save (scenario5).

2. No `INCOMPLETE`.

3. No `INCONCLUSIVE` on:
- write gating invariants,
- `Saved:` contract invariants,
- `open_target_verified` for scenarios 3/4/5.

If any condition fails, stop and apply minimal fixes only to failed areas.

## Phase B: Full Harness Rerun

Only after targeted gate passes:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode full `
  -RunName garden-bot-retest-20260219-full-v1
```

Output matrix:
- `dev/testing/results/retest-matrix-2026-02-19-full-v1.md`

Evaluate against:
- `dev/testing/regression-harness.md`

## Failure Handling Policy

1. Fix minimum structural cause first (harness/contract/instrumentation).
2. Re-run failed scenarios only.
3. Re-run full harness before final signoff.
4. Do not expand domain instruction payload unless a failure is clearly semantic and persists after structural fixes.

## Stop Conditions

Stop and revise plan if any occur:
1. Usage/runtime interruption (`INCOMPLETE`).
2. Evidence of partial writes on failed turns without captured failure diff.
3. Any mismatch between `Saved:` claims and diffs.
4. Open target observed in editor/design apps for required browser-open scenarios.

## Exit Criteria

1. Targeted `v7` matrix complete and gate passed.
2. Full `v1` matrix complete and all invariants passed.
3. All design scenarios have direct `open_target_verified` evidence.
4. No unresolved `P0/P1` issues from checkpoint2.
5. Handoff docs updated with final status and commit plan.
