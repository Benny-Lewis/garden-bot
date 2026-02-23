# Project Overview

`garden-bot` is a Claude Code plugin for gardening and landscaping workflows.

It provides three capabilities:
- persistent garden data management (`garden-profile`),
- source-backed diagnosis and recommendations (`garden-expert`),
- SVG-based layout design with approval gating (`landscape-design`).

## Who Should Read What

For plugin users:
- Start with `README.md`.
- Keep your garden files in your working directory (`profile.md`, `areas/`, `plants/`, `calendar.md`, `log/`).

For contributors:
- Start with `CONTRIBUTING.md`.
- Architecture: `docs/architecture.md`
- Normative behavior contracts: `docs/contracts.md`
- Regression runbook: `docs/runbooks/regression.md`
- Evidence capture runbook: `docs/runbooks/evidence-capture.md`

## Workflow Summary

1. User asks for planning, diagnosis, or design help.
2. Skill behavior is constrained by runtime contracts.
3. Changes persist to markdown files in the garden workspace.
4. Contributor changes are validated with regression harness runs.
5. GO/NO-GO is recorded in retest matrices and signoff docs.

## Canonical References

- Contracts: `docs/contracts.md`
- Regression harness source: `dev/testing/regression-harness.md`
- Runner script: `dev/testing/scripts/retest-runner.ps1`
- Results index: `docs/testing/results/README.md`
