# Retest Matrix - Full V1

Date: 2026-02-22  
Run: `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1`  
Mode: full

## Run Validity

- Status: **COMPLETE**
- Interruption point: n/a
- Interruption evidence: n/a
- Message: run completed with `CLAUDE_CODE_MAX_OUTPUT_TOKENS=8192`.

## Gate Block

- Decision: **GO**
- Blockers:
  - None.
- Status counts:
  - PASS: 14
  - FAIL: 0
  - INCONCLUSIVE: 0
  - INCOMPLETE: 0

## Matrix

| Scenario | Invariant | Status | Confidence | open_target_verified | Evidence | Rationale |
|---|---|---|---|---|---|---|
| 1 | Conversation-first setup before file creation | PASS | High | n/a | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario1/diff-snap0-snap1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario1/turn1.txt` | Turn1 asked clarifying setup questions and wrote no files. |
| 1 | Profile/area/calendar/log persistence after context | PASS | High | n/a | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario1/diff-snap1-snap2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario1/turn2.txt` | Turn2 created expected baseline files after user context. |
| 2 | Diagnosis discipline + source-backed persistence | PASS | Medium | n/a | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario2/turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario2/turn2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario2/plants/tomatoes-2026.md` | Turn1 waited for clarifications; turn2 persisted treatment and included extension-source URLs in saved files. |
| 2 | Turn-level `Saved:` contract (turn1-2) | PASS | High | n/a | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario2/saved-contract-turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario2/saved-contract-turn2.txt` | Both turns satisfy strict final-line contract. |
| 3 | Preview-only writes before approval | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario3/diff-snap0-snap1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario3/diff-snap1-snap2.txt` | No changes on turn1; turn2 adds only preview SVG options under `areas/`. |
| 3 | Canonical and persistence writes only after approval | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario3/diff-snap2-snap3.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario3/turn3.txt` | Approval turn writes canonical layout + area/plants/calendar/log updates. |
| 3 | Turn-level `Saved:` contract (turn1-3) | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario3/saved-contract-turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario3/saved-contract-turn2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario3/saved-contract-turn3.txt` | All scenario3 turns satisfy strict final-line contract. |
| 3 | Open behavior browser vs Illustrator/editor | PASS | Medium | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario3/open-evidence.md`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario3/process-after-turn1.csv` | User screenshots show full-scenario3 SVGs open in Chrome (`[Image #1]`, `[Image #2]`, `[Image #3]`). |
| 4 | Modification integrity + approval gating | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario4/diff-snap0-snap1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario4/diff-snap1-snap2.txt` | Preview generated pre-approval; approval turn updates canonical files with requested fire pit/bed changes. |
| 4 | Turn-level `Saved:` contract (turn1-2) | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario4/saved-contract-turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario4/saved-contract-turn2.txt` | Both turns satisfy strict final-line contract. |
| 4 | Open behavior browser vs Illustrator/editor | PASS | Medium | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario4/open-evidence.md`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario4/process-after-turn1.csv` | User screenshot tab evidence shows full-scenario4 preview tab open in Chrome (`[Image #1]`). |
| 5 | Two-option preview then approved-option-only save | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario5/diff-snap0-snap1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario5/diff-snap1-snap2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario5/diff-snap2-snap3.txt` | No writes on turn1; preview options on turn2; canonical writes only on approval turn3. |
| 5 | Turn-level `Saved:` contract (turn1-3) | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario5/saved-contract-turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario5/saved-contract-turn2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario5/saved-contract-turn3.txt` | All scenario5 turns satisfy strict final-line contract. |
| 5 | Open behavior browser vs Illustrator/editor | PASS | Medium | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario5/open-evidence.md`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1/full-scenario5/process-after-turn1.csv` | User screenshot tab evidence shows full-scenario5 preview tabs open in Chrome (`[Image #1]`). |

## Notes

- Required per-turn artifacts: `saved-contract-turn*.txt`.
- Required failure-path artifacts when present: `snap-failure-*.csv` and `diff-*-failure-vs-*.txt`.
- For design scenarios in full mode, direct user-observed Chrome evidence was recorded on 2026-02-22 from provided screenshots.
