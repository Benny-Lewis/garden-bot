# Retest Matrix - Targeted V4

Date: 2026-02-20  
Run: `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4`  
Mode: targeted (`scenario3`, `scenario4`, `scenario2`, `scenario5`)

## Gate Result

- Targeted gate status: **FAIL**
- Reason: High-severity save/write invariants fail in scenarios 2, 3, and 5.
- Supersession note: This run was later found to have a runner working-directory leak (writes could land in repo root). Treat v4 write-path conclusions as provisional. See `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v5-partial.md` for the isolation fix validation.

## Gate Block

- Decision: **NO-GO**
- Blockers:
  - `FAIL` statuses present.
  - Run has known leakage caveat; write-path conclusions are provisional.
- Status counts:
  - PASS: 10
  - FAIL: 16
  - INCONCLUSIVE: 4
  - INCOMPLETE: 0

## Matrix

| Scenario | Invariant | Status | Confidence | open_target_verified | Evidence | Rationale |
|---|---|---|---|---|---|---|
| 2 | Reads garden state first when files exist | PASS | High | n/a | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/turn1.txt` | Turn 1 references Portland 8b profile and season context from seeded files. |
| 2 | Asks clarifying questions before final diagnosis | PASS | High | n/a | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/turn1.txt` | Turn 1 asks 5 follow-ups and explicitly waits for answers. |
| 2 | Uses sources/citations for diagnosis | FAIL | High | n/a | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/turn2.txt` | No cited URLs or source section appears in final diagnosis turn. |
| 2 | Persists diagnosis/actions to files | FAIL | High | n/a | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/diff-snap1-snap2.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/turn2.txt` | Turn 2 claims saves, but tracked diff is `NO_CHANGES`. |
| 2 | Writes time-based follow-ups to `calendar.md` | FAIL | High | n/a | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/diff-snap1-snap2.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/calendar.md` | Calendar follow-ups are described in text but no file delta is recorded. |
| 2 | Ends with strict final-line `Saved:` | PASS | High | n/a | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/turn2.txt` | Final line is a single-line `Saved:` statement. |
| 2 | `Saved:` claim matches actual file diffs | FAIL | High | n/a | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/turn2.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/diff-snap1-snap2.txt` | Claimed touched files do not match observed `NO_CHANGES`. |
| 3 | Produces SVG preview layout(s) before approval | FAIL | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/turn2.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/diff-snap1-snap2.txt` | Turn 2 does not include layout output and no preview file changes are detected. |
| 3 | Pre-approval changes are preview-only; canonical unchanged | INCONCLUSIVE | Medium | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/diff-snap0-snap1.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/diff-snap1-snap2.txt` | Canonical remained unchanged, but previews were not created either, so gating behavior is not fully exercised. |
| 3 | Presents layout and gets feedback before save | FAIL | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/turn2.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/turn3.txt` | No meaningful preview presentation in turn 2; turn 3 jumps to claimed save. |
| 3 | Leads with targeted spatial questions after showing layout | FAIL | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/turn1.txt` | Turn 1 asks baseline discovery questions instead of using existing area context and previewing first. |
| 3 | If future tasks are mentioned, writes concrete `calendar.md` entries | FAIL | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/turn3.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/diff-snap2-snap3.txt` | Future actions are described, but no calendar file changes are observed. |
| 3 | After approval, writes canonical `{area-name}-layout.svg` and updates area file link | FAIL | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/turn3.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/diff-snap2-snap3.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/areas/front-yard.md` | Turn 3 claims full save, but no tracked writes occurred and no layout file is present under scenario workspace. |
| 3 | Ends with strict final-line `Saved:` | PASS | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/turn3.txt` | Final line is single-line `Saved:`. |
| 3 | `Saved:` claim matches actual file diffs | FAIL | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/turn3.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/diff-snap2-snap3.txt` | Claimed canonical writes conflict with `NO_CHANGES`. |
| 3 | Open behavior is browser (Chrome/fallback), not Illustrator/editor | INCONCLUSIVE | Medium | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/environment-check.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/process-after-turn2.csv` | Chrome process deltas exist, but no user artifact proving the intended SVG opened in browser; host association still points to Illustrator. |
| 4 | Regenerates visual immediately to reflect requested changes | FAIL | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario4/turn1.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario4/diff-snap0-snap1.txt` | Turn 1 rejects request as mismatched context and no preview regeneration/write occurs. |
| 4 | Pre-approval is preview-only (no canonical writes) | PASS | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario4/diff-snap0-snap1.txt` | Canonical files remained unchanged before approval. |
| 4 | Post-approval canonical files update correctly | FAIL | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario4/turn2.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario4/diff-snap1-snap2.txt` | Approval turn still produces no writes. |
| 4 | No unrequested committed features | PASS | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario4/diff-snap1-snap2.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario4/areas/backyard-south.md` | No modifications were committed. |
| 4 | Appends log when committing design changes | FAIL | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario4/diff-snap1-snap2.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario4/log/2026-02.md` | No appended log entry because no save occurred. |
| 4 | Ends with strict final-line `Saved:` | PASS | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario4/turn2.txt` | Final line is single-line `Saved:`. |
| 4 | Open behavior is browser (Chrome/fallback), not Illustrator/editor | INCONCLUSIVE | Medium | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/environment-check.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario4/process-after-turn1.csv` | Chrome process appears, but no proof that intended SVG opened in browser and no user screenshot/note artifact. |
| 5 | Provides 2 viable options with tradeoffs before save | PASS | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/turn2.txt` | Turn 2 contains Option A/B with explicit tradeoffs. |
| 5 | Translates style terms into concrete spatial/material choices | PASS | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/turn2.txt` | Turn 2 maps style intent to path, groundcover, hardscape, and plant placement. |
| 5 | Preview-only files before approval | FAIL | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/turn2.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/diff-snap1-snap2.txt` | Turn 2 claims preview SVG saves, but no file changes are present. |
| 5 | Saves only approved option after approval | FAIL | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/turn3.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/diff-snap2-snap3.txt` | Turn 3 claims canonical save and file updates, but tracked diff is `NO_CHANGES`. |
| 5 | Ends with strict final-line `Saved:` | PASS | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/turn3.txt` | Final line is single-line `Saved:`. |
| 5 | `Saved:` claim matches actual file diffs | FAIL | High | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/turn3.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/diff-snap2-snap3.txt` | Claimed writes do not match `NO_CHANGES`. |
| 5 | Open behavior is browser (Chrome/fallback), not Illustrator/editor | INCONCLUSIVE | Medium | INCONCLUSIVE | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/environment-check.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/process-after-turn1.csv`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/turn2.txt` | Text claims Chrome open and process deltas show Chrome, but no user-confirmed artifact and no saved SVG files in scenario workspace. |

## Notes

- No `INCOMPLETE` statuses: run finished.
- `open_target_verified` remains unresolved for design scenarios due missing direct user-observed artifact.
- Host `.svg` user association still indicates Illustrator in environment check.

