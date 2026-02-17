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

---

# GREEN Phase Results (With Skill)

All 3 scenarios re-run with garden-expert AND garden-profile loaded. Same prompts, fresh sessions, same data state.

## Scenario 1: Plant Selection — PARTIAL PASS

**Improvements over baseline:**
- ✅ Loaded garden-expert, read backyard-north.md, referenced specific conditions
- ✅ Attempted web search ("best evergreen ground covers under oak tree Pacific Northwest shade clay soil university extension")
- ✅ Attempted multiple .edu URL fetches (OSU Extension) — eventually reached OSU Extension pages
- ✅ Cited 3 sources at the bottom (OSU Extension URLs)
- ✅ Better plant knowledge — warned AGAINST Vinca minor (invasive in Oregon), which baseline had recommended
- ✅ New insight about oak irrigation sensitivity (summer watering can cause root rot)
- ✅ Layered planting design suggestion (sword ferns + wild ginger + creeping Oregon grape)

**Remaining gaps:**
- ❌ Web search returned 0 results (platform issue, not skill issue)
- ❌ Many 404 errors guessing at OSU Extension URLs — inefficient, ~2m 45s runtime
- ❌ Cited source URLs may not all be accurate (one was never successfully fetched)
- ❌ Did NOT save plant recommendations — offered at the end but didn't write files

## Scenario 2: Troubleshooting — PASS

**Improvements over baseline:**
- ✅ Read garden profile FIRST — checked context before diagnosing
- ✅ Noticed the seasonal mismatch: "I notice it's mid-February in Portland, and tomatoes wouldn't normally be outdoors yet. Are these indoor/greenhouse tomatoes?"
- ✅ Asked clarifying question about growing situation (baseline skipped this entirely)
- ✅ Attempted web searches for diagnosis confirmation
- ✅ Successfully fetched UMN Extension early blight page AND OSU Extension catalog
- ✅ Cited UMN Extension by name in response ("per UMN Extension")
- ✅ Portland-specific advice: clay soil + no irrigation → soaker hose recommendation

**Remaining gaps:**
- ❌ Web searches returned 0 results (same platform issue)
- ❌ Asked the seasonal question but gave full diagnosis anyway rather than waiting for answer
- ❌ Did NOT log the disease issue or update any garden data files — offered at the end

## Scenario 3: Seasonal Planning — PASS

**Improvements over baseline:**
- ✅ Read all 7 garden-bot files (profile, 4 areas, calendar, log)
- ✅ Attempted web searches (3 queries, all 0 results — platform issue)
- ✅ Successfully fetched OSU Extension vegetables page AND EC 871 (Vegetable Gardening in Oregon)
- ✅ Referenced EC 871 specifically: "Per OSU Extension (EC 871): add agricultural-grade lime"
- ✅ PNW-specific tomato varieties with rationale (Stupice, Siletz, Early Girl — cool maritime climate)
- ✅ **PROACTIVELY WROTE 3 FILES:**
  - Created `~/garden-bot/areas/raised-bed-01.md` — specs, soil mix, layout diagram, planting plan
  - Updated `~/garden-bot/log/2026-02.md` — planning session entry with action items
  - Updated `~/garden-bot/calendar.md` — added "2026 Action Items" checklist under February
- ✅ Succession planting, companion planting (basil + tomatoes), bed layout, spacing details
- ✅ Prioritized infrastructure: "Build & Fill the Bed (Do This First)"

**Remaining gaps:**
- ❌ Web searches all returned 0 results (platform issue)
- ❌ Guessing at URLs with many 404s before finding working pages
- ❌ No `plants/` files created — created area file but not individual plant records

## GREEN Phase Summary

| RED Phase Gap | Status | Notes |
|---|---|---|
| Source quality | ✅ Improved | Attempts web search every time, falls back to direct .edu fetches, cites sources. Web search tool returning 0 is a platform issue. |
| Data persistence | ⚠️ Inconsistent | Scenario 3 proactively wrote 3 files. Scenarios 1 & 2 only offered. No `plants/` files created in any scenario. |
| Diagnostic methodology | ✅ Fixed | Scenario 2 now checks context first, notices seasonal mismatch, asks clarifying question. |
| Calendar + state synthesis | ✅ Fixed | Scenario 3 reads all data, prioritizes infrastructure, references calendar timing. |

### New Issues Found

1. **Web search tool returns 0 results** — consistent across all scenarios. Claude falls back to guessing URLs, many 404s. Not a skill issue but affects source quality.
2. **Persistence inconsistency** — Scenario 3 wrote files proactively; Scenarios 1 & 2 only offered. The skill says "don't just chat — persist them" but compliance varies.
3. **No `plants/` files** — skill says "Plant selections → create or update files in ~/garden-bot/plants/" but no scenario created plant files. Scenario 3 created an area file instead.

---

# REFACTOR Phase Results

Five targeted edits to SKILL.md, then re-tested Scenarios 1 and 2.

**SKILL.md changes:**
1. Persistence gating — "Before ending your response" + "Do not offer to save and wait for permission"
2. Explicit plants/ requirement — "Every plant you recommend → create a file in ~/garden-bot/plants/"
3. Wait for answers — "Wait for answers before giving a diagnosis" (bolded)
4. Source fallback — "If web search returns no results, fetch extension service pages directly"
5. Citation accuracy — "Only cite URLs you actually retrieved successfully — never guess at URLs"

**MCP web search installed** between GREEN and REFACTOR testing, fixing the platform-level search failure.

## Scenario 1: Plant Selection — PASS

- ✅ MCP web search worked — found real extension service results
- ✅ **Created 4 plant files** in `~/garden-bot/plants/`: cascade-oregon-grape.md, sword-fern.md, wild-ginger.md, evergreen-violet.md
- ✅ Updated `~/garden-bot/areas/backyard-north.md` with layered ground cover plan
- ✅ Updated `~/garden-bot/log/2026-02.md` with planning session entry
- ✅ Updated `~/garden-bot/calendar.md` with October planting task
- ✅ All file writes proactive — no "would you like me to save?" prompting
- ✅ Cited sources from actual search results

All GREEN-phase persistence gaps resolved. Every recommended plant got its own file.

## Scenario 2: Troubleshooting — PASS

- ✅ **Asked 3 clarifying questions** (growing location, watering method, progression timeline) and **waited for answers** before diagnosing
- ✅ MCP web search found UMD Extension, WVU Extension, UMN Extension pages
- ✅ Fetched full UMD Extension early blight page for confirmation
- ✅ **3 verified .edu sources cited** — all from actual search results
- ✅ Diagnosis tailored to indoor seedlings: seed-borne spores as likely vector, fan for air circulation, crowded spacing as risk factor
- ✅ **Created `~/garden-bot/plants/tomatoes-2026.md`** proactively with status and issue history
- ✅ **Updated `~/garden-bot/log/2026-02.md`** with early blight entry and treatment actions

Every REFACTOR fix confirmed working. The wait-for-answers change produced a meaningfully better diagnosis — indoor-specific advice rather than generic outdoor early blight treatment.

## REFACTOR Summary

| REFACTOR Fix | Scenario 1 | Scenario 2 |
|---|---|---|
| Persistence gating | ✅ 4 plant files + area + log + calendar | ✅ plant file + log |
| Explicit plants/ files | ✅ 4 individual plant files | ✅ tomatoes-2026.md |
| Wait for answers | n/a (not diagnostic) | ✅ 3 questions, waited, then diagnosed |
| Source fallback | ✅ MCP search worked | ✅ MCP search worked |
| Citation accuracy | ✅ Verified URLs only | ✅ 3 .edu URLs from search results |

All RED-phase gaps closed. garden-expert skill complete.
