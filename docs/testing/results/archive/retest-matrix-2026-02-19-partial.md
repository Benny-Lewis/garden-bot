# Retest Matrix (Partial)

Date: 2026-02-19
Scope: Targeted retest evidence completed before usage-cap interruption.
Harness reference: `dev/testing/regression-harness.md`

Note: This partial matrix is superseded for planning by:
- `docs/testing/results/archive/retest-evidence-inventory-2026-02-19.md`
- `docs/testing/results/archive/retest-severity-matrix-2026-02-19-checkpoint2.md`
- `docs/testing/results/archive/retest-root-cause-map-2026-02-19-checkpoint3.md`

## Run Evidence Sets

- `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2`
- `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v3`

## Matrix

| Scenario | Invariant | Status | Evidence | Notes |
|---|---|---|---|---|
| 2 | Reads existing garden state first | Fail | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario2/turn1.txt` | Turn states no profile/setup despite seeded files. |
| 2 | Asks clarifying questions before final diagnosis | Pass | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario2/turn1.txt` | Clarifying questions were asked first. |
| 2 | Uses web sources with citations | Pass | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario2/turn2.txt` | Sources listed with URLs. |
| 2 | Persists diagnosis/actions to files | Fail | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario2/diff-snap1-snap2.txt` | Output claimed saves, but diff shows `NO_CHANGES`. |
| 2 | Time-based follow-ups written to `calendar.md` | Fail | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario2/calendar.md` | No calendar updates after final turn. |
| 2 | Final line strict `Saved:` | Fail | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario2/turn1.txt` | Turn 1 ends without required `Saved:` final line. |
| 3 | Produces SVG preview layout(s) before approval | Fail | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/turn2.txt` | Turn says previews should open, but no SVG files written. |
| 3 | Before approval, only preview files change | Inconclusive | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/diff-snap1-snap2.txt` | No files changed at all; cannot validate preview-vs-canonical behavior. |
| 3 | Gets feedback before saving canonical files | Inconclusive | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/turn3.txt` | Scenario interrupted by usage cap before save approval completed. |
| 3 | Reads known dimensions/profile before asking | Fail | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/turn1.txt` | Claims missing profile/front-yard while files existed; references unrelated tomato data. |
| 4 | Regenerates visual immediately | Pass | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario4/turn1.txt` | Turn indicates preview update and asks for adjustments. |
| 4 | Before approval, canonical files unchanged | Pass | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario4/diff-snap0-snap1.txt` | Only preview file added pre-approval. |
| 4 | After approval, canonical files updated | Pass | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario4/diff-snap1-snap2.txt` | Canonical SVG and area/calendar/log updated post-approval. |
| 4 | No unrequested committed features | Pass | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario4/turn1.txt` | Response appears limited to requested move/reduction. |
| 4 | Final line strict `Saved:` | Fail | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario4/turn2.txt` | Uses multi-line `Saved:` heading with bullets, not required single-line final format. |
| 5 | Provides 2 options with tradeoffs before saving | Fail | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario5/turn1.txt` | Turn did not provide options/tradeoffs. |
| 5 | Saves only approved option | Inconclusive | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario5/diff-snap2-snap3.txt` | No design outputs written; scenario did not reach valid option-selection flow. |
| 5 | Final line strict `Saved:` | Fail | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario5/turn2.txt` | Non-template explanatory `Saved: none` text; flow reports lost context. |
| Env | Chrome-first open behavior | Partial | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2/environment-check.txt` | Chrome installed; `.svg` system association still Illustrator. Process snapshots show Chrome running but do not prove deterministic open target per turn. |

## Blocking Condition

- Retest continuation blocked at scenario 3 turn 3 by usage cap:
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/turn3.txt`

## Next Execution Step

- Re-run targeted sequence with the updated isolated plugin bundle in `dev/testing/scripts/retest-runner.ps1` after usage resets, then regenerate a full matrix and run full harness 1-5.

