# Retest Matrix - Targeted V7

Date: 2026-02-20  
Run: `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v7`  
Mode: targeted (interrupted)

## Run Validity

- Status: **INCOMPLETE**
- Interruption point: `scenario3/turn1.txt`
- Interruption evidence: `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v7/scenario3/turn1.txt`
- Message: `You're out of extra usage Â· resets Feb 23, 4pm (America/Los_Angeles)`.

## Gate Block

- Decision: **NO-GO**
- Blockers:
  - `INCOMPLETE` statuses present.
  - Scenario coverage incomplete (4/2/5 not executed).
  - Open-target evidence unavailable because design turn did not complete.
- Status counts:
  - PASS: 1
  - FAIL: 0
  - INCONCLUSIVE: 1
  - INCOMPLETE: 5

## Matrix

| Scenario | Invariant | Status | Confidence | open_target_verified | Evidence | Rationale |
|---|---|---|---|---|---|---|
| 3 | Pre-approval canonical unchanged on interrupted turn1 | PASS | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v7/scenario3/diff-turn1-failure-vs-snap0.txt` | Failure diff is `NO_CHANGES`, so no file mutations occurred before interruption. |
| 3 | Turn-level `Saved:` contract outcome | INCOMPLETE | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v7/scenario3/saved-contract-turn1.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v7/scenario3/turn1.txt` | Interrupted usage turn is classified `INCOMPLETE` for certification even though artifact status is `FAIL`. |
| 3 | Open behavior browser vs Illustrator/editor | INCONCLUSIVE | Medium | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v7/scenario3/open-evidence.md`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v7/scenario3/process-before-turn1.csv` | No preview SVG/open action reached; user-observed open evidence remains pending. |
| 4 | All invariants | INCOMPLETE | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v7` | Not executed after interruption. |
| 2 | All invariants | INCOMPLETE | High | n/a | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v7` | Not executed after interruption. |
| 5 | All invariants | INCOMPLETE | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v7` | Not executed after interruption. |
| targeted-v7 | Harness launchability in current environment | INCOMPLETE | High | n/a | `dev/testing/scripts/retest-runner.ps1`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v7/scenario3/turn1.txt` | Runner now reaches Claude turn execution, but usage cap still blocks authoritative completion. |


