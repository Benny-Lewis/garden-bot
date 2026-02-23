# Contributing

## Purpose

This guide is for contributors maintaining skills, contracts, and regression quality.

## Workflow

1. Sync `main`.
2. Create a focused branch.
3. Implement minimal, structural changes.
4. Run targeted regression for changed risk areas.
5. Run full regression before finalizing significant behavior changes.
6. Update docs/contracts/runbooks when behavior or process changes.

## Commit Conventions

- Keep commits logically scoped.
- Use imperative commit messages.
- Do not mention "claude" in commit messages.

## Required Checks Before Merge

- Contract alignment with `docs/contracts.md`.
- Regression evidence completeness per `docs/runbooks/regression.md`.
- Open-target evidence completeness per `docs/runbooks/evidence-capture.md`.
- No stale or contradictory instructions between:
  - `README.md`
  - `CLAUDE.md`
  - canonical docs under `docs/`

## Documentation Expectations

If behavior, policy, or process changes:
- update `docs/contracts.md` if contract semantics changed,
- update relevant runbooks,
- update root summaries (`README.md`, `CLAUDE.md`) as needed,
- add a curated note in `docs/changelog.md`.

## Pull Request Checklist

- [ ] Scope is clear and minimal
- [ ] Tests/runs executed appropriate to risk
- [ ] Evidence artifacts included for regression-impacting changes
- [ ] Docs updated and links valid
- [ ] No contradictory contract language introduced

## Key References

- Overview: `docs/overview.md`
- Architecture: `docs/architecture.md`
- Contracts: `docs/contracts.md`
- Regression runbook: `docs/runbooks/regression.md`
- Evidence capture runbook: `docs/runbooks/evidence-capture.md`
