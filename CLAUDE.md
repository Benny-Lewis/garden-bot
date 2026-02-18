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

## Skill Authoring
- Skills should be <500 words body. Only teach what Claude doesn't already know.
- **Gating > procedures**: "Do X before Y" works; numbered "1. Ask 2. Create" steps get collapsed when user input already provides data.
- **Persistence gating**: "Before ending your response, save..." + "Do not offer to save and wait for permission" — without this, Claude offers but doesn't act.
- **Bold for critical instructions**: "**Wait for answers before giving a diagnosis.**" resists rationalization better than plain text.
- Conversation-first patterns produce better output (richer context → personalized files).
- Follow the Bitter Lesson: structure the data, not rigid workflows. Trust Claude's intelligence.
- **REFACTOR workflow**: Edit SKILL.md → set up test env → user runs test in separate session → review transcript → update test results doc.

## Conventions
- Don't mention "claude" in git commit messages
