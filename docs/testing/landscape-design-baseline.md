# landscape-design Baseline Testing (RED Phase)

## Methodology

Tests run WITH garden-profile and garden-expert loaded but WITHOUT landscape-design — the realistic deployment scenario. This isolates design/visual gaps from data-access issues (solved by garden-profile) and domain expertise issues (solved by garden-expert).

**Data state:** `~/garden-bot/` populated from prior testing — profile, 4 area files (front-yard, backyard-north, backyard-south, patio), 5 plant files, calendar, log. Rich context available including design goals and ideas in area files.

**Environment:** Fresh sessions at `~/dev/landscaping-gardening/`, natural prompts, plugin via:
```
claude --plugin-dir ~/dev/garden-bot/.worktrees/skill-implementation
```

**What we're looking for** (things landscape-design should improve):
- **Visual output** — does Claude produce SVG diagrams, or text-only descriptions?
- **Design methodology** — does it follow a structured process (discovery → zones → mockup → plants → document), or just give advice?
- **Spatial reasoning** — does it consider dimensions, sun patterns, existing features, sight lines, traffic flow?
- **Design persistence** — does it save a design document or update area files with design decisions?
- **Iterative design** — can it refine/modify a design based on feedback?

---

## Scenario 1: Ad-hoc Design Question

**Prompt:** "I want to redo my front yard. Right now it's just lawn and a few overgrown shrubs along the foundation. I'd like it to look more inviting with some color and structure. Any ideas?"

Tests whether Claude reads existing front-yard data (which already has an "edible landscaping" plan and specific ideas like blueberry hedges and herb borders), produces any visual output, and saves design decisions. The front-yard.md has dimensions (~800 sq ft), orientation (south-facing), and slope info — does Claude use these for spatial reasoning?

**Note:** The prompt says "overgrown shrubs" but front-yard.md says "no beds or plantings" — interesting to see if Claude reconciles this or takes one at face value.

---

## Scenario 2: Mockup Request

**Prompt:** "Can you create a visual layout showing where to put two 4x8 raised beds, a compost bin, and a seating area in my backyard?"

Direct request for a visual/spatial deliverable. The backyard has rich data: 2000 sq ft total, mature oak tree shading the north half, existing patio (10x12), two hose bibs. Does Claude generate an SVG or diagram? Does it consider the oak tree, patio, sun patterns, and access paths? Does it use actual dimensions or just describe placement in words?

---

## Scenario 3: Structured Design Process

**Prompt:** "I'd like to do a full landscape design for my backyard. Can you walk me through the process step by step?"

Tests whether Claude can deliver a structured design process with real deliverables (written plan, visual mockup), or just provides a generic advice listicle. The backyard has two distinct zones (north/shade, south/sun) with different plans already recorded. Does Claude build on existing plans? Does it produce a design document? Does it offer/generate mockups at the appropriate stage?

---

## Baseline Results

### Scenario 1: Ad-hoc Design Question
**Result: EXCELLENT advice, ZERO spatial/visual output**

What garden-profile + garden-expert handled well (NOT landscape-design's job):
- ✅ Read front-yard.md and profile — fully context-aware recommendations
- ✅ Noticed prompt/data discrepancy ("overgrown shrubs" vs "no beds") — updated data to match reality
- ✅ Strong plant selection: natives (red flowering currant, evergreen huckleberry, Oregon sunshine) + edibles (blueberries, herbs, apple)
- ✅ OSU Extension citations — concrete lime pH warning for blueberries, source-backed recommendations
- ✅ Proactively saved: updated front-yard.md (comprehensive redesign), created 4 plant files, updated calendar (4 months), updated log
- ✅ Asked 3 clarifying questions (lawn removal, tree preference, budget) before finalizing
- ✅ Phased implementation timeline with budget estimate ($620–$1030)
- ✅ Year-round interest timeline showing seasonal coverage

What was MISSING (landscape-design gaps):
- ❌ **Zero visual output** — no SVG, no diagram, no sketch. Everything described in text only.
- ❌ **Zero spatial reasoning** — "plant off-center" is the only placement guidance. No discussion of bed shapes, proportions, traffic flow (front door → sidewalk), sight lines from street, or where specific plants go relative to each other.
- ❌ **No layout/plan view** — despite knowing dimensions (800 sq ft, south-facing, sloped), never attempted to show a spatial arrangement.
- ❌ **No design composition** — "three layers" is botanical layering (tall/medium/low), not spatial design. No concept of focal points, rhythm, mass vs void, or how the yard reads from the street.
- ❌ **No hardscape design** — mentioned paths and edging in text but never designed WHERE paths go, what shape beds are, how you walk through the space.

### Scenario 2: Mockup Request
**Result: GOOD spatial reasoning, ASCII art not SVG, didn't save proactively**

What worked well:
- ✅ Read profile, backyard-south, backyard-north, patio — fully context-aware
- ✅ **Produced an ASCII art layout diagram** — house, patio, oak tree, compost bin, both raised beds, fences. Genuine spatial arrangement, not just text description.
- ✅ Strong spatial reasoning: beds in south half (sun), east-west orientation for max south exposure at 45°N, compost near oak (shade prevents drying, downwind from patio), seating on existing patio
- ✅ Practical dimensions: 4 ft path between beds (wheelbarrow-friendly), 3 ft side clearance, 12-18" bed height for clay drainage
- ✅ Considered oak shadow, prevailing winds, hose bib proximity, kitchen access
- ✅ Saved layout (including ASCII diagram) to backyard-south.md and logged activity — but only when asked

What was MISSING (landscape-design gaps):
- ❌ **ASCII art, not SVG** — functional but crude. Not scalable, can't be opened as an image, no proportional accuracy.
- ❌ **Not to scale** — beds appear much larger relative to yard than they are. No indication of proportions (two 4x8 beds = 64 sq ft in a 1000 sq ft south half).
- ❌ **No measurements on diagram** — dimensions mentioned in text below, not labeled on the diagram itself.
- ❌ **No legend or symbology** — oak is a tree emoji + label, no consistent symbols.
- ❌ **Didn't save proactively** — asked "Want me to save this?" despite garden-expert having persistence gating. Without landscape-design skill, agent reverted to asking.
- ❌ **No design document** — layout advice embedded in chat response, not saved as a formal design deliverable.

**Key observation:** Claude IS capable of spatial reasoning and layout diagrams without the skill. The gap is format (SVG vs ASCII), scale accuracy, proactive persistence, and treating design as a formal deliverable.

### Scenario 3: Structured Design Process
**Result: EXCELLENT design process, ASCII diagrams, no visual iteration after feedback**

What worked well:
- ✅ **Genuine 6-phase design process:** Site Analysis → Wish List → Concept Plan (Bubble Diagram) → Detailed Design → Phased Implementation → Installation. Proper landscape design methodology without the skill teaching it.
- ✅ Read all existing data (profile, 4 areas, plants, calendar, log) — built on existing plans, not from scratch
- ✅ **Asked 5 discovery questions** before designing (boundaries, daily use, hose bibs, lawn, aesthetics)
- ✅ **Two ASCII art diagrams** — zone bubble diagram AND detailed layout with beds, compost, raspberry border, patio, oak garden
- ✅ **Irrigation plan** with ASCII tree diagram showing full drip system from single hose bib
- ✅ Zone-by-zone breakdown with specific materials, plants, and design rationale ("intensity gradient" — most-used areas closest to house)
- ✅ Itemized per-phase budget ($580–945 Phase 1, $370–550 Phase 2)
- ✅ **Confirmed design with user** before saving — asked 4 validation questions
- ✅ Incorporated user feedback: reduced from 4 beds to 2 (Phase 1), removed lawn patch, kept budget
- ✅ **MASSIVE proactive file saves** — updated 7 files: backyard-south.md (comprehensive rewrite), patio.md (full redesign), backyard-north.md (seating nook + bark paths), raspberries.md (new), profile.md (updated goals + style), calendar.md (6 months updated), log/2026-02.md (detailed design session record)
- ✅ Cottage-style design details: offset beds, flowers mixed with food, self-seeders, soft edges, varied heights

What was MISSING (landscape-design gaps):
- ❌ **ASCII art, not a scalable visual** — Two diagrams, both ASCII. Functional but crude, not proportional, can't be iterated easily or opened as an image.
- ❌ **No diagram updated after user feedback** — User changed plan from 4 beds to 2 and removed lawn. The detailed ASCII diagram still showed 4 beds + lawn patch. No revised visual was produced — only text files were updated.
- ❌ **No consolidated design document** — Design is saved across 7 files (backyard-south, patio, backyard-north, profile, calendar, log, raspberries). Excellent data, but no single "backyard-design.md" that consolidates the spatial plan into one design deliverable.
- ❌ **No visual of final detailed layout** — backyard-south.md describes "beds offset, not in a rigid grid" but never shows the spatial arrangement. The reader has to imagine the layout from text alone.

**Key observation:** Claude naturally follows an excellent structured design methodology — the landscape-design skill does NOT need to teach design process. The gaps are specifically about visual output: producing diagrams that can be iterated when plans change, maintaining a consolidated design view, and ensuring the visual matches the final decisions.

---

## Analysis

### Pattern: Claude's Design Intelligence Is Strong

Across all 3 scenarios, Claude demonstrated genuine design thinking:
- **Scenario 1:** Layered planting design with year-round interest, phased timeline, budget — but no spatial layout
- **Scenario 2:** Good spatial reasoning with ASCII diagram, considered sun, wind, access, shadow — but didn't save proactively
- **Scenario 3:** Full 6-phase design process, discovery questions, zone planning, phased implementation — but no visual iteration

The Bitter Lesson holds: Claude's built-in intelligence handles design methodology, spatial reasoning, plant selection, and phased planning well. The skill should NOT try to teach these.

### What the Skill Must Teach

**1. Visual output that can be iterated (CRITICAL)**
All three scenarios produced either zero visuals (Scenario 1) or ASCII art that wasn't updated when plans changed (Scenarios 2 & 3). The skill needs to teach Claude to produce visual layouts that:
- Show spatial arrangement of features to scale (or at least proportionally)
- Get updated when the design changes (not just the text files)
- Can be saved as a file the user can reference later

The specific format (SVG, ASCII with conventions, Mermaid, etc.) should NOT be prescribed rigidly — let testing reveal what works best. The key requirement is iterability: when the plan changes, the visual changes too.

**2. Consolidated design document (HIGH)**
Scenario 3 saved excellent design data across 7 files, but there's no single place to see "the backyard design." The skill should teach saving a consolidated design view — one file that shows the spatial plan, zone summary, and key decisions together.

**3. Proactive persistence for design work (MEDIUM)**
Scenario 2 asked "Want me to save this?" while Scenario 3 saved proactively. The garden-expert skill already has persistence gating, but landscape-design may need its own reinforcement — design deliverables (diagrams, plans) should be saved without asking.

### What Claude Already Does Well (Don't Duplicate)

- **Design methodology** — site analysis, discovery, zone planning, phased implementation
- **Spatial reasoning** — sun patterns, traffic flow, functional zones, intensity gradients
- **Plant integration** — pulls from garden-expert knowledge and garden-profile data
- **Budget and timeline** — realistic phased budgets with local sourcing
- **Data persistence** — updates area files, calendar, log, plant files (garden-profile + garden-expert handle this)
- **Design aesthetics** — cottage style, offset beds, flowers with food, soft edges
- **User dialogue** — asks discovery questions, confirms before finalizing

---

## GREEN Phase Results

**Skill written:** `skills/landscape-design/SKILL.md` (311 words — well under 500 word limit)

Three sections address the three RED gaps:
1. **Visual Layouts + Iteration Discipline** — produce visual layouts with proportions/labels/dimensions/orientation; regenerate immediately when design changes; "the visual and the text must always agree"
2. **Consolidated Design View** — save design section in the area file as single source of truth (embedded visual + zone summary + key decisions)
3. **Save Design Work Proactively** — persistence gating ("Do not offer to save and wait for permission")

Deliberately did NOT create `references/svg-patterns.md` — per user directive, format is not prescribed. Testing confirmed ASCII art works well when the skill provides behavioral guidance.

**Data state:** `~/garden-bot/` reset to pre-design state between each scenario (5 design-phase plant files removed, area files stripped of design sections, calendar/log reverted).

### Scenario 1 GREEN: Ad-hoc Design Question

**Same prompt as RED.** Result: **All 3 gaps fixed.**

| Gap | RED Behavior | GREEN Behavior |
|-----|-------------|----------------|
| Visual layout | ❌ Zero visual output — text only | ✅ ASCII art diagram with dimensions, orientation (N/S/E/W), labeled zones, approximate proportions |
| Consolidated design | ❌ No design section in area file | ✅ Saved "Edible Cottage Northwest" design section in front-yard.md with embedded visual, zone summary, key decisions |
| Proactive persistence | ❌ N/A (Scenario 1 RED saved proactively via garden-expert) | ✅ Saved 5 plant files, calendar, log without asking |

**Major improvement:** RED Scenario 1 produced zero spatial output — everything was text description. GREEN produced a visual layout with labeled zones and dimensions as part of the design process.

### Scenario 2 GREEN: Mockup Request

**Same prompt as RED.** Result: **All 3 gaps fixed.**

| Gap | RED Behavior | GREEN Behavior |
|-----|-------------|----------------|
| Visual layout | ⚠️ ASCII art — functional but no dimensions on diagram, not to scale | ✅ ASCII art with dimensions, proportions, labels, orientation |
| Consolidated design | ❌ Layout only in chat, not saved as design deliverable | ✅ Design section saved in backyard-south.md with embedded visual, zone summary table, key decisions |
| Proactive persistence | ❌ Asked "Want me to save this?" | ✅ "Let me save this design" — saved proactively without asking |

**Session efficiency:** 2 min 46 sec — direct response to a direct request. Skill didn't add overhead.

### Scenario 3 GREEN: Structured Design Process (Critical Iteration Test)

**Same prompt as RED.** Result: **All 3 gaps fixed — including the #1 RED failure (visual iteration).**

| Gap | RED Behavior | GREEN Behavior |
|-----|-------------|----------------|
| Visual iteration | ❌ User changed from 4 beds to 2, diagram still showed 4 beds | ✅ **3 visual iterations**: Draft 1 (4 separate beds) → Draft 2 (U-shape south-opening, 12ft interior) → Draft 3 (U-shape north-opening, 8ft interior). Each regenerated immediately on user feedback. |
| Consolidated design | ❌ Design scattered across 7 files, no single view | ✅ Created `backyard.md` (full yard overview) + detailed `backyard-south.md` (U-bed structure, planting plan diagrams, materials) + updated `patio.md` |
| Proactive persistence | ⚠️ Saved proactively in RED Scenario 3 | ✅ Saved 4 files proactively — consistent behavior |

**Additional observations:**
- Produced a **comparison table** across drafts (dimensions, interior width, orientation, access)
- Created **two diagram types**: structural layout (U-bed shape) AND planting plan (what goes where in each arm)
- Session was 2 min 59 sec with 3 design iterations — efficient multi-turn design process
- Created `backyard.md` as a full-yard overview file (emergent pattern — not prescribed by skill)

---

## GREEN Phase Analysis

### All 3 RED Gaps Are Fixed

**1. Visual iteration (CRITICAL gap):** The #1 RED failure — diagrams not updating when plans change — is completely resolved. Scenario 3 demonstrated 3 full visual iterations, each regenerated immediately when the user requested changes. The skill's "iteration discipline" section ("regenerate the visual layout immediately") and "the visual and the text must always agree" directly addressed this.

**2. Consolidated design view:** All 3 scenarios saved design sections in area files with embedded visuals, zone summaries, and key decisions. The area file serves as single source of truth for "what does this area look like?"

**3. Proactive persistence:** All 3 scenarios saved without asking permission. The persistence gating pattern ("Do not offer to save and wait for permission") is proven across all three skills now (garden-profile, garden-expert, landscape-design).

### Bitter Lesson Confirmed

The skill is 311 words and teaches zero design methodology. Claude's built-in intelligence handles:
- Design process (discovery → zones → layout → detail)
- Spatial reasoning (sun, shade, access, proportions)
- Plant selection and seasonal planning
- Budget estimation and phased timelines

The skill only teaches **process discipline around visual deliverables** — when to produce them, when to update them, where to save them. This is the minimal effective intervention.

### Format Discovery

ASCII art emerged as the natural visual format across all scenarios. It works because:
- Embeds directly in markdown files (no separate image files)
- Supports labels, dimensions, orientation markers
- Iterates easily (regenerate in the same response)
- Readable in any text editor or terminal

The decision not to prescribe SVG was correct — ASCII art is sufficient for the design communication task, and the skill's format-agnostic approach ("produce a visual layout") let Claude use what works naturally.

---

## REFACTOR Phase

### Phase 1: Test Unknowns (mini RED)

Two new scenarios to run with the current skill unchanged, testing behaviors we haven't observed:

**Scenario 4: Design continuity across sessions**
- Setup: `~/garden-bot/` with Scenario 3's backyard design saved (visual layout in area files)
- Prompt: Ask to modify the existing backyard design (e.g., move fire pit, add pergola)
- Tests: Does agent read saved visual? Regenerate with changes? Update the file?

**Scenario 5: Incremental change**
- Setup: Same state (or after Scenario 4)
- Prompt: Ask for a small dimensional tweak (e.g., widen U-bed interior from 8 to 10 ft)
- Tests: Does a minor change trigger full visual regeneration, or text-only description?

### Phase 2: Edit SKILL.md

Address all findings in a single edit — both observed GREEN gaps (Category A) and confirmed Phase 1 failures (Category B):

| # | Finding | Category | Source |
|---|---------|----------|--------|
| 2 | Key decisions & rationale not consistently saved | A — observed | Scenario 3 saved structural detail but no "why" section |
| 4 | Area overview not updated after design | A — observed | Scenario 3 still says "Current state: Lawn" after full design |
| 5 | No legend on full-yard diagrams | A — observed | Detail views get legends, overview diagrams don't |
| 6 | Dimensions assumed vs asked | A — observed | Scenario 2 assumed width; Scenario 3 asked |
| 7 | Ad-hoc symbology across sessions | A — observed | Trees, fire pits, hose bibs all use different conventions per session |
| 8 | Emergent parent area file pattern | A — observed | `backyard.md` overview created but not prescribed |
| 1 | Design continuity across sessions | B — test first | May or may not fail in Phase 1 |
| 3 | Incremental changes trigger visual update | B — test first | May or may not fail in Phase 1 |

### Phase 3: Re-test

Run scenarios against edited skill to verify fixes without breaking GREEN behaviors (visual layouts, consolidated design, proactive persistence).
