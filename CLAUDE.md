# Garden-Bot Plugin

Claude Code plugin with 3 skills for gardening/landscaping assistance.

## Architecture
- **Plugin manifest:** `.claude-plugin/plugin.json` (MPL-2.0)
- **Skills:** `skills/{garden-profile,garden-expert,landscape-design}/SKILL.md`
- **User data:** current working directory (profile.md, areas/, plants/, log/, calendar.md)
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
- Clean data state between scenarios — always ask user before deleting garden data directory
- Test results: `docs/testing/{skill-name}-baseline.md` (RED, GREEN, REFACTOR phases)
- TDD cycle: RED (baseline without skill) → GREEN (write skill, re-test) → REFACTOR (close gaps)
- **Test setup**: Scenario 1 needs garden data directory removed; Scenario 2-3 need it populated. Verify test working directory is empty.
- **Web search**: Native WebSearch doesn't work (LiteLLM proxy). Use MCP web_search tools — installed and confirmed working.
- **Transcript workflow**: User runs `/export` in test session → reads exported `.txt` from `~/dev/landscaping-gardening/` → we analyze here.

## Test Data State (post Phase 4 Round 2 testing)
- `profile.md` (modified by Session 1 — backyard 40x30=1200 sq ft, patio NW corner)
- 5 area files: backyard.md (parent overview), backyard-north (unchanged), backyard-south (quadrant beds SW, fire pit SE), front-yard (unchanged), patio (connections updated)
- 5 plant files: cascade-oregon-grape, sword-fern, wild-ginger, evergreen-violet, tomatoes-2026
- `calendar.md` (generic Portland 8b — NOT updated with build tasks from design)
- `log/2026-02.md` (5 entries: 3 original + 2 from Phase 4 Round 2 test sessions)

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
- [x] Task 10 Phase 1: REFACTOR test unknowns — Scenarios 4-5, both PASS, 2 new findings (#9, #10)
- [x] Task 10 Phase 2: Edit SKILL.md for 8 findings — 311→446 words
- [x] Task 10 Phase 3: Re-test Scenarios 3-4 — all 8 findings PASS, 5 new HIGH findings (#11-15)
- [x] Task 10 Phase 4: Edit SKILL.md for #11-15 + 3 fixes. Two test rounds. All HIGH findings PASS. 503 words.
- [x] **Task 10 COMPLETE** — landscape-design REFACTOR done
- [x] Task 11: Integration testing — all 3 skills work together, data flows verified. Results in `docs/testing/integration-results.md`
- [ ] Task 12: Finalize plugin — commit, README (optional), merge to main. Consider adding to existing marketplace.

## landscape-design REFACTOR — Final Status
- **Comprehensive analysis:** `docs/testing/landscape-design-refactor-analysis.md` (24 findings total)
- **Skill version:** 503 words (slightly over 500 guideline, accepted)
- **All HIGH findings (#11-15) PASS** after Phase 4 Round 2
- **Remaining MEDIUMs:** #16-20 (from Phase 3), #24 (calendar not updated with build tasks)
- **Key REFACTOR wins:** ASCII art (no scripts), approval gate (new+modified), lead with analysis, log append-only, trace updates through all affected files

## Environment
- Worktree at `.worktrees/skill-implementation` (branch: `feature/skill-implementation`)
- `Bash(rm *)` is in project-level ASK permissions — always confirm before deleting
- Don't mention "claude" in git commit messages
