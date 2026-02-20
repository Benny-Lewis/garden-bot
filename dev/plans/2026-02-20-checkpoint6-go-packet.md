# Checkpoint 6 Go Packet (Analysis Cycle 2026-02-20)

Date: 2026-02-20  
Status: Ready to resume execution after usage reset window.

## Canonical Docs (Use in This Order)

1. `dev/testing/results/retest-evidence-lock-2026-02-20.md`
2. `dev/testing/results/retest-issue-matrix-2026-02-20-checkpoint2.md`
3. `dev/testing/results/retest-root-cause-map-2026-02-20-checkpoint3.md`
4. `dev/plans/2026-02-20-checkpoint4-improvement-plan.md`
5. `dev/plans/2026-02-20-checkpoint5-retest-plan.md`
6. `dev/plans/2026-02-20-usage-block-handoff.md`
7. `dev/plans/2026-02-20-commit-plan.md`

## Immediate Actions on Resume

1. Run targeted rerun:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode targeted `
  -RunName garden-bot-retest-20260219-targeted-v7
```

2. Produce:
- `dev/testing/results/retest-matrix-2026-02-19-targeted-v7.md`

3. If targeted gate passes, run full harness:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode full `
  -RunName garden-bot-retest-20260219-full-v1
```

4. Produce:
- `dev/testing/results/retest-matrix-2026-02-19-full-v1.md`

## Track A Status

Track A structural fixes from `dev/plans/2026-02-20-checkpoint4-improvement-plan.md` are implemented:
- deterministic `saved-contract-turn*.txt` artifacts,
- failure snapshot/diff capture with predictable naming,
- `open-evidence.md` stubs for design scenarios,
- UTF-8 output defaults,
- normalized `areas/` path convention in landscape skill + regression harness,
- matrix gate-block template added.

## Non-Negotiable Constraints

- Keep `skills/landscape-design/SKILL.md` under 500 words.
- Preserve SVG workflow and draft-vs-canonical save gating.
- Keep strict final-line `Saved:` contract.
- Do not revert unrelated user changes.

## Stop / No-Go Conditions

1. Any `INCOMPLETE`.
2. Any `Saved:` claim/diff mismatch.
3. Missing direct open-target evidence for scenarios 3/4/5.
4. Any unresolved `P0/P1` after targeted rerun.

## Human Evidence Required

Per design scenario (3/4/5), capture one artifact proving opened app:
- opened file path,
- observed app (Chrome/fallback browser vs editor/design app),
- timestamp,
- screenshot reference or note.
