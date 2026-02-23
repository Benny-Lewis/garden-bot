# Architecture

## Repository Layout

- `.claude-plugin/plugin.json`: plugin metadata.
- `skills/`: skill instructions.
  - `skills/garden-profile/SKILL.md`
  - `skills/garden-expert/SKILL.md`
  - `skills/landscape-design/SKILL.md`
- `dev/testing/scripts/retest-runner.ps1`: regression runner automation.
- `dev/testing/regression-harness.md`: scenario/invariant specification.
- `dev/testing/runs/`: run artifacts (live + archived).
- `docs/`: canonical project documentation.

## Runtime Components

1. Skill Instructions
- Define behavior constraints and persistence expectations.

2. Garden Workspace Data
- Runtime writes happen in the user's current working directory:
  - `profile.md`
  - `areas/`
  - `plants/`
  - `calendar.md`
  - `log/`

3. Regression Harness
- Executes fixed scenarios and records mutation evidence.
- Produces run artifacts under `dev/testing/runs/<date>/<run-name>/`.

4. Results Layer
- Matrices and signoff docs are tracked under `docs/testing/results/`.
- Active docs represent current gate truth.

## Data and Evidence Flow

1. Edit skills/contracts/docs.
2. Run targeted regression for changed risk areas.
3. Run full regression before finalizing significant changes.
4. Capture open-evidence for design scenarios (3/4/5).
5. Update matrix and final signoff docs.

## Boundaries

- Skill files define behavior, not broad gardening encyclopedias.
- Contracts are normative in `docs/contracts.md`.
- `README.md` is user-first; contributor process lives in runbooks.
- Historical artifacts are retained but should not override active docs.

## Operational Entry Points

- Contributor onboarding: `CONTRIBUTING.md`
- Regression execution: `docs/runbooks/regression.md`
- Evidence capture: `docs/runbooks/evidence-capture.md`
