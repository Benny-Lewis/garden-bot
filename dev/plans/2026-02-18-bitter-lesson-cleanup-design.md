# Bitter Lesson Cleanup — Design

Post-shipping cleanup of garden-bot v0.1.0 to bring the repo into alignment with the skills' lean, Bitter-Lesson-informed philosophy.

**Source analysis:** `2026-02-18-bitter-lesson-review.md` identified 6 friction points. Deepened analysis added 4 more (#7-10). One (#7, persistence gate duplication) was dropped after determining it's correct architecture for independently-loaded skills.

---

## Tasks (in execution order)

### Task 1: Remove `claude-skills-documentation.md`

**Severity:** HIGH
**Action:** `git rm claude-skills-documentation.md`
**Rationale:** 18KB copy of Anthropic's public docs. Not referenced by any skill, not loaded at runtime. Nearly 2x the size of all skills combined.
**Acceptance:** File removed. No references remain.

---

### Task 2: Remove `references/` dirs + redundant `.gitkeep` files

**Severity:** MEDIUM
**Action:** Delete 5 files:
- `skills/garden-expert/references/.gitkeep` (and dir)
- `skills/landscape-design/references/.gitkeep` (and dir)
- `skills/garden-expert/.gitkeep`
- `skills/garden-profile/.gitkeep`
- `skills/landscape-design/.gitkeep`

**Rationale:** `references/` dirs are vestiges of the abandoned knowledge-encoding approach (companion planting tables, SVG templates). `.gitkeep` files are redundant where SKILL.md already keeps the directory tracked.
**Acceptance:** No `.gitkeep` files. No `references/` directories. All skill dirs still tracked via SKILL.md.

---

### Task 3: Rewrite CLAUDE.md for shipped status

**Severity:** MEDIUM

**Keep:**
- Architecture section (plugin manifest, skills, user data paths)
- Skill Authoring lessons learned
- "Don't mention claude in git commit messages"

**Remove:**
- Progress checklist (all tasks complete)
- "Test Data State" section
- "Testing Methodology" section (replace with pointer to `dev/testing/`)
- "landscape-design REFACTOR — Final Status" section
- "Environment" section (stale worktree reference)
- "Web search: Native WebSearch doesn't work" note

**Acceptance:** CLAUDE.md reads as a shipped project's instructions. Under ~50 lines. Skill Authoring lessons preserved. Paths updated to reflect `dev/` restructure (Task 4).

---

### Task 4: Reorganize repo — `docs/` to `dev/`, clean testing structure

**Severity:** MEDIUM

**Action:**
```
docs/                              →  dev/
├── plans/                         →  ├── plans/    (3 plan docs, unchanged)
└── testing/                       →  └── testing/
    ├── 5 analysis/results docs    →      ├── results/     (5 docs moved here)
    ├── 4 transcripts              →      ├── transcripts/  (4 files moved here)
    └── scenario-1-repo/           →      (deleted — wrong data structure)
```

Also update `.gitignore` paths from `docs/` to `dev/`.

**Rationale:** `docs/` implies user-facing documentation. These are development artifacts. Separating transcripts from analysis results makes the testing directory navigable. The scenario-1-repo contains a wrong data structure (`zones/` vs `areas/`) that could mislead.
**Acceptance:** `docs/` gone. `dev/` structure as shown. `.gitignore` updated. No broken references.

---

### Task 5: Annotate plan docs as historical

**Severity:** LOW
**Action:** Add header to both:
- `dev/plans/2026-02-16-garden-bot-design.md`
- `dev/plans/2026-02-16-garden-bot-implementation.md`

**Header:** *"Historical document — reflects what was planned, not what shipped. Key deviations: ASCII replaced SVG, reference files never needed, CWD replaced ~/garden-bot/, MPL-2.0 replaced MIT, manual testing replaced subagent testing. See shipped skills for actual implementation."*

**Acceptance:** Both docs annotated. No other content changes.

---

### Task 6: Fix README install section

**Severity:** LOW
**Action:** Replace placeholder `garden-bot@marketplace-name` with actual marketplace install path:
```
/plugin marketplace add Benny-Lewis/Benny-Lewis-plugins
```
Then install garden-bot from the marketplace UI.

**Acceptance:** README shows working install instructions matching the actual marketplace listing.

---

### Task 7: Remove specific URL from garden-expert

**Severity:** LOW
**Action:** In `skills/garden-expert/SKILL.md`, remove the URL `extension.oregonstate.edu/gardening/vegetables` from the fallback instruction.

**Before:** "If web search returns no results, fetch extension service pages directly (e.g. `extension.oregonstate.edu/gardening/vegetables`)."
**After:** "If web search returns no results, fetch extension service pages directly."

**Rationale:** Specific URL is fragile domain knowledge. Institution names (OSU Extension, WSU Extension) stay for prompt anchoring.
**Acceptance:** No specific URLs in SKILL.md. Institution names remain.

---

## Dropped: Persistence gate consolidation

Both garden-expert and landscape-design duplicate the save discipline ("Before ending your response, save..." / "Do not offer to save and wait for permission."). Initially identified as duplication to consolidate.

**Why dropped:** Skills are loaded independently based on description matching. There's no mechanism for one skill to invoke another. Centralizing save discipline in garden-profile would create a dependency on garden-profile being co-loaded, which isn't guaranteed. The duplication is correct architecture — each independently-loaded module must carry the instructions it needs to function.

---

## Key Lesson Learned

**Skills must be self-contained.** What looks like DRY-violation duplication across skills is actually correct decoupling for a system where skills load independently. Process knowledge (save discipline, read-before-write) must be duplicated in each skill that needs it, because you can't guarantee which combination of skills will be active.
