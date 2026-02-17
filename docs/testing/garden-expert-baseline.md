# garden-expert Baseline Testing (RED Phase)

## Methodology

Tests run WITH garden-profile loaded but WITHOUT garden-expert — the realistic deployment scenario. This isolates expertise gaps from data-access issues (already solved by garden-profile).

**Data state:** `~/garden-bot/` populated from REFACTOR testing — profile, 4 area files, calendar, one log entry, empty `plants/`. Rich context available but no planted inventory.

**Environment:** Fresh sessions at `~/dev/landscaping-gardening/`, natural prompts, plugin via:
```
claude --plugin-dir ~/dev/garden-bot/.worktrees/skill-implementation
```

**What we're looking for** (things garden-expert should improve):
- **Source quality** — .edu / extension services vs generic or no citations
- **Tailored vs generic** — does it use the user's zone, soil, conditions, or give a listicle?
- **Data persistence** — does it save recommendations to plant/area files, or just chat?
- **Deep knowledge** — companion planting, succession planting, diagnostic methodology

---

## Scenario 1: Plant Selection

**Prompt:** "I want to start planting under the oak tree in my backyard. What ground covers would work well there? I want something low-maintenance and evergreen if possible."

Tests whether Claude gives sourced, condition-specific recommendations and saves them. `backyard-north.md` already has "Ideas to Explore" with native suggestions — does it go beyond repeating those? Does it cite sources, consider oak root zone constraints, address the evergreen request specifically?

---

## Scenario 2: Troubleshooting

**Prompt:** "The lower leaves on my tomato plants are turning yellow with dark brown spots. The spots have concentric rings. What's going on and what should I do?"

Tests diagnostic methodology. Classic early blight pattern — but it's February in zone 8b, so tomatoes shouldn't be in the ground. Does Claude ask clarifying questions (indoor starts? greenhouse?) or jump to diagnosis? Does it cite authoritative sources? Does it notice the seasonal context?

---

## Scenario 3: Seasonal Planning

**Prompt:** "I want to start my vegetable garden. I'm thinking a 4x8 raised bed in the sunny part of my backyard. What should I be doing right now, what should I plant for spring, and how should I arrange things?"

Merges calendar/timing with veggie planning. `calendar.md` has February tasks, `backyard-south.md` is planned for veggies, but NO beds exist yet and soil is untested. Does Claude synthesize the actual state (need infrastructure first) with planting advice? Does it do companion planting layout, succession planting, zone-specific timing? Does it save the plan?

---

## Baseline Results

### Scenario 1: Plant Selection
**Result: GOOD advice, NO sourcing, NO persistence**

Read `backyard-north.md`, referenced specific conditions (shade, damp clay, oak roots). Went beyond the "Ideas to Explore" list — added Pachysandra, Vinca minor, low Oregon grape. Practical tips were strong (don't dig, use oak leaves as mulch, plant in fall, start with patches). Addressed "evergreen" request explicitly and noted semi-evergreen species separately.

- Source quality: **Zero.** No web search, no .edu references, no extension service links. Pure built-in knowledge.
- Data persistence: Offered to save at the end but didn't write anything proactively.

---

### Scenario 2: Troubleshooting
**Result: CORRECT diagnosis, NO methodology, NO context awareness**

Correctly identified early blight (Alternaria solani) from the concentric ring pattern. Treatment advice was solid and well-organized (remove leaves, mulch, water at base, fungicide options, prevention).

- Diagnostic methodology: **Jumped straight to diagnosis.** No clarifying questions — didn't ask indoor/outdoor, container, growing setup. Critical miss: it's February in zone 8b, tomatoes shouldn't have foliage outside. Completely ignored the seasonal mismatch.
- Source quality: **Zero.** No web search, no citations.
- Data interaction: **Deliberately skipped.** Thinking block said "they're asking for diagnostic help, I'll just answer directly" — didn't check `~/garden-bot/` for tomato records or profile context. Loaded garden-profile but chose not to use it.

---

### Scenario 3: Seasonal Planning
**Result: STRONG synthesis, NO sourcing, NO persistence**

Read all 6 files (profile + 4 areas + calendar). Excellent state awareness — "Build & Fill the Bed" as priority #1, noted soil untested, referenced calendar February tasks. Provided a spring planting sequence table with timing. Drew an ASCII bed layout with height-based north-south arrangement. Explained succession planting well (peas/radishes harvested before warm-season crops). Mentioned PNW seed companies and OSU Extension (from profile data, not from a search).

- Source quality: **Zero web searches.** Mentioned OSU and seed companies by name but didn't actually search or cite anything.
- Deep knowledge: Succession planting ✅. Basil + tomatoes placed together (implicit companion planting) but no explicit companion planting framework. No crop rotation discussion.
- Data persistence: Offered to record but wrote nothing.

---

## Analysis

### Pattern: Three Consistent Gaps

**1. Source quality (every scenario):** Claude never searched the web and never cited authoritative sources. All advice came from built-in knowledge. The advice was generally correct, but there's no way for the user to verify it, and no .edu/extension service backing. This is the clearest gap for garden-expert to fix.

**2. Data persistence (scenarios 1 & 3):** Claude offered to save recommendations but didn't do it proactively. Garden-profile teaches read-before-write, but nothing tells Claude to write plant selections or plans back to data files unless asked. Scenario 2 didn't even consider logging the disease issue.

**3. Diagnostic methodology (scenario 2):** No clarifying questions, no context check, no seasonal awareness. Claude jumped from symptoms to diagnosis without considering the user's specific situation. The garden-expert skill needs to teach: check context first, ask questions, then diagnose.

### What the Skill Must Teach

1. **Source hierarchy** — search the web, prioritize .edu extension services (.edu > reputable nurseries > established authorities), cite sources in responses
2. **Save recommendations** — when suggesting plants or plans, write to `plants/` files and update area files proactively, not just when asked
3. **Diagnostic methodology** — check garden profile context first, ask clarifying questions before diagnosing, note seasonal context
4. **Calendar + state synthesis** — Claude did this well in Scenario 3 but should also do it for troubleshooting (Scenario 2's seasonal miss)

### What Claude Already Does Well (Don't Duplicate)

- **Tailored advice** — with garden-profile providing data access, advice was genuinely condition-specific, not generic listicles
- **Gardening knowledge** — plant selection, treatment protocols, raised bed setup, succession planting concepts are all solid
- **Layout/planning** — the bed layout in Scenario 3 was practical and well-reasoned (height-based arrangement, succession timing)
- **Reading garden data** — garden-profile handles this; garden-expert doesn't need to re-teach it
- **Tone and practicality** — advice was actionable, not academic
