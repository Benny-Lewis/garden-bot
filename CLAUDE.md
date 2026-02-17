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

## ~/garden-bot/ Data State (post landscape-design RED testing)
- `profile.md` (updated: backyard description, style pref, fence, hose bibs)
- 4 area files: backyard-north (+seating nook), backyard-south (full cottage-style design), front-yard (full redesign), patio (outdoor living hub)
- 10 plant files: original 5 + blueberries-front-yard-2026, evergreen-huckleberry, liberty-apple, raspberries, red-flowering-currant
- `calendar.md` (heavily updated: Feb, Mar, May, Sep, Oct with backyard tasks)
- `log/2026-02.md` (5 entries incl. full backyard design session)
- **State created by 3 RED test sessions — needs cleanup/reset before GREEN phase testing**

## Progress
- [x] Task 1: Plugin scaffold
- [x] Task 2: garden-profile RED (baseline)
- [x] Task 3: garden-profile GREEN (write skill)
- [x] Task 4: garden-profile REFACTOR (onboarding conversation fix)
- [x] Task 5: garden-expert RED
- [x] Task 6: garden-expert GREEN
- [x] Task 7: garden-expert REFACTOR
- [x] Task 8: landscape-design RED (baseline) — results in `docs/testing/landscape-design-baseline.md`
- [ ] Task 9: landscape-design GREEN (write skill) — **NEXT**
- [ ] Task 10: landscape-design REFACTOR
- [ ] Task 11: Integration testing
- [ ] Task 12: Finalize plugin

## landscape-design RED Phase Key Findings (Task 8)
- **Claude already knows design methodology** — 6-phase process, discovery questions, zone planning all happened naturally
- **Claude produces ASCII art** for spatial layouts — functional but not iterable or proportional
- **Critical gap: visual iteration** — diagrams not updated when plans change
- **Gap: consolidated design doc** — design scattered across many files, no single view
- **Gap: proactive persistence** — inconsistent (asked in Scenario 2, saved proactively in Scenario 3)
- **User directive: do NOT prescribe SVG** — remain open to any visual format, test what works
- Skill should teach process discipline around visual deliverables, NOT design methodology or plants

## Environment
- Worktree at `.worktrees/skill-implementation` (branch: `feature/skill-implementation`)
- `Bash(rm *)` is in project-level ASK permissions — always confirm before deleting
- Don't mention "claude" in git commit messages
