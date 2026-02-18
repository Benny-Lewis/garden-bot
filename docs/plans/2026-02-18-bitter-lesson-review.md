# Bitter Lesson Review: garden-bot v0.1.0

> *"The biggest lesson that can be read from 70 years of AI research is that general methods that leverage computation are ultimately the most effective."* — Rich Sutton

## Context

This is a post-shipping retrospective evaluating how well garden-bot adheres to the Bitter Lesson applied to LLM skill authoring. The translation: skills should tell the model **where to look** and **how to save**, not **what to know**. "Computation" = the model's general intelligence. "Human knowledge" = domain content encoded in the skill.

**What shipped:** 3 skills totaling ~1,160 words across ~9.2KB of SKILL.md files. Zero reference files. Zero domain knowledge. Tested through 12 TDD tasks with manual testing in fresh sessions. 24 findings tracked and resolved across the landscape-design REFACTOR alone.

**Source files reviewed:**
- `skills/garden-profile/SKILL.md` (~370 words)
- `skills/garden-expert/SKILL.md` (~290 words)
- `skills/landscape-design/SKILL.md` (~503 words)
- `.claude-plugin/plugin.json`
- `docs/plans/2026-02-16-garden-bot-design.md` (original design)
- `docs/plans/2026-02-16-garden-bot-implementation.md` (task-level plan)
- `docs/testing/` (5 analysis docs, 4 transcripts, scenario artifacts)
- `CLAUDE.md`, `README.md`, `claude-skills-documentation.md`

---

## Scorecard

| Dimension | Alignment | Evidence |
|-----------|-----------|----------|
| Domain knowledge in skills | **Strong** | 0 gardening facts, 0 plant names, 0 care instructions across all 3 skills |
| Reference file usage | **Strong** | Design planned 5+ reference files (companion planting, SVG templates). Shipped 0. |
| Procedural rigidity | **Strong** | 0 numbered step sequences. All flow control via conditional gating. |
| Schema flexibility | **Strong** | "Add fields as warranted" — explicit anti-template approach |
| Data structure quality | **Strong** | Clean separation: profile / areas / plants / log / calendar. One-file-per-entity. |
| Visual output approach | **Strong** | SVG with templates planned → ASCII with 6 basic characters shipped |
| Structured workflow dependency | **Strong** | 5-step design flow planned → conditional triggers shipped |
| Persistence discipline | **Moderate** | Dual-gate pattern works, but duplicated across garden-expert and landscape-design |
| Repo hygiene | **Weak** | 18KB reference doc, empty dirs, stale CLAUDE.md, ~130KB of dev docs for ~9KB of product |

**Overall:** Strong alignment on skill content. The skills themselves are a textbook application. The repo around them still carries the scaffolding of a heavier approach that was correctly abandoned.

---

## The Wins

### 1. Zero domain knowledge — the defining decision

None of the three SKILL.md files contain a single gardening fact. No plant names (except as filename examples like `japanese-maple.md`). No zone data, no soil chemistry, no pest identification, no planting schedules. Every word is process discipline:

- **garden-profile** (~370 words): data conventions, file layout, read-before-write, progressive infrastructure
- **garden-expert** (~290 words): source hierarchy, diagnostic methodology, save discipline
- **landscape-design** (~503 words): visual format constraints, iteration discipline, approval gates

The design doc explicitly planned reference files for *"Companion planting reference, Crop rotation patterns, Seed starting schedules by zone type, Fertilizer/amendment guidance."* None exist. The model's training data contains all of this — and it's more up-to-date and comprehensive than any static reference file could be.

### 2. SVG → ASCII pivot

The design doc planned two tiers: *"Quick sketch: simple labeled SVG"* and *"Refined plan: scaled top-down SVG with plant symbols, dimensions, legend."* The implementation plan specified `svg-patterns.md` with shape conventions, color palette, and symbol library.

What shipped: *"Use basic ASCII characters (`+ - | . * #`) for consistent rendering across terminals. Do not generate scripts, coordinate systems, or rendering tools."*

REFACTOR finding #11 exposed this: script-generation approaches produced fragile output and took 20+ minutes. ASCII art with 6 characters rendered in every terminal in seconds. The simpler method that leveraged the model's inherent ability to arrange characters in a grid crushed the engineered approach.

### 3. Reference files: planned, scaffolded, never needed

The implementation plan created `references/` directories for garden-expert and landscape-design. Task 6 Step 2: *"Create reference files in `skills/garden-expert/references/`."* Task 9 Step 2: *"Create `skills/landscape-design/references/svg-patterns.md`."*

Both `references/` directories contain only `.gitkeep` files. The team built the infrastructure, tested the skills, and discovered the reference content was unnecessary. This is the Bitter Lesson in miniature: the general method (Claude's training data) made the knowledge-encoding approach (reference files) redundant.

### 4. Gating over procedures

All three skills use conditional gating exclusively. Zero numbered sequences anywhere:

- *"If the working directory has no `profile.md`, **have a conversation before creating any files.**"*
- *"**Before giving a diagnosis**, clarify growing situation... **Wait for answers.**"*
- *"**When design work involves spatial arrangement, produce a visual layout**"*
- *"**Before ending your response**, save..."*
- *"**Present the visual and get user feedback before saving any design to files — new or modified.**"*

This was a tested lesson: numbered procedures get collapsed when user input already provides data. Gating conditions survive because they are evaluated in context, not followed as a checklist.

### 5. Progressive infrastructure

*"Build the data directory incrementally — don't require full setup before recording anything."* The skill explicitly avoids a rigid setup sequence. If someone mentions a planting, create the plant file and area file on the fly. Don't force profile → areas → plants → calendar in order. Trust the model to figure out what infrastructure the moment requires.

### 6. Schema flexibility as design choice

*"Add fields as warranted. These files don't follow a rigid template."* The skill provides common fields as examples but explicitly does not require them. This is the opposite of a rigid schema — it trusts the model's judgment about what is relevant for each user's situation.

### 7. The 5-step structured flow, abandoned

The design doc planned: *"Discovery → Zone planning → Mockup → Plant placement → Design document."* The shipped landscape-design skill has no mention of this flow. Instead: conditional triggers that respond to what the user actually asks for. The model decides what to do based on the conversation, not a prescribed sequence.

---

## Where Friction Remains

### Friction 1: `claude-skills-documentation.md` in repo root [HIGH]

An 18KB copy of Anthropic's public Agent Skills documentation, committed to the repo. This is nearly 2x the size of all three skills combined. It's not referenced by any skill, not loaded at runtime, and serves no user-facing purpose. It's the repo's most prominent development artifact — and it's a *meta* artifact about how to write skills, not about gardening.

### Friction 2: Empty `references/` dirs and redundant `.gitkeep` files [MEDIUM]

Five `.gitkeep` files remain:
- `skills/garden-expert/.gitkeep` (unnecessary — SKILL.md already keeps the dir in git)
- `skills/garden-expert/references/.gitkeep` (vestige of planned reference files)
- `skills/garden-profile/.gitkeep` (unnecessary — SKILL.md already keeps the dir)
- `skills/landscape-design/.gitkeep` (unnecessary — same reason)
- `skills/landscape-design/references/.gitkeep` (vestige of SVG templates plan)

The `references/` directories are the repo's appendix: vestigial evidence of a knowledge-encoding path that was correctly abandoned. Keeping them suggests they will someday be populated. The testing proved they never need to be.

### Friction 3: CLAUDE.md frozen in development mode [MEDIUM]

- Task 12 still shows `[ ]` (actually complete)
- "Test Data State" section documents files from a specific test run
- "Testing Methodology" describes internal dev process in detail
- "landscape-design REFACTOR — Final Status" tracks internal findings
- "Environment" section references `.worktrees/skill-implementation` (merged and deleted)

This is a development war room, not a shipped product's project instructions. The "Skill Authoring" lessons learned section is genuinely valuable and should be kept.

### Friction 4: Stale plan docs [LOW]

The design doc references `~/garden-bot/` (now CWD), SVG generation (now ASCII), and a structured 5-step flow (now conditional triggers). The implementation plan references MIT license (now MPL-2.0), subagent testing (now manual-only), and SVG patterns. These are historically accurate — they show what was planned, not what shipped. But without annotation, they could mislead.

### Friction 5: ~130KB of docs for ~9KB of skills [LOW]

- **Product:** 3 SKILL.md + plugin.json + README = ~12KB
- **Development:** CLAUDE.md + design doc + impl plan + skills reference = ~52KB
- **Testing:** 5 analysis docs + 4 transcripts + scenario repo = ~100KB+

The 10:1 development-to-product ratio is not inherently wrong (thorough TDD produced excellent skills), but these are frozen artifacts, not living documentation. They have no audience after shipping.

### Friction 6: Source hierarchy examples [LOW]

garden-expert names specific institutions: *"Examples: OSU Extension, WSU Extension, your state's land-grant university."* This is 7 words of mild human-knowledge encoding. The model already knows what university extension services are. However, the examples serve as prompt anchoring — they teach the *class* of source by concrete instance. Borderline case.

---

## Recommendations

### Do Now

1. **Remove `claude-skills-documentation.md`** — 18KB development reference with no runtime purpose. Available on Anthropic's docs site if needed again. *(Friction 1)*

2. **Remove empty `references/` directories and redundant `.gitkeep` files** — Delete both `references/` dirs and all `.gitkeep` files in skill dirs that already contain SKILL.md. These are vestiges of the abandoned knowledge-encoding approach. *(Friction 2)*

3. **Update CLAUDE.md for shipped status** — Mark Task 12 `[x]`. Remove "Test Data State", collapse "Testing Methodology" to a pointer to `docs/testing/`. Remove "landscape-design REFACTOR" status section. Remove stale "Environment" worktree reference. Keep "Skill Authoring" lessons — those are genuinely useful. *(Friction 3)*

4. **Delete empty `.worktrees/` directory** — No contents, no purpose. *(Minor cleanup)*

### Consider

5. **Annotate plan docs as historical** — Add a brief header to both docs: *"Historical document. See shipped skills for what was actually built. Key deviations: ASCII replaced SVG, reference files never needed, CWD replaced ~/garden-bot/, MPL-2.0 replaced MIT."* *(Friction 4)*

6. **Archive testing artifacts** — Move transcripts and scenario repos to `docs/archive/` or add a note that they're development artifacts. Keep the 5 analysis docs in `docs/testing/` as they document the TDD methodology itself. *(Friction 5)*

7. **Leave the source hierarchy examples** — The 7 words of institutional names serve a legitimate prompt-anchoring function. The cost of removing them (slightly less precise source targeting) exceeds the benefit (marginal Bitter Lesson purity). *(Friction 6)*

---

## Final Assessment

garden-bot is a strong application of the Bitter Lesson to skill authoring. 1,160 words of process discipline across three skills, zero domain knowledge, zero reference files. The model's general intelligence handles all gardening expertise — the skills only structure where data goes, when to search, and how to save.

The most telling evidence is **what was planned but never built.** The design doc planned SVG templates, companion planting tables, crop rotation patterns, seed starting schedules, a structured 5-step design flow. None shipped. TDD testing proved they were unnecessary. This is the Bitter Lesson in action: the project started with a human-knowledge-heavy plan and systematically stripped it down to pure process discipline through empirical testing.

What remains is a repo that still carries more scaffolding than product. The skills are lean and principled; the repository around them still reflects the heavier approach that was correctly abandoned. The recommendations above would bring the repo into alignment with the skills' philosophy: lean, structured, trusting the intelligence.
