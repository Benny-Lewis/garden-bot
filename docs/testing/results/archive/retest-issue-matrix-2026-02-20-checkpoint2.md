# Retest Issue Matrix (Checkpoint 2)

Date: 2026-02-20  
Input baseline: `docs/testing/results/archive/retest-evidence-lock-2026-02-20.md`

## Severity Scale

- `P0` Critical: blocks trustworthy certification or risks incorrect persisted state.
- `P1` High: strong functional contract risk.
- `P2` Medium: quality/instrumentation weakness that can mask regressions.
- `P3` Low: minor clarity/usability/consistency improvements.

## Issue Matrix (Ranked)

| ID | Priority | Type | Confidence | Evidence Class | Issue | Evidence | Impact | Disposition |
|---|---|---|---|---|---|---|---|---|
| I-01 | P0 | Failure | High | A | Usage interruptions prevent completion of authoritative targeted suite (scenarios 4/2/5 not executed post-fix). | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5/scenario3/turn3.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/turn3.txt` | Cannot certify behavior gates or decide release readiness. | Must address in retest execution strategy (resume only after confirmed usage window). |
| I-02 | P0 | Failure | High | A | Failed turns can still perform partial canonical writes before non-zero exit. | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/diff-snap2-current-after-failed-turn3.txt` | Data-integrity risk: run marked failed can still mutate canonical artifacts. | Must harden failure-path detection and treat interrupted turns as potentially mutating. |
| I-03 | P0 | Failure | High | B | Targeted-v4 write-path conclusions were contaminated by working-directory leakage. | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/leakage-artifacts/`, `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v4.md` | v4 write assertions are unreliable for final judgments. | Rerun required; use v4 only as bounded directional signal. |
| I-04 | P1 | Gap | High | A | Open-target verification is complete for scenario3 only; scenarios 4/5 still lack direct user-observed open evidence. | `docs/testing/results/archive/open-target-evidence-2026-02-20.md`, `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v5-partial.md` | Browser-open contract remains partially unproven. | Collect explicit screenshot/note evidence per design scenario in next run. |
| I-05 | P1 | Hypothesis | Medium-High | B | Potential save-claim/file-diff mismatch in scenario2 diagnosis flow. | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/turn2.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/diff-snap1-snap2.txt` | If true post-fix, violates persistence and trust contract. | Re-verify in authoritative rerun (cannot close from v4). |
| I-06 | P1 | Hypothesis | Medium-High | B | Potential save-claim/file-diff mismatch in scenario3 approval flow. | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/turn3.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario3/diff-snap2-snap3.txt` | If true post-fix, canonical save contract is broken. | Re-verify in authoritative rerun. |
| I-07 | P1 | Hypothesis | Medium-High | B | Potential save-claim/file-diff mismatch in scenario5 approval flow. | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/turn3.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario5/diff-snap2-snap3.txt` | If true post-fix, approved-option save behavior is unreliable. | Re-verify in authoritative rerun. |
| I-08 | P1 | Hypothesis | Medium | B | Scenario2 diagnosis response may omit required citation/source evidence. | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario2/turn2.txt` | Could violate sourcing invariant even when diagnosis appears plausible. | Re-verify in authoritative rerun. |
| I-09 | P1 | Hypothesis | Medium | B | Scenario4 modification turn may fail to engage existing backyard context and regenerate requested visual. | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/scenario4/turn1.txt` | Could regress modification integrity flow. | Re-verify in authoritative rerun. |
| I-10 | P2 | Improvement | Medium | A | Preview SVG path convention is inconsistent across runs (`scenario root` vs `areas/`). | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5/scenario3/diff-snap1-snap2.txt`, `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v6/scenario3/diff-snap1-snap2.txt` | Increases parser complexity and test brittleness. | Standardize preview filename/location convention. |
| I-11 | P2 | Improvement | Medium | A/B | Host default `.svg` association remains Illustrator despite Chrome availability. | `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v6/environment-check.txt` | If explicit Chrome open path fails, UX can regress to heavy editor app. | Keep explicit browser-launch rule and keep validating user-observed open target. |
| I-12 | P2 | Improvement | Medium | A | Process snapshots are suggestive but not deterministic for open-target validation without user artifacts. | `process-*.csv` in v5/v6, plus evidence lock policy | Can produce false confidence for app-open behavior. | Maintain requirement for user-observed artifact per design scenario. |
| I-13 | P3 | Improvement | High | A | Console encoding artifacts (`Ã‚Â·`) appear in interruption lines. | `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v5-partial.md`, `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v6-partial.md` | Minor readability/noise issue in archived outputs. | Normalize encoding in reporting output pipeline. |
| I-14 | P3 | Improvement | High | A | Interrupted-run matrices currently require manual interpretation for gate logic. | `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v5-partial.md`, `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v6-partial.md` | Slower operator decisions; higher chance of inconsistent calls. | Add explicit gate summary block (`GO/NO-GO`) to partial matrix template. |

## Coverage Summary

- Confirmed critical blockers: `I-01`, `I-02`, `I-03`.
- High-priority behavior concerns requiring authoritative rerun confirmation: `I-05` to `I-09`.
- Instrumentation/UX quality improvements: `I-10` to `I-14`.

## Checkpoint 2 Outcome

- We now have a complete ranked issue list from critical failures through minor improvements.
- Next step is root-cause mapping by layer (skill, harness, runtime/usage, host/open behavior).

