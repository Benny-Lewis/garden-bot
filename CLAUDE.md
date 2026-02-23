# Garden-Bot Plugin

Claude Code plugin with 3 skills for gardening and landscaping assistance.

## Canonical Docs

- Overview: `docs/overview.md`
- Architecture: `docs/architecture.md`
- Contracts (normative): `docs/contracts.md`
- Regression runbook: `docs/runbooks/regression.md`
- Evidence runbook: `docs/runbooks/evidence-capture.md`
- Contributor workflow: `CONTRIBUTING.md`
- Docs index: `docs/README.md`

## Repository Shape

- Plugin manifest: `.claude-plugin/plugin.json`
- Skills: `skills/{garden-profile,garden-expert,landscape-design}/SKILL.md`
- Harness spec: `dev/testing/regression-harness.md`
- Runner script: `dev/testing/scripts/retest-runner.ps1`
- Run artifacts: `dev/testing/runs/`

## Skill Authoring Notes

- Keep skill body content under 500 words.
- Prefer gating language over rigid step lists.
- Preserve conversation-first behavior and persistence discipline.
- Do not add broad static gardening reference corpora.

## Conventions

- Do not mention "claude" in commit messages.
- If behavior/policy changes, update `docs/contracts.md` and relevant runbooks first.

## Runtime Contract Summary

- Final non-empty line must match the `Saved:` contract.
- Design preview-vs-canonical gating must be enforced.
- SVG open policy is browser-first.
- Regression evidence artifacts are mandatory for gate decisions.

See `docs/contracts.md` for canonical wording.
