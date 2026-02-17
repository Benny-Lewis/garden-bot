# garden-profile Baseline Testing (RED Phase)

## Methodology

**Round 1 (subagent-dispatched) — DISCARDED due to contamination:**
1. Test prompts told agents "you are being tested" — changed behavior
2. Self-report questions skewed results
3. Design docs at `~/dev/garden-bot/` were accessible and used as de facto instructions

**Round 2 (manual, isolated) — VALID results below:**
- User ran tests in fresh Claude Code sessions at `~/dev/landscaping-gardening/`
- Natural prompts only, no mention of testing
- Design docs NOT in working directory
- Behavior observed from transcripts, not self-reports

---

## Scenario 1: New User Onboarding

**Prompt:** "I just moved into a new house in Portland, Oregon (zone 8b). I have a south-facing front yard (~800 sq ft) and a larger backyard (~2000 sq ft) with a big oak tree that shades the north half. Help me set up tracking for my garden so I can manage everything."

**Result: PARTIAL — created tracking but with non-standard structure**

Agent behavior:
- Created all files in CWD (`~/dev/landscaping-gardening/`), not in `~/garden-bot/`
- Used `zones/` directory instead of `areas/`
- Created a single `plants.md` table instead of one file per plant
- Created `logs/daily/` structure instead of monthly logs
- Expanded profile with Portland-specific content (frost dates, climate notes)
- Created a 12-month calendar tailored to zone 8b
- Did NOT ask clarifying questions about goals, experience, irrigation, or budget

**Key observations:**
- Claude is capable of creating comprehensive garden tracking without a skill
- But the structure is inconsistent with our planned conventions
- No canonical data directory — just used CWD
- No onboarding conversation — jumped straight to file creation
- Good Portland-specific content, proving domain knowledge isn't the issue

---

## Scenario 2: Recording a New Planting

**Prompt:** "I planted three blueberry bushes (Duke variety) along the fence in my side yard last Saturday. The soil there is slightly acidic which they should love. Can you record that in my garden records?"

**Result: MINIMAL — created single flat file**

Agent behavior:
- Created a single `garden-log.md` file in CWD with planting details
- Did NOT create any directory structure (no areas/, plants/, or log/)
- Did NOT create an area file for the side yard
- Did NOT create a plant file for the blueberries
- Matched the minimal scope of the request — user said "record," agent recorded
- Did NOT ask clarifying questions

**Key observations:**
- Without existing infrastructure or a skill, Claude does the minimum
- A single flat file is reasonable for "record this" but doesn't build toward a useful system
- No progressive infrastructure creation — doesn't think ahead about future queries
- Contrast with Scenario 1: when asked to "set up tracking," agent creates structure; when asked to "record," agent creates a single file

---

## Scenario 3: Retrieving Garden Data

**Setup:** Data pre-populated at `~/garden-bot/` (profile.md + areas/backyard.md). Agent launched from `~/dev/landscaping-gardening/` (empty directory, no garden data in CWD).

**Prompt:** "What plants do I currently have in my backyard? And what are the conditions like back there?"

**Result: FAIL — did not find existing data**

Agent behavior:
- Searched only the CWD (`~/dev/landscaping-gardening/`)
- Did NOT discover `~/garden-bot/` where the actual data lives
- Concluded there is no data about the user's backyard
- Offered to set up new files to track the information
- Did NOT search home directory or common locations

**Key observations:**
- Without the skill specifying where data lives, Claude can't find it
- Agent searched CWD thoroughly but didn't broaden search to home directory
- This is the strongest argument for the skill: data discovery is not automatic
- Even though `~/garden-bot/` is a reasonable, discoverable name, Claude didn't look there

---

## Analysis: What the Skill Must Teach

These three baseline failures reveal exactly what `garden-profile` needs to address:

### 1. Canonical data directory (CRITICAL)
Scenario 3 proves this is essential. Without the skill specifying `~/garden-bot/` as the data location, Claude can't find existing data. The skill must:
- Specify `~/garden-bot/` as the canonical location
- Handle first-time setup (create directory if it doesn't exist)
- Always check this location before concluding no data exists

### 2. Consistent file structure conventions (HIGH)
Scenarios 1 and 2 show wildly different approaches without guidance:
- Scenario 1: `zones/`, single `plants.md`, `logs/daily/`
- Scenario 2: single flat file, no structure at all
The skill must specify: `areas/`, one file per plant in `plants/`, monthly logs in `log/`

### 3. Progressive infrastructure (HIGH)
Scenario 2 shows Claude does the minimum when asked to "record." The skill should encourage building infrastructure progressively — recording a planting should create the area file and plant file, not just a log entry.

### 4. Onboarding conversation (MEDIUM)
Scenario 1 shows Claude jumps to file creation without asking about goals, experience, or constraints. The skill should guide an onboarding conversation for new users (without being rigidly scripted).

### 5. Data integrity (MEDIUM)
The skill should ensure: read before write, don't lose existing content, append to logs rather than overwrite.

---

# GREEN Phase Results (With Skill)

All three scenarios re-run in isolated sessions with the garden-profile skill loaded via `claude --plugin-dir`. Full transcripts in `docs/testing/scenario*-green-transcript.txt`.

## Scenario 1: New User Onboarding — PASS

**Improvements over baseline:**
- ✅ Created all files at `~/garden-bot/` (not CWD) — CRITICAL fix confirmed
- ✅ Used `areas/` directory with one file per area (not `zones/`)
- ✅ Created `plants/` and `log/` directories upfront
- ✅ Created monthly log `log/2026-02.md` (not daily logs)
- ✅ Profile includes cross-links to area files, frost dates, climate notes
- ✅ Backyard file has sun zone table mapping oak canopy microclimates
- ✅ Portland-specific content (OSU Extension reference, clay soil notes)

**Remaining gap (REFACTOR):**
- ❌ Did not ask onboarding questions — announced plan and created files immediately
- Skill says "walk the user through setup" but agent interpreted this as "tell them what you're creating"

## Scenario 2: Recording a New Planting — PASS

**Improvements over baseline (baseline: single flat file):**
- ✅ Found existing `~/garden-bot/` and built on it
- ✅ Read profile and existing area files before writing
- ✅ Created `plants/duke-blueberries.md` with species, variety, quantity, date, growing conditions
- ✅ Created `areas/side-yard.md` for the new area (progressive infrastructure)
- ✅ Updated `profile.md` — added side yard to areas list
- ✅ Appended to `log/2026-02.md` — did not overwrite existing log entry (data integrity)
- ✅ Correctly noted blueberries are in side yard, not backyard

## Scenario 3: Retrieving Garden Data — PASS

**Improvements over baseline (baseline: complete FAIL, never found data):**
- ✅ Found `~/garden-bot/` immediately from different CWD
- ✅ Read `areas/backyard.md` and reported plants/conditions accurately
- ✅ Rendered sun zone table for the three microclimate zones
- ✅ Correctly noted oak tree as the only backyard plant
- ✅ Correctly distinguished side yard blueberries from backyard
- ✅ Reported unknowns (soil untested, irrigation unassessed) without re-asking
- ✅ Offered relevant next steps

## GREEN Phase Summary

| Issue from RED Phase | Status | Notes |
|---|---|---|
| Canonical data directory (CRITICAL) | ✅ Fixed | All scenarios used ~/garden-bot/ |
| Consistent file structure (HIGH) | ✅ Fixed | areas/, plants/, log/ with correct conventions |
| Progressive infrastructure (HIGH) | ✅ Fixed | Scenario 2 created area + plant files from a simple "record this" |
| Onboarding conversation (MEDIUM) | ❌ Open | Agent announces but doesn't ask questions |
| Data integrity (MEDIUM) | ✅ Fixed | Read-before-write, append-only logs |
