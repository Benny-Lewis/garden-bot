# Retest Severity Matrix (Checkpoint 2)

Date: 2026-02-19  
Scope: Evidence-driven issues from currently available runs, filtered for isolation confidence.

## Decision Rule Used

- Actionable now: high-confidence and not dependent on pre-fix test isolation.
- Deferred: potentially affected by pre-fix isolation; rerun required before final judgment.

## Actionable Now (Prioritized)

| Priority | Severity | Issue | Evidence | Why this matters |
|---|---|---|---|---|
| P0 | High | Test validity blocker: v2/v3 results are partly contaminated by pre-fix isolation model. | `dev/testing/results/retest-evidence-inventory-2026-02-19.md` | Without isolation-safe rerun, many behavior conclusions are unreliable. |
| P0 | High | `Saved:` output contract is not consistently strict single-line final format. | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario4/turn2.txt` | Breaks deterministic parsing and trust contract for downstream verification. |
| P1 | Medium | Windows open behavior remains risky because `.svg` association points to Illustrator while Chrome is installed. | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/environment-check.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v3/environment-check.txt` | User experience can diverge from requirement (browser review vs heavy design app). |
| P1 | Medium | Current open verification method is suggestive, not deterministic (process delta only). | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario3/process-before-turn1.csv`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario3/process-after-turn1.csv` | We cannot prove which app opened the target SVG per turn with high confidence. |
| P2 | Low | Harness interruption handling needs explicit rerun-state semantics in analysis outputs. | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/turn3.txt` | Prevents accidental over-interpretation of partial runs as full failures. |

## Deferred Until Isolation-Safe Rerun

| Severity (provisional) | Issue | Evidence | Deferral reason |
|---|---|---|---|
| High (provisional) | Read-before-ask failures in diagnosis/design flows. | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario2/turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/turn1.txt` | Could be contaminated by pre-fix runner scope/context leakage. |
| High (provisional) | Save-claim vs file-change mismatch (`Saved:` claims with `NO_CHANGES`). | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario2/turn2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario2/diff-snap1-snap2.txt` | Could be affected by writes occurring outside scenario path under old run setup. |
| Medium (provisional) | Scenario 3 previews described but not written in scenario workspace. | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/turn2.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v3/scenario3/diff-snap1-snap2.txt` | Pre-fix isolation means missing files may not reflect real behavior under corrected runner. |
| Medium (provisional) | Scenario 5 option flow collapsed into context-recovery behavior. | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario5/turn1.txt`, `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario5/turn2.txt` | High chance this is session/run-context artifact. |
| Low (provisional) | Some `Saved: none (...)` variants deviate from strict normalized form. | `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2/scenario5/turn1.txt` | Needs confirmation under corrected runner and updated skill wording. |

## Minor Improvement Opportunities

- Add explicit “confidence” tag to every future matrix row (High/Medium/Low confidence).
- Add explicit “run validity” header to each result file (isolation-safe vs provisional).
- Record a short user-observed confirmation (screenshot or note) during open-behavior checks to complement process snapshots.

## Checkpoint 2 Summary

- Immediate focus should stay on:
  1. preserving strict output/save contracts,
  2. making open behavior deterministic on Windows,
  3. rerunning with corrected isolation before judging model behavior regressions.
