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
- **Persistence gating**: "Before ending your response, save..." + "Do not offer to save and wait for permission" — without this, Claude offers but doesn't act.
- **Bold for critical instructions**: "**Wait for answers before giving a diagnosis.**" resists rationalization better than plain text.
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
- **Web search**: Native WebSearch doesn't work (LiteLLM proxy). Use MCP web_search tools — installed and confirmed working.
- **Transcript workflow**: User runs `/export` in test session → reads exported `.txt` from `~/dev/landscaping-gardening/` → we analyze here.

## ~/garden-bot/ Data State (post landscape-design GREEN Scenario 3)
- `profile.md` (basic — reset to pre-design state for GREEN testing)
- 4 area files: backyard-north (ground cover plan), backyard-south (U-shaped bed design from Scenario 3), front-yard (basic), patio (potting area from Scenario 3)
- `backyard.md` — NEW file created by Scenario 3 (full yard overview with layout)
- 5 plant files: cascade-oregon-grape, sword-fern, wild-ginger, evergreen-violet, tomatoes-2026
- `calendar.md` (basic seasonal entries)
- `log/2026-02.md` (4 entries: initial setup, oak understory, tomato blight, full backyard design)
- **State modified by GREEN Scenario 3 — needs cleanup/reset before REFACTOR testing**

## Progress
- [x] Task 1: Plugin scaffold
- [x] Task 2: garden-profile RED (baseline)
- [x] Task 3: garden-profile GREEN (write skill)
- [x] Task 4: garden-profile REFACTOR (onboarding conversation fix)
- [x] Task 5: garden-expert RED
- [x] Task 6: garden-expert GREEN
- [x] Task 7: garden-expert REFACTOR
- [x] Task 8: landscape-design RED (baseline) — results in `docs/testing/landscape-design-baseline.md`
- [x] Task 9: landscape-design GREEN (write skill) — all 3 gaps fixed, results in baseline doc
- [ ] Task 10: landscape-design REFACTOR — **NEXT**
- [ ] Task 11: Integration testing
- [ ] Task 12: Finalize plugin

## landscape-design Key Findings (Tasks 8-9)
- **RED gaps identified:** visual iteration, consolidated design doc, proactive persistence
- **GREEN results:** All 3 gaps fixed across all 3 test scenarios
- Skill is 311 words — teaches process discipline around visual deliverables only (Bitter Lesson confirmed)
- ASCII art emerged as natural visual format — embeds in markdown, iterates easily, no separate files
- Iteration discipline ("regenerate immediately when design changes") was the key intervention
- **REFACTOR candidates:** Minor — diagram saved to file sometimes omits context from chat version; no formal legend/symbology; emergent `backyard.md` file pattern not prescribed

## Environment
- Worktree at `.worktrees/skill-implementation` (branch: `feature/skill-implementation`)
- `Bash(rm *)` is in project-level ASK permissions — always confirm before deleting
- Don't mention "claude" in git commit messages
