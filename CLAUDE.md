# Garden-Bot Plugin

Claude Code plugin with 3 skills for gardening/landscaping assistance.

## Architecture
- **Plugin manifest:** `.claude-plugin/plugin.json` (MPL-2.0)
- **Skills:** `skills/{garden-profile,garden-expert,landscape-design}/SKILL.md`
- **User data:** current working directory (profile.md, areas/, plants/, log/, calendar.md)
- **Design doc:** `dev/plans/2026-02-16-garden-bot-design.md`
- **Implementation plan:** `dev/plans/2026-02-16-garden-bot-implementation.md`
- **Development docs:** `dev/plans/` (design, implementation plan, retrospectives)
- **Test results:** `dev/testing/results/`
- **Regression harness:** `dev/testing/regression-harness.md`

## Skill Authoring
- Skills should be <500 words body. Only teach what Claude doesn't already know.
- **Gating > procedures**: "Do X before Y" works; numbered "1. Ask 2. Create" steps get collapsed when user input already provides data.
- **Persistence gating**: "Before ending your response, save..." + "Do not offer to save and wait for permission" — without this, Claude offers but doesn't act.
- **Bold for critical instructions**: "**Wait for answers before giving a diagnosis.**" resists rationalization better than plain text.
- Conversation-first patterns produce better output (richer context → personalized files).
- Follow the Bitter Lesson: structure the data, not rigid workflows. Trust Claude's intelligence.
- **REFACTOR workflow**: Edit SKILL.md → set up test env → user runs test in separate session → review transcript → update test results doc.
- Do not add broad gardening knowledge reference docs. Keep skills focused on process, grounding, and persistence.
- If a reference file is needed, keep it short and operational (lookup aid), and add explicit gating in SKILL.md for when it should be read.

## Conventions
- Don't mention "claude" in git commit messages

## Enforced Runtime Contracts
- Final response contract: final non-empty line must be `Saved: <paths>` or `Saved: none - <reason>`.
- Design preview-vs-canonical gating:
  - Before approval, write preview SVGs only under `areas/` (`{area-name}-option-a.svg`, `{area-name}-option-b.svg`).
  - Before approval, do not modify canonical `areas/{area-name}-layout.svg`, area `.md`, `calendar.md`, `log/`, or `plants/`.
  - After approval, write canonical layout + related area/plant/calendar/log updates in the same turn.
- SVG open policy:
  - Open SVGs in Google Chrome when available, otherwise default web browser.
  - On Windows, launch Chrome directly rather than relying on `.svg` association.
  - Never open editor/design apps for SVG review.

## Regression Run Evidence
- Required artifacts per turn: `saved-contract-turn*.txt`.
- Required diff artifacts: `diff-snap*.txt`; for failed turns also `snap-failure-*.csv` and `diff-*-failure-vs-*.txt`.
- Required design-scenario artifacts (3/4/5): `open-evidence.md` with opened path, observed app, timestamp, and screenshot reference or explicit note.
- `open_target_verified` may be `PASS` only with direct user-observed evidence in `open-evidence.md`.
