# Checkpoint 6 Go Packet (Post-Reset Execution)

Date: 2026-02-19  
Status: Historical (superseded by `dev/plans/2026-02-20-checkpoint6-go-packet.md`).

## Canonical Plan References

- Evidence inventory:
  - `dev/testing/results/retest-evidence-inventory-2026-02-19.md`
- Severity matrix:
  - `dev/testing/results/retest-severity-matrix-2026-02-19-checkpoint2.md`
- Root-cause map:
  - `dev/testing/results/retest-root-cause-map-2026-02-19-checkpoint3.md`
- Improvement plan:
  - `dev/plans/2026-02-19-checkpoint4-improvement-plan.md`
- Retest execution matrix:
  - `dev/plans/2026-02-19-checkpoint5-retest-matrix.md`

## Current Constraints

- Treat pre-fix v2/v3 behavior findings as provisional where isolation might matter.
- Use only isolation-safe reruns (`plugin-under-test` + `--add-dir`).
- Keep Bitter Lesson posture: structural/gating changes over domain expansion.

## Immediate Execution Steps (after reset)

1. Run targeted rerun (fresh after v5 interruption):
1. Run targeted rerun (fresh after v6 interruption):

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode targeted `
  -RunName garden-bot-retest-20260219-targeted-v7
```

2. Produce targeted matrix:
- `dev/testing/results/retest-matrix-2026-02-19-targeted-v6.md`
- Must include `PASS/FAIL/INCONCLUSIVE/INCOMPLETE`, confidence, and `open_target_verified`.

3. If targeted gate passes, run full harness:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode full `
  -RunName garden-bot-retest-20260219-full-v1
```

4. Produce full matrix:
- `dev/testing/results/retest-matrix-2026-02-19-full-v1.md`

## Required Human Evidence

For design scenarios (3/4/5), capture one user-observed artifact per scenario confirming actual app used to open SVG:
- screenshot or short note,
- include path + app observed.

## Stop/No-Go Conditions

- Any `INCOMPLETE` due runtime/usage.
- Any high-severity `FAIL`.
- `Saved:` claim/file-diff mismatch.
- SVG open observed in Illustrator/editor instead of browser.

## Latest Run Notes

- Targeted v4 finished but had working-directory leakage risk; keep as provisional for write-path conclusions.
- Runner was hardened in `dev/testing/scripts/retest-runner.ps1` to execute Claude turns in scenario working directories.
- Targeted v5 confirmed scenario-local writes, but stopped at usage cap during `scenario3/turn3`.
- User-provided screenshots now confirm Scenario 3 preview SVGs opened in Chrome; see:
  - `dev/testing/results/open-target-evidence-2026-02-20.md`
- Targeted v6 also stopped at `scenario3/turn3` due usage cap; reset message now indicates **Feb 23, 4pm (America/Los_Angeles)**.
- v6 revealed that failed turns can still produce partial writes; runner now captures post-failure snapshot/diff automatically.

## Commit Readiness Criteria

- Targeted + full matrices completed.
- No unresolved high-severity fails.
- All evidence paths present and auditable.
- Handoff docs updated with final outcomes.
