# Garden-Bot Plugin

Claude Code plugin with 3 skills for gardening/landscaping assistance.

## Architecture
- **Plugin manifest:** `.claude-plugin/plugin.json` (MPL-2.0)
- **Skills:** `skills/{garden-profile,garden-expert,landscape-design}/SKILL.md`
- **User data:** `~/garden-bot/` (profile.md, areas/, plants/, log/, calendar.md)
- **Design doc:** `docs/plans/2026-02-16-garden-bot-design.md`
- **Implementation plan:** `docs/plans/2026-02-16-garden-bot-implementation.md`

## Skill Authoring
- Skills should be <500 words body. Only teach what Claude doesn't already know.
- **Gating > procedures**: "Do X before Y" works; numbered "1. Ask 2. Create" steps get collapsed when user input already provides data.
- Conversation-first patterns produce better output (richer context → personalized files).
- Follow the Bitter Lesson: structure the data, not rigid workflows. Trust Claude's intelligence.
- **REFACTOR workflow**: Edit SKILL.md → set up test env → user runs test in separate session → review transcript → update test results doc.

## Testing Methodology
- **Manual testing only** — subagent tests were contaminated (found design docs, meta-context in prompts)
- User runs tests in fresh Claude Code sessions at `~/dev/landscaping-gardening/`
- Plugin loaded via: `claude --plugin-dir ~/dev/garden-bot/.worktrees/skill-implementation`
- Natural prompts, no mention of testing. Behavior observed from transcripts.
- Clean data state between scenarios — always ask user before `rm -rf ~/garden-bot/`
- Test results: `docs/testing/{skill-name}-baseline.md` (RED, GREEN, REFACTOR phases)
- TDD cycle: RED (baseline without skill) → GREEN (write skill, re-test) → REFACTOR (close gaps)
- **Test setup**: Scenario 1 needs `~/garden-bot/` removed; Scenario 2-3 need it populated. Verify `~/dev/landscaping-gardening/` is empty.
- **Transcripts**: Saved to `docs/testing/scenario*-{baseline,green}-transcript.txt` for before/after comparison.

## Progress
- [x] Task 1: Plugin scaffold
- [x] Task 2: garden-profile RED (baseline)
- [x] Task 3: garden-profile GREEN (write skill)
- [x] Task 4: garden-profile REFACTOR (onboarding conversation fix)
- [x] Task 5: garden-expert RED
- [x] Task 6: garden-expert GREEN
- [x] Task 7: garden-expert REFACTOR
- [ ] Task 8-10: landscape-design RED/GREEN/REFACTOR
- [ ] Task 11: Integration testing
- [ ] Task 12: Finalize plugin

## Environment
- Worktree at `.worktrees/skill-implementation` (branch: `feature/skill-implementation`)
- `Bash(rm *)` is in project-level ASK permissions — always confirm before deleting
- Don't mention "claude" in git commit messages
