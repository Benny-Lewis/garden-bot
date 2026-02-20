# Retest Matrix - Targeted V6 (Partial)

Date: 2026-02-20  
Run: `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6`  
Mode: targeted (interrupted)

## Run Validity

- Status: **INCOMPLETE**
- Interruption point: `scenario3/turn3.txt`
- Interruption evidence: `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/turn3.txt`
- Message: `You're out of extra usage - resets Feb 23, 4pm (America/Los_Angeles)`.

## Gate Block

- Decision: **NO-GO**
- Blockers:
  - INCOMPLETE statuses present.
  - Scenario coverage incomplete (4/2/5 not executed).
  - Interrupted turn produced partial canonical writes.
- Status counts:
  - PASS: 2
  - FAIL: 0
  - INCONCLUSIVE: 1
  - INCOMPLETE: 5

## Partial Matrix

| Scenario | Invariant | Status | Confidence | open_target_verified | Evidence | Rationale |
|---|---|---|---|---|---|---|
| 3 | Pre-approval canonical unchanged (turn1 boundary) | PASS | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/diff-snap0-snap1.txt` | No files changed after turn1. |
| 3 | Preview SVGs created pre-approval | PASS | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/diff-snap1-snap2.txt` | Preview option SVGs were added in `areas/` pre-approval. |
| 3 | Post-approval canonical save behavior | INCOMPLETE | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/turn3.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/diff-snap2-current-after-failed-turn3.txt` | Turn failed due usage, but partial canonical writes occurred before failure. |
| 3 | `Saved:` contract on approval turn | INCOMPLETE | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/turn3.txt` | No valid completion response due usage error. |
| 3 | Open behavior browser vs Illustrator/editor | INCONCLUSIVE | Medium | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/process-after-turn2.csv`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6/environment-check.txt` | Process activity suggests browser open, but no direct scenario-v6 user screenshot. |
| 4 | All invariants | INCOMPLETE | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6` | Not executed. |
| 2 | All invariants | INCOMPLETE | High | n/a | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6` | Not executed. |
| 5 | All invariants | INCOMPLETE | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6` | Not executed. |

## New Risk Identified

- A failed turn can still produce partial writes before the command exits non-zero.
- Evidence:
  - `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/turn3.txt`
  - `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/diff-snap2-current-after-failed-turn3.txt`
- Impact: interrupted runs cannot be treated as write-noop; failure paths require explicit post-failure snapshots.




