# Checkpoint 6 Go Packet (Analysis Cycle 2026-02-20)

Date: 2026-02-20  
Status: Usage-blocked after attempted `targeted-v7`; resume after reset window.

## Canonical Docs (Use in This Order)

1. `docs/testing/results/archive/retest-evidence-lock-2026-02-20.md`
2. `docs/testing/results/archive/retest-issue-matrix-2026-02-20-checkpoint2.md`
3. `docs/testing/results/archive/retest-root-cause-map-2026-02-20-checkpoint3.md`
4. `docs/plans/archive/2026-02-20-checkpoint4-improvement-plan.md`
5. `docs/plans/archive/2026-02-20-checkpoint5-retest-plan.md`
6. `docs/plans/archive/2026-02-20-usage-block-handoff.md`
7. `docs/plans/archive/2026-02-20-commit-plan.md`
8. `docs/testing/results/active/anthropic-guidance-compliance-2026-02-20.md`
9. `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v7.md`

## Immediate Actions on Resume

1. Run targeted rerun:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode targeted `
  -RunName garden-bot-retest-20260219-targeted-v8
```

2. Produce:
- `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v8.md`

3. If targeted gate passes, run full harness:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode full `
  -RunName garden-bot-retest-20260219-full-v1
```

4. Produce:
- `docs/testing/results/active/retest-matrix-2026-02-19-full-v1.md`

## Track A Status

Track A structural fixes from `docs/plans/archive/2026-02-20-checkpoint4-improvement-plan.md` are implemented:
- deterministic `saved-contract-turn*.txt` artifacts,
- failure snapshot/diff capture with predictable naming,
- `open-evidence.md` stubs for design scenarios,
- UTF-8 output defaults,
- normalized `areas/` path convention in landscape skill + regression harness,
- matrix gate-block template added.
- runner launchability hardened to resolve local `claude.exe` paths.

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

