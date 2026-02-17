# Garden-Bot Skills Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build a Claude Code plugin with 3 skills (garden-profile, garden-expert, landscape-design) that provide persistent, context-aware gardening and landscaping assistance.

**Architecture:** Plugin at repo root with `skills/` directory containing 3 skill subdirectories. Shared data layer at `~/garden-bot/` using markdown files. Skills follow writing-skills TDD methodology: RED (baseline) → GREEN (write skill) → REFACTOR (close loopholes).

**Tech Stack:** Markdown (skills + data), SVG (mockups), Claude Code plugin system

**Design doc:** `docs/plans/2026-02-16-garden-bot-design.md`

---

### Task 1: Plugin Scaffold

**Files:**
- Create: `.claude-plugin/plugin.json`
- Create: `skills/garden-profile/` (empty dir)
- Create: `skills/garden-expert/` (empty dir)
- Create: `skills/landscape-design/` (empty dir)

**Step 1: Create plugin manifest**

```json
{
  "name": "garden-bot",
  "version": "0.1.0",
  "description": "Gardening and landscaping assistant with persistent garden profiles, expert plant advice, and landscape design with visual mockups",
  "author": {
    "name": "blewis"
  },
  "license": "MIT",
  "keywords": ["gardening", "landscaping", "plants", "landscape-design", "garden-planning"]
}
```

Write to `.claude-plugin/plugin.json`.

**Step 2: Create skill directory stubs**

```bash
mkdir -p skills/garden-profile
mkdir -p skills/garden-expert/references
mkdir -p skills/landscape-design/references
```

**Step 3: Commit scaffold**

```bash
git add .claude-plugin/plugin.json skills/
git commit -m "Add plugin scaffold with skill directory structure"
```

---

### Task 2: garden-profile — RED Phase (Baseline Testing)

**Purpose:** Run pressure scenarios WITHOUT the garden-profile skill to document what Claude does wrong. This establishes what the skill needs to teach.

**REQUIRED SUB-SKILL:** Use superpowers:writing-skills TDD methodology.

**Files:**
- Create: `docs/testing/garden-profile-baseline.md` (record baseline results)

**Step 1: Write pressure scenarios**

Create 3 test scenarios in `docs/testing/garden-profile-baseline.md`:

```markdown
# garden-profile Baseline Testing

## Scenario 1: New User Onboarding
**Prompt:** "I just moved into a new house in Portland, Oregon (zone 8b). I have a south-facing front yard (~800 sq ft) and a larger backyard (~2000 sq ft) with a big oak tree that shades the north half. Help me set up tracking for my garden so I can manage everything."

**Expected baseline failures:**
- Does not create persistent files
- Does not establish a structured data directory
- May just chat about gardening without any file operations

## Scenario 2: Recording a New Planting
**Prompt:** "I planted three blueberry bushes (Duke variety) along the fence in my side yard last Saturday. The soil there is slightly acidic which they should love. Can you record that in my garden records?"

**Expected baseline failures:**
- Does not know where to store the data
- May create an ad-hoc file with no consistent structure
- Does not integrate with any existing garden profile

## Scenario 3: Retrieving Garden Data
**Prompt:** "What plants do I currently have in my backyard? And what are the conditions like back there?"

**Pre-condition:** Place test data files in ~/garden-bot/ to simulate an existing profile.
**Expected baseline failures:**
- Does not know to look in ~/garden-bot/
- Cannot find or read the stored garden data
- Asks the user to tell it information that's already recorded
```

**Step 2: Create test data for Scenario 3**

Create minimal test garden data so Scenario 3 has something to retrieve:

`~/garden-bot/profile.md`:
```markdown
# Garden Profile

- **Location:** Portland, Oregon
- **USDA Zone:** 8b
- **Property:** Single family home
```

`~/garden-bot/areas/backyard.md`:
```markdown
# Backyard

- **Size:** ~2000 sq ft
- **Sun:** Full sun (south half), partial shade (north half, under oak)
- **Soil:** Clay loam, slightly acidic (pH ~6.2)
- **Features:** Large oak tree (north), wood fence (perimeter), patio (near house)

## Plants
- Oregon grape (*Mahonia aquifolium*) — north fence line, planted 2025
- Blueberry bushes x3 (Duke) — east fence, planted Feb 2026
```

**Step 3: Run Scenario 1 baseline**

Launch a subagent (Task tool, general-purpose type) with Scenario 1 prompt. The subagent should NOT have the garden-profile skill loaded. Record exactly what the agent does:
- Does it create files? Where? What format?
- Does it ask the right onboarding questions?
- Does it establish any persistent structure?

Document verbatim behavior in `docs/testing/garden-profile-baseline.md`.

**Step 4: Run Scenario 2 baseline**

Launch a subagent with Scenario 2 prompt (no skill). Document behavior.

**Step 5: Run Scenario 3 baseline**

Launch a subagent with Scenario 3 prompt (no skill). The test data from Step 2 exists at `~/garden-bot/` but the agent doesn't know to look there. Document behavior.

**Step 6: Analyze baseline results**

Review all three baseline results. Document patterns:
- What rationalizations did the agent use?
- What information did it lack?
- What specific behaviors need to change?

Update `docs/testing/garden-profile-baseline.md` with analysis section.

**Step 7: Commit baseline results**

```bash
git add docs/testing/garden-profile-baseline.md
git commit -m "Document garden-profile baseline test results (RED phase)"
```

---

### Task 3: garden-profile — GREEN Phase (Write Skill)

**Purpose:** Write the minimal SKILL.md that addresses the specific baseline failures from Task 2.

**Files:**
- Create: `skills/garden-profile/SKILL.md`

**Step 1: Write SKILL.md**

Draft SKILL.md addressing baseline failures. Target <500 words for the body. The content below is a starting draft — modify based on actual baseline results from Task 2:

```yaml
---
name: garden-profile
description: Use when setting up a garden profile, adding or updating property areas or zones, recording plants, logging garden activities, or when any gardening task needs to read or write persistent garden data stored in ~/garden-bot/
---
```

Body should cover:
- **Data directory:** `~/garden-bot/` — check if it exists; if not, run onboarding
- **File structure:** `profile.md`, `areas/*.md`, `plants/*.md`, `calendar.md`, `log/YYYY-MM.md`
- **Onboarding flow:** Ask for zone, location, property overview, then create initial files
- **Reading data:** Always check ~/garden-bot/ for existing data before asking the user questions they've already answered
- **Writing data:** Use markdown format. One file per area, one file per plant (or planting group). Append to monthly log files.
- **Schema flexibility:** Add new fields as needed. No rigid template — adapt to what's useful.

**Step 2: Run Scenario 1 WITH skill**

Launch a subagent that has read the SKILL.md content. Run Scenario 1. Verify:
- Does it create ~/garden-bot/ directory structure?
- Does it ask appropriate onboarding questions?
- Does it create profile.md and area files?

**Step 3: Run Scenario 2 WITH skill**

Run Scenario 2. Verify:
- Does it create a plant file for the blueberry bushes?
- Is the data well-structured?
- Does it update the relevant area file?

**Step 4: Run Scenario 3 WITH skill**

Run Scenario 3. Verify:
- Does it read from ~/garden-bot/areas/backyard.md?
- Does it report the existing plants accurately?
- Does it avoid asking questions already answered in the data?

**Step 5: Document GREEN results**

Update `docs/testing/garden-profile-baseline.md` with GREEN phase results.

**Step 6: Commit**

```bash
git add skills/garden-profile/SKILL.md docs/testing/garden-profile-baseline.md
git commit -m "Add garden-profile skill (GREEN phase — addresses baseline failures)"
```

---

### Task 4: garden-profile — REFACTOR Phase

**Purpose:** Identify remaining issues, close loopholes, harden the skill.

**Files:**
- Modify: `skills/garden-profile/SKILL.md`

**Step 1: Review GREEN results for gaps**

Look for:
- Did the agent follow the skill but miss edge cases?
- Did it create files in unexpected formats?
- Did it fail to read existing data in any scenario?
- Any new rationalizations or shortcuts?

**Step 2: Run additional pressure scenarios**

Test edge cases:
- "I moved! Update my garden profile to zone 6a in Denver." (profile update)
- "Delete the oregano from my herb garden, it died." (data deletion)
- "Show me everything in my garden profile." (full data retrieval)

**Step 3: Update SKILL.md to address gaps**

Modify the skill to close any loopholes found. Keep it concise.

**Step 4: Re-run original scenarios to verify no regressions**

Run Scenarios 1-3 again with updated skill. Confirm still passing.

**Step 5: Commit**

```bash
git add skills/garden-profile/SKILL.md docs/testing/garden-profile-baseline.md
git commit -m "Refactor garden-profile skill — close loopholes from testing"
```

---

### Task 5: garden-expert — RED Phase (Baseline Testing)

**Files:**
- Create: `docs/testing/garden-expert-baseline.md`

**Step 1: Write pressure scenarios**

```markdown
# garden-expert Baseline Testing

## Scenario 1: Plant Selection (with area data)
**Pre-condition:** ~/garden-bot/ populated with profile and area data from garden-profile testing.
**Prompt:** "I have a shady area under the oak tree in my backyard. What ground covers would work well there? I want something low-maintenance and evergreen."

**Expected baseline failures:**
- Does not read area data from ~/garden-bot/
- Gives generic advice not tailored to zone/conditions
- May cite unreliable sources (random blogs)
- Does not save recommendations to plant inventory

## Scenario 2: Plant Troubleshooting
**Prompt:** "The lower leaves on my tomato plants are turning yellow with dark brown spots. The spots have concentric rings. What's going on and what should I do?"

**Expected baseline failures:**
- Generic diagnosis without checking plant inventory
- May not prioritize authoritative sources
- May not consider zone/climate context

## Scenario 3: Calendar / Scheduling Query
**Prompt:** "What gardening tasks should I be doing right now? It's mid-February."

**Pre-condition:** ~/garden-bot/ has profile (zone 8b) and plant inventory.
**Expected baseline failures:**
- Generic February advice, not tailored to zone 8b
- Does not check what plants the user actually has
- Does not reference or generate a calendar file

## Scenario 4: Vegetable Garden Planning
**Prompt:** "I want to start a vegetable garden in my backyard. I have a 4x8 raised bed getting full sun. What should I plant for spring and how should I arrange them?"

**Expected baseline failures:**
- Does not check zone/frost dates for spring timing
- May not consider companion planting
- Does not save plan to garden data
```

**Step 2: Run all 4 scenarios WITHOUT skill, document baseline**

**Step 3: Analyze and commit**

```bash
git add docs/testing/garden-expert-baseline.md
git commit -m "Document garden-expert baseline test results (RED phase)"
```

---

### Task 6: garden-expert — GREEN Phase (Write Skill)

**Files:**
- Create: `skills/garden-expert/SKILL.md`
- Create: `skills/garden-expert/references/companion-planting.md` (if needed)

**Step 1: Write SKILL.md**

Target <500 words. Draft:

```yaml
---
name: garden-expert
description: Use when the user asks about plants, gardening tasks, soil health, pest or disease issues, what to plant, when to fertilize, crop rotation, seed starting, harvest timing, or garden scheduling
---
```

Body should cover:
- **First:** Read ~/garden-bot/ profile and relevant area/plant files for context
- **Source hierarchy:** (1) University extension services (.edu), (2) reputable nurseries (e.g. swansonsnursery.com), established horticultural organizations, (3) well-regarded authorities. Never cite random blogs or non-expert sources.
- **Plant selection:** Consider zone, sun, soil, water, aesthetics, maintenance, native/invasive, pet/child safety. Save selections to plants/ files.
- **Care guidance:** Tailor to user's zone and specific plants. Reference plant files for history.
- **Troubleshooting:** Ask clarifying questions, use authoritative diagnostic resources.
- **Calendar:** Generate/update ~/garden-bot/calendar.md based on zone and plant inventory. Check log/ for recent activity when answering "what should I do now?"
- **Reference files:** See companion-planting.md, crop-rotation.md for detailed tables (create as needed).

**Step 2: Create reference files as needed**

Based on baseline failures, create reference files in `skills/garden-expert/references/` for any deep content the skill needs (companion planting tables, crop rotation patterns, etc.). Only create what's needed to address baseline failures.

**Step 3: Run all 4 scenarios WITH skill, document results**

**Step 4: Commit**

```bash
git add skills/garden-expert/ docs/testing/garden-expert-baseline.md
git commit -m "Add garden-expert skill with reference files (GREEN phase)"
```

---

### Task 7: garden-expert — REFACTOR Phase

**Files:**
- Modify: `skills/garden-expert/SKILL.md`
- Modify: reference files as needed

**Step 1: Review GREEN results, identify gaps**

**Step 2: Run additional pressure scenarios**
- "Is foxglove safe to plant if I have a dog?" (safety concern)
- "My soil test came back — pH 7.8, low nitrogen. What should I amend with?" (soil health)
- "Plan a succession planting schedule for lettuce from March through October." (detailed scheduling)

**Step 3: Update skill and references**

**Step 4: Re-run original scenarios, verify no regressions**

**Step 5: Commit**

```bash
git add skills/garden-expert/ docs/testing/garden-expert-baseline.md
git commit -m "Refactor garden-expert skill — close loopholes from testing"
```

---

### Task 8: landscape-design — RED Phase (Baseline Testing)

**Files:**
- Create: `docs/testing/landscape-design-baseline.md`

**Step 1: Write pressure scenarios**

```markdown
# landscape-design Baseline Testing

## Scenario 1: Ad-hoc Design Question
**Prompt:** "I want to redo my front yard. Right now it's just lawn and a few overgrown shrubs along the foundation. I'd like it to look more inviting with some color and structure. Any ideas?"

**Pre-condition:** ~/garden-bot/ has front-yard area data.
**Expected baseline failures:**
- Text-only response, no visual output
- Does not read existing area data
- Does not save design ideas to area file

## Scenario 2: Mockup Request
**Prompt:** "Can you create a visual layout showing where to put two 4x8 raised beds, a compost bin, and a seating area in my backyard?"

**Pre-condition:** ~/garden-bot/ has backyard area data with dimensions.
**Expected baseline failures:**
- Cannot generate SVG or visual diagram
- May describe layout in text only
- Does not consider existing features (oak tree, patio)

## Scenario 3: Structured Design Process
**Prompt:** "I'd like to do a full landscape design for my backyard. Can you walk me through the process step by step?"

**Expected baseline failures:**
- May provide generic design advice
- No structured deliverable (written plan, mockup)
- Does not produce a design document
```

**Step 2: Run all scenarios WITHOUT skill, document baseline**

**Step 3: Commit**

```bash
git add docs/testing/landscape-design-baseline.md
git commit -m "Document landscape-design baseline test results (RED phase)"
```

---

### Task 9: landscape-design — GREEN Phase (Write Skill)

**Files:**
- Create: `skills/landscape-design/SKILL.md`
- Create: `skills/landscape-design/references/svg-patterns.md`

**Step 1: Write SKILL.md**

Target <500 words. Draft:

```yaml
---
name: landscape-design
description: Use when the user wants to plan or redesign yard layout, create a garden design, generate a visual mockup or site plan diagram, or think through hardscape and planting zone placement
---
```

Body should cover:
- **First:** Read ~/garden-bot/ area files for dimensions, conditions, existing features
- **Two modes:** Ad-hoc design conversations (answer questions, suggest ideas) OR structured design process (when user requests one)
- **Structured flow (when requested):** Discovery → zone planning → mockup → plant placement → design document
- **Visual mockups — two tiers:**
  - Quick sketch: Simple SVG with labeled shapes, rough proportions, functional zones. For early exploration.
  - Refined plan: Scaled SVG with plant symbols, dimensions, legend, color coding. For finalized designs.
- **SVG generation:** See svg-patterns.md for templates and conventions.
- **Save work:** Update area files with design decisions. Save design documents to ~/garden-bot/.
- **Plant placement:** Integrate with garden-expert knowledge — consider mature size, spacing, layering, seasonal interest.

**Step 2: Create SVG patterns reference**

Create `skills/landscape-design/references/svg-patterns.md` with:
- Basic SVG template for garden mockups (viewBox, coordinate system)
- Shape conventions: rectangles for beds, circles for trees, paths for walkways
- Color palette for functional zones
- Symbol library for common garden elements
- Example: minimal quick-sketch SVG and refined-plan SVG

**Step 3: Run all 3 scenarios WITH skill, document results**

**Step 4: Commit**

```bash
git add skills/landscape-design/ docs/testing/landscape-design-baseline.md
git commit -m "Add landscape-design skill with SVG reference (GREEN phase)"
```

---

### Task 10: landscape-design — REFACTOR Phase

**Files:**
- Modify: `skills/landscape-design/SKILL.md`
- Modify: `skills/landscape-design/references/svg-patterns.md`

**Step 1: Review GREEN results, identify gaps**

Focus especially on:
- SVG output quality — is it readable and useful?
- Does the mockup accurately reflect area dimensions?
- Does it integrate existing features from area data?

**Step 2: Run additional pressure scenarios**
- "Update the mockup to move the raised beds to the south side." (iterative design)
- "Add a stone pathway from the patio to the garden beds." (hardscape addition)
- "Create a planting plan for the front foundation beds, 3 feet deep, full sun." (plant placement)

**Step 3: Update skill and references**

**Step 4: Re-run original scenarios, verify no regressions**

**Step 5: Commit**

```bash
git add skills/landscape-design/ docs/testing/landscape-design-baseline.md
git commit -m "Refactor landscape-design skill — close loopholes from testing"
```

---

### Task 11: Integration Testing

**Purpose:** Verify all 3 skills work together with shared data.

**Files:**
- Create: `docs/testing/integration-results.md`

**Step 1: End-to-end user journey**

Run a multi-step scenario that crosses all 3 skills:

1. "I'm new — help me set up my garden profile. I'm in zone 8b, Portland OR." (garden-profile)
2. "Help me design my front yard — it's 30ft wide by 15ft deep, south-facing, currently just lawn." (landscape-design)
3. "What flowering shrubs would work in the foundation beds from that design? I want year-round interest." (garden-expert)
4. "I'd like to add a small veggie patch — what should I plant for spring?" (garden-expert)
5. "Generate my garden calendar for the year." (garden-expert + garden-profile)
6. "Show me an updated mockup of the front yard with the plants we picked." (landscape-design)

Verify:
- Data flows between skills (profile → expert → design)
- No redundant questions (skills read existing data)
- Calendar reflects actual plants from the design
- Mockup incorporates selected plants

**Step 2: Document results**

Record what worked, what didn't, what needs adjustment.

**Step 3: Fix any cross-skill issues**

Update skills as needed based on integration results.

**Step 4: Commit**

```bash
git add docs/testing/integration-results.md skills/
git commit -m "Integration testing complete — cross-skill data flow verified"
```

---

### Task 12: Finalize Plugin

**Files:**
- Modify: `.claude-plugin/plugin.json` (bump version if needed)
- Create: `README.md`

**Step 1: Verify plugin loads correctly**

```bash
claude --plugin-dir . --debug 2>&1 | head -50
```

Confirm all 3 skills are discovered and loaded.

**Step 2: Write README**

Brief README with:
- What the plugin does
- How to install (`claude --plugin-dir` for development, marketplace for distribution)
- The 3 skills and what they do
- Data directory location (~garden-bot/)

**Step 3: Final commit on feature branch**

```bash
git add .
git commit -m "Finalize garden-bot plugin v0.1.0"
```

**Step 4: Merge to main**

Use superpowers:finishing-a-development-branch for merge/PR decision.
