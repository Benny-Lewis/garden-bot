# Retest Root-Cause Map (Checkpoint 3)

Date: 2026-02-19  
Inputs:
- `dev/testing/results/retest-severity-matrix-2026-02-19-checkpoint2.md`
- `skills/landscape-design/SKILL.md`
- `skills/garden-expert/SKILL.md`
- `dev/testing/scripts/retest-runner.ps1`
- `dev/testing/regression-harness.md`

## Scope Policy

- Root causes are split into:
  - **Actionable now** (high-confidence, isolation-independent),
  - **Deferred** (requires isolation-safe rerun for confidence).

## Actionable Now: Root Causes

| Issue | Likely Root Cause | Confidence | Minimal-change implication |
|---|---|---|---|
| Strict `Saved:` contract drift (multi-line block or variant forms) | Contract exists, but too permissive and not reinforced by test assertions for exact shape in all scenarios. | High | Keep single-line final-line rule and add deterministic validator in analysis/retest pipeline; fail fast on non-conforming final line. |
| Windows open behavior uncertainty (Illustrator default association) | Instruction says prefer Chrome, but host-level association can still win unless open action is explicit; current verification is indirect. | High | Keep Windows Chrome-direct rule; add stronger evidence step (app-target confirmation) in harness procedure. |
| Open verification not deterministic | Current harness captures process snapshots, which prove process activity but not that the intended SVG file opened in the intended app. | High | Extend test evidence method to include explicit user confirmation artifact per open check (screenshot/note), not just process deltas. |
| Incomplete-run interpretation risk | Usage cap interruption is treated as scenario failure in some rows without explicit “incomplete” guardrail. | Medium | Add explicit “INCOMPLETE (usage/runtime)” status class in matrix template and exclude from fail counts. |

## Deferred: Root Causes (need isolation-safe rerun)

| Issue (provisional) | Likely Root Cause Candidates | Confidence now | Why deferred |
|---|---|---|---|
| Read-before-ask misses | Could be instruction precedence gap, but also consistent with context contamination from pre-fix runner scope. | Low-Med | Needs rerun with `plugin-under-test` + `--add-dir` isolation to separate model behavior from setup artifacts. |
| Save-claim vs no file changes | Could indicate false save claims, or writes outside tracked scenario path under old run setup. | Low-Med | Must rerun under corrected isolation to verify true write location/behavior. |
| Scenario 3 preview described but absent | Could be tool-write/open failure, or path leakage/permissions under pre-fix run. | Low | Rerun required before policy change. |
| Scenario 5 lost context behavior | Could reflect conversation compression artifact under unstable session context rather than skill logic. | Low | Rerun required with stable isolated session. |

## Cross-Cutting Root-Cause Themes

1. **Measurement over assumption**
- Several findings were weak because instrumentation proved “something happened” but not “the intended action happened.”
- Fix direction: upgrade evidence quality, not instruction volume.

2. **Contract enforceability**
- Natural-language rules (`Saved:` shape, app choice) need corresponding deterministic checks in the retest workflow.
- Fix direction: add explicit validation steps to harness/matrix process.

3. **Isolation first**
- Behavior conclusions are only as good as test isolation.
- Fix direction: treat pre-fix runs as directional, post-fix reruns as authoritative.

## Checkpoint 3 Outcome

- We have enough cause clarity to define a minimal, high-leverage improvement plan.
- No domain-knowledge expansion is justified at this stage.
