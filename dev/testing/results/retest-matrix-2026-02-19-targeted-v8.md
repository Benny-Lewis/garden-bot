# Retest Matrix - Targeted V8

Date: 2026-02-21  
Run: `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8`  
Mode: targeted

## Run Validity

- Status: **COMPLETE**
- Interruption point: n/a
- Interruption evidence: n/a
- Message: run completed after setting `CLAUDE_CODE_MAX_OUTPUT_TOKENS=8192`.

## Gate Block

- Decision: **NO-GO**
- Blockers:
  - `FAIL` on strict final-line `Saved:` contract in scenario2 turn1 and scenario5 turn1.
  - `INCONCLUSIVE` open-target verification for scenarios 3/4/5 (`open-evidence.md` remains pending user-observed proof).
  - Trigger smoke section was not executed in this run.
- Status counts:
  - PASS: 7
  - FAIL: 2
  - INCONCLUSIVE: 3
  - INCOMPLETE: 1

## Matrix

| Scenario | Invariant | Status | Confidence | open_target_verified | Evidence | Rationale |
|---|---|---|---|---|---|---|
| 3 | Pre-approval gating and preview path discipline | PASS | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario3/diff-snap0-snap1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario3/diff-snap1-snap2.txt` | Before approval, only preview SVGs under `areas/` changed. |
| 3 | Post-approval canonical writes and persistence | PASS | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario3/diff-snap2-snap3.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario3/turn3.txt` | After approval, canonical layout + area/plants/calendar/log were saved. |
| 3 | Turn-level `Saved:` contract (turn1-3) | PASS | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario3/saved-contract-turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario3/saved-contract-turn2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario3/saved-contract-turn3.txt` | All scenario3 turns meet `Saved:` final-line contract. |
| 3 | Open behavior browser vs Illustrator/editor | INCONCLUSIVE | Medium | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario3/open-evidence.md`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario3/process-after-turn1.csv` | `open-evidence.md` remains `PENDING`; no direct user-observed proof recorded. |
| 4 | Design modification integrity and approval gating | PASS | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario4/diff-snap0-snap1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario4/diff-snap1-snap2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario4/turn1.txt` | Preview occurred before approval; canonical files updated only after approval with requested fire-pit/bed changes. |
| 4 | Turn-level `Saved:` contract (turn1-2) | PASS | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario4/saved-contract-turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario4/saved-contract-turn2.txt` | Both turns meet contract (`Saved: none...` then canonical save list). |
| 4 | Open behavior browser vs Illustrator/editor | INCONCLUSIVE | Medium | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario4/open-evidence.md`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario4/process-after-turn1.csv` | `open-evidence.md` remains `PENDING`; browser-open proof not user-confirmed. |
| 2 | Diagnosis flow + sourced persistence | PASS | Medium | n/a | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario2/turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario2/turn2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario2/diff-snap1-snap2.txt` | Turn1 asked clarifying questions after reading state; turn2 provided cited diagnosis and persisted actions. |
| 2 | Turn-level `Saved:` contract (turn1-2) | FAIL | High | n/a | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario2/saved-contract-turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario2/saved-contract-turn2.txt` | Turn1 ended without required `Saved:` final line. |
| 5 | Two-option preview then approved-option-only save | PASS | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario5/diff-snap1-snap2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario5/diff-snap2-snap3.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario5/turn2.txt` | Two preview options were shown pre-approval; canonical files saved only on approval turn. |
| 5 | Turn-level `Saved:` contract (turn1-3) | FAIL | High | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario5/saved-contract-turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario5/saved-contract-turn2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario5/saved-contract-turn3.txt` | Turn1 ended without required `Saved:` final line. |
| 5 | Open behavior browser vs Illustrator/editor | INCONCLUSIVE | Medium | INCONCLUSIVE | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario5/open-evidence.md`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8/scenario5/process-after-turn1.csv` | `open-evidence.md` remains `PENDING`; browser-open proof not user-confirmed. |
| Trigger smoke | Should-trigger / should-not-trigger routing checks | INCOMPLETE | High | n/a | `dev/testing/regression-harness.md`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v8` | Trigger smoke prompts were not executed in this runner pass. |

## Notes

- Required per-turn artifacts: `saved-contract-turn*.txt`.
- Required failure-path artifacts when present: `snap-failure-*.csv` and `diff-*-failure-vs-*.txt`.
- For scenarios 3/4/5, include `open-evidence.md` with direct user-observed proof.
