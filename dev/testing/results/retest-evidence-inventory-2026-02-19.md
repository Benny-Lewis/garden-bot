# Retest Evidence Inventory (Checkpoint 1)

Date: 2026-02-19  
Scope: Current available evidence before usage reset.

## Reliability Legend

- High: direct artifact proving a claim (file diffs/snapshots, static config facts).
- Medium: suggestive but not deterministic (process lists, conversational claims).
- Low: run conditions likely contaminated or interrupted.

## Core Evidence Sets

1. `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2`
2. `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v3`
3. `dev/testing/results/retest-matrix-2026-02-19-partial.md`
4. `dev/plans/2026-02-19-session-handoff.md`
5. `dev/plans/2026-02-19-usage-reset-handoff.md`

## Critical Run-Condition Caveat

At the time v2/v3 were executed, the runner had not yet applied final isolation hardening.  
Specifically, `claude -p` calls did not yet include the final per-scenario access isolation (`--add-dir`) and run-local plugin bundle copy. This means:

- isolation-sensitive findings are medium/low confidence until rerun;
- deterministic root-cause attribution should wait for post-fix rerun.

The runner has since been updated to address this:
- `dev/testing/scripts/retest-runner.ps1` now builds `plugin-under-test` and passes `--add-dir <scenarioDir>`.

## Evidence Index

| Artifact | What it demonstrates | Reliability | Notes |
|---|---|---|---|
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario2/turn1.txt` | Model claimed no profile/setup and asked baseline questions. | Medium | Could be impacted by run-isolation issue. |
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario2/turn2.txt` | Claimed successful saves with cited sources. | Medium | Needs reconciliation with file diffs. |
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario2/diff-snap1-snap2.txt` | `NO_CHANGES` despite save claim. | High | Direct contradiction in scenario snapshot evidence. |
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario4/diff-snap0-snap1.txt` | Pre-approval changed preview file only. | High | Strong gating signal in this run. |
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario4/diff-snap1-snap2.txt` | Post-approval canonical files updated and preview removed. | High | Strong canonical-save signal in this run. |
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario4/turn2.txt` | `Saved:` formatting used multi-line block, not strict single-line final format. | High | Direct contract mismatch in output text. |
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario5/turn1.txt` | Requested dimensions instead of delivering 2 options. | Medium | Could be context/isolation sensitivity. |
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario5/turn2.txt` | Reported context compression/lost context. | Medium | Indicates stability issue but not root cause. |
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario5/diff-snap*.txt` | No scenario files changed in run path. | High | Direct file-level evidence. |
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/environment-check.txt` | `.svg` association points to Illustrator; Chrome installed. | High | Static host facts from registry/path checks. |
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario3/process-*.csv` | Chrome process deltas occurred in some turns. | Medium | Does not prove correct file open target/tab. |
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/turn1.txt` | Referenced unrelated tomato/early blight context. | Low | Strong sign of contamination under pre-fix runner. |
| `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/turn3.txt` | Usage cap interruption message. | High | Direct blocker evidence. |
| `dev/testing/scripts/retest-runner.ps1` | Post-fix test harness now includes isolation hardening and explicit scenario access. | High | Current source of truth for next rerun. |

## Inventory Conclusion

- We have enough evidence to do a meaningful severity analysis now.
- We should treat v2/v3 results as provisional where isolation may matter.
- Final pass/fail certification must come from a rerun using the updated runner.
