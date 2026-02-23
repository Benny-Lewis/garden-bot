> **Historical document** — reflects what was planned, not what shipped. Key deviations: ASCII replaced SVG, reference files never needed, CWD replaced ~/garden-bot/, MPL-2.0 replaced MIT, manual testing replaced subagent testing. See shipped skills for actual implementation.

# Garden-Bot: Claude Code Plugin for Gardening & Landscaping

## Context

Building a Claude Code plugin that provides comprehensive gardening and landscaping expertise. The plugin is general-purpose (works for any gardener, any location), distributed as a Claude Code plugin, and designed to be a persistent, context-aware gardening assistant that remembers the user's property and plants across sessions.

**Design philosophy:** Informed by Rich Sutton's "The Bitter Lesson" — structure the *data*, not rigid workflows. Provide Claude with good data access, source hierarchy, and domain framing, then trust its general intelligence. Keep skills concise and flexible.

---

## Architecture: 3 Skills + Shared Data Layer

### Skill 1: `garden-profile`
**Purpose:** Manages the persistent garden data layer — the user's property, plants, and activity history.

**Trigger:** Use when the user wants to set up their garden profile, add/update property areas, record plants, or log garden activities.

**Core responsibilities:**
- First-time onboarding: walk user through capturing zone, property overview, soil type
- CRUD operations on garden data files
- Flexible schema: Claude can add fields/files as needed without fighting a rigid structure

**Data architecture** (stored in user-configurable directory, default `~/garden-bot/`):
```
~/garden-bot/
├── profile.md            # Zone, climate, property overview, soil type
├── areas/                # One file per yard zone
│   ├── front-yard.md     # Dimensions, sun, soil, irrigation, design notes
│   ├── backyard.md
│   └── side-yard-north.md
├── plants/               # One file per plant or planting group
│   ├── japanese-maple.md # Species, location, date planted, care log
│   └── tomatoes-2026.md
├── calendar.md           # Master month-by-month task reference
└── log/                  # Activity history (append-only)
    ├── 2026-02.md        # Monthly activity log
    └── ...
```

**Key data design choices:**
- Markdown files, not JSON — human-readable, git-friendly, editable outside Claude
- One file per area/plant — keeps files small, enables progressive disclosure on user data
- Monthly activity logs — append-only, easy seasonal review
- Flexible schema — no rigid template; Claude adds fields as warranted

**Expected structure:** Likely self-contained SKILL.md. Possibly one template/reference file showing example area or plant file format.

---

### Skill 2: `garden-expert`
**Purpose:** Gardening domain expertise — plant selection, care guidance, vegetable gardening, troubleshooting, calendar/scheduling.

**Trigger:** Use when the user asks about plants, gardening tasks, soil health, pest/disease issues, what to plant, when to fertilize, crop rotation, seed starting, harvest timing, or garden scheduling.

**Core responsibilities:**
- Plant selection based on growing conditions, aesthetics, and practical concerns
- Vegetable garden planning: varieties, companion planting, crop rotation, succession planting, seed starting
- Ongoing care: fertilizing, pruning, pest/disease identification, harvest timing, soil health
- Troubleshooting/diagnostics for plant problems
- Calendar generation and "what should I do this week?" queries
- Reads from garden-profile data to give context-aware advice (no repetitive questions)

**Source hierarchy for web search:**
1. University extension services (.edu) — always prefer
2. Reputable nurseries (e.g. swansonsnursery.com) and established horticultural organizations
3. Well-regarded gardening authorities
4. Avoid: random blogs, non-expert sources, non-peer-reviewed content

**Expected structure:** SKILL.md stays concise (framing, principles, source hierarchy). Reference files for deeper content loaded as needed:
- Companion planting reference
- Crop rotation patterns
- Seed starting schedules by zone type
- Fertilizer/amendment guidance
- Other reference files as TDD testing reveals gaps

---

### Skill 3: `landscape-design`
**Purpose:** Interactive landscape architecture and design, including visual mockups.

**Trigger:** Use when the user wants to plan or redesign their yard layout, create a garden design, generate a visual mockup, or think through hardscape and planting zone placement.

**Core responsibilities:**
- Interactive design conversations (ad-hoc "what should I do with my front yard?" OR structured process when user wants one)
- Zone planning: functional areas, hardscape (paths, patios, raised beds, walls), screening/privacy, drainage, sight lines
- Visual mockup generation (two tiers):
  - Quick sketch: simple labeled SVG for exploring layouts
  - Refined plan: scaled top-down SVG with plant symbols, dimensions, legend
- Plant placement integration (reads garden-expert knowledge and profile data)
- Written design documents saved to garden-bot directory
- Reads/writes area files from garden-profile

**Available structured flow (used when user wants guided process, not forced):**
1. Discovery — goals, style, budget, existing features, constraints
2. Zone planning — divide property into functional areas
3. Mockup — visual draft for feedback
4. Plant placement — species selection for each zone
5. Design document — comprehensive written plan

**Expected structure:** SKILL.md has design approach and principles. Reference file(s) for SVG generation patterns/templates.

---

## Cross-Cutting Concerns

### Skill Interaction
- All three skills read from the shared `~/garden-bot/` data directory
- `garden-profile` is the primary writer; other skills may also update data (e.g., landscape-design saves to area files, garden-expert updates the calendar)
- Skills reference each other's capabilities but don't force-load each other (no `@` links)

### Plugin Packaging
- Distributed as a Claude Code plugin
- Skills live under the plugin's `skills/` directory
- Data directory (`~/garden-bot/`) is created on first use during garden-profile onboarding

---

## Implementation Plan

### Phase 1: garden-profile (foundation)
Build the data layer first since the other two skills depend on it.
1. Write SKILL.md with data conventions, onboarding flow, CRUD guidance
2. Create any needed template/reference files
3. TDD: test with pressure scenarios per writing-skills methodology
4. Verify: create a test garden profile, add areas and plants, check file structure

### Phase 2: garden-expert (core knowledge)
Build the broadest skill next.
1. Write SKILL.md with domain framing, source hierarchy, principles
2. Create reference files for deeper topics (companion planting, crop rotation, etc.)
3. TDD: test plant selection, care advice, calendar generation, troubleshooting scenarios
4. Verify: ask gardening questions with and without a populated garden profile

### Phase 3: landscape-design (visual capability)
Build last since it integrates with both other skills.
1. Write SKILL.md with design approach, mockup generation guidance
2. Create reference file for SVG patterns/templates
3. TDD: test ad-hoc design questions and structured design flow
4. Verify: generate mockups, check SVG output, verify design documents are saved correctly

### Phase 4: Plugin packaging & integration testing
1. Package as Claude Code plugin with proper manifest
2. End-to-end test: fresh install → onboarding → design a yard → select plants → generate calendar
3. Cross-skill test: verify data flows correctly between skills

---

## Verification

- **Unit:** Each skill tested individually via TDD pressure scenarios (per writing-skills methodology)
- **Integration:** Cross-skill data flow — profile data available to expert and design skills
- **End-to-end:** Full user journey from onboarding through design, planting, and calendar generation
- **Source quality:** Verify web searches prioritize .edu extension services
- **Data persistence:** Verify garden data survives across sessions (read files in new conversation)
