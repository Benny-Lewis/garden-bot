# Retest Matrix - Targeted V10

Date: 2026-02-21  
Run: `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10`  
Mode: targeted

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
  - PASS: 13
  - FAIL: 0
  - INCONCLUSIVE: 0
  - INCOMPLETE: 0

## Matrix

| Scenario | Invariant | Status | Confidence | open_target_verified | Evidence | Rationale |
|---|---|---|---|---|---|---|
| 3 | Pre-approval gating and preview path discipline | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario3/diff-snap0-snap1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario3/diff-snap1-snap2.txt` | Canonical files unchanged before approval; preview files only under `areas/`. |
| 3 | Post-approval canonical writes and persistence | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario3/diff-snap2-snap3.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario3/turn3.txt` | Approved turn wrote canonical layout + area/plants/calendar/log updates. |
| 3 | Turn-level `Saved:` contract (turn1-3) | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario3/saved-contract-turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario3/saved-contract-turn2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario3/saved-contract-turn3.txt` | All scenario3 turns satisfy final-line contract. |
| 3 | Open behavior browser vs Illustrator/editor | PASS | Medium | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario3/open-evidence.md`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario3/process-after-turn1.csv` | User confirmed scenario3 preview opened in Chrome; open evidence updated from follow-up confirmation. |
| 4 | Design modification integrity and approval gating | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario4/diff-snap0-snap1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario4/diff-snap1-snap2.txt` | Preview turn changed only preview file; approval turn changed canonical layout + area/log. |
| 4 | Turn-level `Saved:` contract (turn1-2) | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario4/saved-contract-turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario4/saved-contract-turn2.txt` | Both turns satisfy contract. |
| 4 | Open behavior browser vs Illustrator/editor | PASS | Medium | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario4/open-evidence.md`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario4/process-after-turn1.csv` | User confirmed scenario4 preview opened in Chrome; open evidence updated from follow-up confirmation. |
| 2 | Diagnosis flow + sourced persistence | PASS | Medium | n/a | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario2/turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario2/turn2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario2/diff-snap1-snap2.txt` | Clarifying questions were asked before diagnosis; follow-up actions persisted to files. |
| 2 | Turn-level `Saved:` contract (turn1-2) | PASS | High | n/a | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario2/saved-contract-turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario2/saved-contract-turn2.txt` | Previous turn1 contract failure is resolved. |
| 5 | Two-option preview then approved-option-only save | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario5/diff-snap0-snap1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario5/diff-snap2-snap3.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario5/turn1.txt` | Preview options were produced before approval; canonical files saved only on approval turn. |
| 5 | Turn-level `Saved:` contract (turn1-3) | PASS | High | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario5/saved-contract-turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario5/saved-contract-turn2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario5/saved-contract-turn3.txt` | Previous turn1 contract failure is resolved. |
| 5 | Open behavior browser vs Illustrator/editor | PASS | Medium | PASS | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario5/open-evidence.md`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/scenario5/process-after-turn1.csv` | User confirmed scenario5 preview opened in Chrome; open evidence updated from follow-up confirmation. |
| Trigger smoke | Should-trigger / should-not-trigger routing checks | PASS | Medium | n/a | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/trigger-smoke/case1-garden-profile-should-trigger/turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/trigger-smoke/case2-garden-profile-should-not-trigger/turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/trigger-smoke/case3-garden-expert-should-trigger/turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/trigger-smoke/case4-garden-expert-should-not-trigger/turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/trigger-smoke/case5-landscape-design-should-trigger/turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v10/trigger-smoke/case6-landscape-design-should-not-trigger/turn1.txt` | Expected routing behavior was observed across all six smoke prompts, and each case satisfied the `Saved:` final-line contract. |

## Notes

- Required per-turn artifacts: `saved-contract-turn*.txt`.
- Required failure-path artifacts when present: `snap-failure-*.csv` and `diff-*-failure-vs-*.txt`.
- For scenarios 3/4/5, direct user-observed Chrome evidence was recorded in `open-evidence.md` on 2026-02-22.
