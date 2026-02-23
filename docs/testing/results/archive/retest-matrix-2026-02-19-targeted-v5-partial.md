# Retest Matrix - Targeted V5 (Partial)

Date: 2026-02-20  
Run: `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5`  
Mode: targeted (interrupted)

## Run Validity

- Status: **INCOMPLETE**
- Interruption point: `scenario3/turn3.txt`
- Interruption evidence: `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5/scenario3/turn3.txt`
- Message: usage cap reached (`You're out of extra usage - resets 9pm (America/Los_Angeles)`).

## Gate Block

- Decision: **NO-GO**
- Blockers:
  - INCOMPLETE statuses present.
  - Scenario coverage incomplete (4/2/5 not executed).
- Status counts:
  - PASS: 3
  - FAIL: 0
  - INCONCLUSIVE: 0
  - INCOMPLETE: 4

## Isolation Check (Primary Purpose of V5)

- Result: **PASS**
- Evidence:
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5/scenario3/front-yard-option-a.svg`
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5/scenario3/front-yard-option-b.svg`
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5/scenario3/diff-snap1-snap2.txt`
- Rationale: preview SVG writes occurred inside the scenario directory (no repo-root leakage observed).

## Partial Matrix

| Scenario | Invariant | Status | Confidence | open_target_verified | Evidence | Rationale |
|---|---|---|---|---|---|---|
| 3 | Pre-approval canonical unchanged | PASS | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5/scenario3/diff-snap0-snap1.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5/scenario3/diff-snap1-snap2.txt` | No canonical writes before approval turn. |
| 3 | Preview SVGs created pre-approval | PASS | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5/scenario3/diff-snap1-snap2.txt` | Two preview option SVGs were added pre-approval. |
| 3 | Open behavior browser vs Illustrator/editor | PASS | High | PASS | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5/scenario3/process-after-turn2.csv`, `docs/testing/results/archive/open-target-evidence-2026-02-20.md` | User screenshots confirm `front-yard-option-a.svg` and `front-yard-option-b.svg` opened in Chrome from scenario3 path. |
| 3 | Post-approval canonical save behavior | INCOMPLETE | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5/scenario3/turn3.txt` | Approval/save turn did not complete due usage interruption. |
| 4 | All invariants | INCOMPLETE | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5` | Scenario not executed due early interruption. |
| 2 | All invariants | INCOMPLETE | High | n/a | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5` | Scenario not executed due early interruption. |
| 5 | All invariants | INCOMPLETE | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5` | Scenario not executed due early interruption. |

## Conclusion

- V5 successfully validates the runner isolation hardening.
- V5 cannot be used as the final targeted gate because it is incomplete.
- Next authoritative run should restart targeted sequence as `garden-bot-retest-20260219-targeted-v6`.





