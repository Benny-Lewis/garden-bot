# Regression Runbook

This runbook is the canonical procedure for contributor regression runs.

## Preconditions

- Use a fresh Claude session for each run.
- Confirm plugin code is at intended commit.
- Confirm contracts: `docs/contracts.md`.
- Reference scenario invariants: `dev/testing/regression-harness.md`.

## Commands

Targeted mode:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 -Mode targeted -RunName garden-bot-retest-<date>-targeted-vN
```

Full mode:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 -Mode full -RunName garden-bot-retest-<date>-full-vN
```

Optional explicit run date folder:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 -Mode full -RunDate 2026-02-19 -RunName garden-bot-retest-20260219-full-vN
```

## Required Artifacts

Per turn:
- `saved-contract-turn*.txt`

Normal turn diffs:
- `diff-snap*.txt`

Failure/interruption turns:
- `snap-failure-*.csv`
- `diff-*-failure-vs-*.txt`

Design scenarios (3/4/5):
- `open-evidence.md` with direct user-observed proof
- supporting process snapshots as needed

## Post-Run Evaluation Procedure

1. Verify run completed (or explicitly mark interruption point).
2. Validate `Saved:` contract artifacts for all turns.
3. Validate design preview-vs-canonical gating behavior.
4. Validate open-target evidence for scenarios 3/4/5.
5. Build/update matrix in `docs/testing/results/active/` or `docs/testing/results/archive/` as appropriate.

## GO / NO-GO Decision Rule

Set explicit decision block with counts:
- PASS
- FAIL
- INCONCLUSIVE
- INCOMPLETE

Decision guidance:
- `GO` only when required invariants pass and no blocking evidence gaps remain.
- `NO-GO` when any blocker or unresolved evidence gap remains.

## Publication Steps

1. Update or create matrix doc.
2. Update open evidence docs if new user observations were captured.
3. Update final signoff when closing a major effort.
4. Update `docs/changelog.md` for notable process/contract milestones.

## Related Docs

- Contracts: `docs/contracts.md`
- Evidence capture: `docs/runbooks/evidence-capture.md`
- Harness scenarios: `dev/testing/regression-harness.md`
- Runs retention: `dev/testing/runs/README.md`
