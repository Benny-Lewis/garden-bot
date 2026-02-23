# Garden-Bot Plugin

Claude Code plugin with 3 skills for gardening and landscaping assistance.

## Architecture
- Plugin manifest: `.claude-plugin/plugin.json` (MPL-2.0)
- Skills: `skills/{garden-profile,garden-expert,landscape-design}/SKILL.md`
- User data: current working directory (`profile.md`, `areas/`, `plants/`, `log/`, `calendar.md`)
- Design doc: `docs/plans/active/2026-02-16-garden-bot-design.md`
- Implementation plan: `docs/plans/active/2026-02-16-garden-bot-implementation.md`
- Development docs index: `docs/plans/README.md`
- Testing results index: `docs/testing/results/README.md`
- Regression harness: `dev/testing/regression-harness.md`

## Skill Authoring
- Skills should be <500 words body. Only teach what Claude does not already know.
- Gating over procedures: "Do X before Y" works better than rigid numbered steps.
- Persistence gating: "Before ending your response, save..." and "Do not offer to save and wait for permission" are both required.
- Bold critical instructions for fragile rules (for example, wait for answers before diagnosis).
- Conversation-first patterns produce richer context and better persistence quality.
- Follow the Bitter Lesson: structure the data, not rigid workflows.
- Refactor workflow: edit `SKILL.md` -> set up test env -> run test -> review transcript -> update testing docs.
- Do not add broad static gardening knowledge references.
- If a reference file is needed, keep it short and operational and add explicit read gating.

## Conventions
- Do not mention "claude" in git commit messages.

## Enforced Runtime Contracts
- Final response contract: final non-empty line must be `Saved: <paths>` or `Saved: none - <reason>`.
- Design preview-vs-canonical gating:
  - Before approval, write preview SVGs only under `areas/` (`{area-name}-option-a.svg`, `{area-name}-option-b.svg`).
  - Before approval, do not modify canonical `areas/{area-name}-layout.svg`, area `.md`, `calendar.md`, `log/`, or `plants/`.
  - After approval, write canonical layout and related area/plant/calendar/log updates in the same turn.
- SVG open policy:
  - Open SVGs in Google Chrome when available, otherwise default web browser.
  - On Windows, launch Chrome directly rather than relying on `.svg` association.
  - Never open editor/design apps for SVG review.

## Regression Run Evidence
- Required artifacts per turn: `saved-contract-turn*.txt`.
- Required diff artifacts: `diff-snap*.txt`; for failed turns also `snap-failure-*.csv` and `diff-*-failure-vs-*.txt`.
- Required design-scenario artifacts (3/4/5): `open-evidence.md` with opened path, observed app, timestamp, and screenshot reference or explicit note.
- `open_target_verified` may be `PASS` only with direct user-observed evidence in `open-evidence.md`.
