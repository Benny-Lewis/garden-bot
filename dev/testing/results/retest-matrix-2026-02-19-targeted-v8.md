# Retest Matrix - Targeted V8

Date: 2026-02-20  
Run: `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8`  
Mode: targeted (planned)

## Run Validity

- Status: **PLANNED**
- Interruption point: n/a
- Interruption evidence: n/a
- Message: pending post-reset execution.

## Gate Block

- Decision: **NO-GO**
- Blockers:
  - Run not executed yet.
  - Evidence artifacts not populated yet.
- Status counts:
  - PASS: 0
  - FAIL: 0
  - INCONCLUSIVE: 0
  - INCOMPLETE: 0

## Matrix

| Scenario | Invariant | Status | Confidence | open_target_verified | Evidence | Rationale |
|---|---|---|---|---|---|---|
| 3 | Preview-only writes before approval + canonical save only after approval | INCOMPLETE | Medium | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario3/` | Pending execution. |
| 3 | Turn-level `Saved:` final-line contract | INCOMPLETE | Medium | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario3/saved-contract-turn*.txt` | Pending execution. |
| 3 | Open behavior browser vs editor/design apps | INCONCLUSIVE | Medium | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario3/open-evidence.md` | Pending user-observed evidence. |
| 4 | Design modification integrity invariants | INCOMPLETE | Medium | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario4/` | Pending execution. |
| 2 | Diagnosis, sourcing, and persistence invariants | INCOMPLETE | Medium | n/a | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario2/` | Pending execution. |
| 5 | Two-option preview, approval gating, approved-option-only save | INCOMPLETE | Medium | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario5/` | Pending execution. |
| Trigger smoke | Should-trigger / should-not-trigger routing checks | INCOMPLETE | Medium | n/a | `dev/testing/regression-harness.md` | Pending execution and matrix evidence rows. |

## Notes

- Required per-turn artifacts: `saved-contract-turn*.txt`.
- Required failure-path artifacts when present: `snap-failure-*.csv` and `diff-*-failure-vs-*.txt`.
- For scenarios 3/4/5, include `open-evidence.md` with direct user-observed proof.
