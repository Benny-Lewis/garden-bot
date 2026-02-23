# SVG Layout Visualization Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace ASCII art layout generation with SVG file generation in the landscape-design skill, and auto-open SVGs in the user's browser for seamless iteration.

**Architecture:** Three targeted edits to `skills/landscape-design/SKILL.md` â€” swap the ASCII format instruction for SVG, update the consolidated design view to link SVGs instead of embedding ASCII, and update the save checklist. Must stay under 500-word skill limit (currently ~503 words, so net word count must decrease or stay flat).

**Tech Stack:** SVG (XML markup), markdown skill files

---

### Task 1: Edit SKILL.md â€” Replace ASCII with SVG format instruction

**Files:**
- Modify: `skills/landscape-design/SKILL.md:23`

**Step 1: Replace the ASCII format line**

Replace line 23:
```
Produce layouts as inline art directly in your response â€” **use basic ASCII characters** (`+ - | . * #`) for consistent rendering across terminals. **Do not generate scripts, coordinate systems, or rendering tools.**
```

With:
```
**Produce layouts as SVG files** saved as `{area-name}-layout.svg` alongside the area `.md` file. Simple elements only (`<rect>`, `<circle>`, `<text>`, `<line>`). No scripts or animations. Colors: green=planting, brown=beds, gray=hardscape, blue=water. **After saving or updating an SVG, open it in the user's default browser.**
```

**Why this wording:** Compact to offset word count. Drops `<ellipse>` (can use `<circle>` with `rx`/`ry` via transform if needed â€” not worth a word). Color conventions inline rather than verbose sentences. Auto-open instruction is one sentence, not a separate paragraph.

**Step 2: Verify word count change**

Old line: ~30 words. New text: ~46 words. Net: +16 words. Need to recover these in Tasks 2-3.

---

### Task 2: Edit SKILL.md â€” Update consolidated design view

**Files:**
- Modify: `skills/landscape-design/SKILL.md:39`

**Step 1: Replace embedded visual with SVG link**

Replace line 39:
```
- The visual layout (embedded in the file)
```

With:
```
- Link to the layout SVG (e.g., `![Layout](backyard-south-layout.svg)`)
```

**Why:** "Link to the layout SVG" is slightly shorter than "The visual layout (embedded in the file)" while being more specific. Net: ~0 words (roughly same length).

---

### Task 3: Edit SKILL.md â€” Update save checklist

**Files:**
- Modify: `skills/landscape-design/SKILL.md:53`

**Step 1: Replace save checklist visual layouts line**

Replace line 53:
```
- Visual layouts â†’ embedded in the area file's design section
```

With:
```
- Visual layouts â†’ `{area-name}-layout.svg` next to the area file, linked from its design section
```

**Why:** Matches new SVG file workflow. Net: +4 words.

---

### Task 4: Trim word count to stay under 500

**Files:**
- Modify: `skills/landscape-design/SKILL.md` (various lines)

After Tasks 1-3, we're ~+20 words over the starting 503 (~523). Need to cut ~25+ words to get under 500.

**Step 1: Identify trimmable phrases**

Candidates (preserving meaning while cutting words):

| Line | Current | Proposed | Words saved |
|------|---------|----------|-------------|
| 12 | "**When design work involves spatial arrangement, produce a visual layout** showing where features go relative to each other. Include:" | "**When design work involves spatial arrangement, produce a visual layout.** Include:" | ~8 |
| 19 | "Consistent symbology â€” check existing area diagrams in the working directory and reuse their conventions" | "Consistent symbology â€” reuse conventions from existing area diagrams" | ~5 |
| 27 | "If the user changes from 4 beds to 2, moves the compost bin, or removes a feature â€” produce an updated diagram before continuing. Never leave a stale visual that contradicts the current plan." | "If the user changes from 4 beds to 2 or moves the compost bin â€” regenerate the diagram before continuing." | ~12 |
| 43-44 | "This is the single source of truth for "what does this area look like?" Even if details appear in other files (plants, calendar, log), the area file should give a complete design picture on its own." | "This is the single source of truth for the area's design, even if details appear in other files." | ~15 |

Total recoverable: ~40 words. Target: cut ~25 to land at ~498.

**Step 2: Apply trims**

Make edits from the table above, selecting enough to get under 500.

**Step 3: Verify final word count**

Run: `wc -w skills/landscape-design/SKILL.md`
Expected: under 500

---

### Task 5: Verify and commit

**Step 1: Re-read full SKILL.md**

Read the complete file. Verify:
- [ ] No stale ASCII references remain
- [ ] SVG instructions are clear and complete
- [ ] Iteration discipline still references "visual layout" (not "ASCII")
- [ ] Consolidated design view references SVG link
- [ ] Save checklist references SVG file
- [ ] File is coherent end-to-end, no contradictions
- [ ] Word count is under 500

**Step 2: Verify sample SVG exists**

Confirm `dev/samples/backyard-layout-sample.svg` is present as reference material.

**Step 3: Commit**

```bash
git add skills/landscape-design/SKILL.md docs/plans/archive/2026-02-18-svg-layout-visualization-design.md docs/plans/archive/2026-02-18-svg-layout-implementation.md dev/samples/backyard-layout-sample.svg
git commit -m "Replace ASCII layouts with SVG generation in landscape-design skill"
```

---

### Task 6: Manual testing (separate session)

**This task runs in a separate session with the updated plugin.**

**Step 1: Test Scenario 2 (mockup request)**

Prompt: "Can you create a visual layout showing where to put two 4x8 raised beds, a compost bin, and a seating area in my backyard?"

Verify:
- [ ] Claude generates an `.svg` file (not ASCII art, not a script)
- [ ] SVG is saved as `{area-name}-layout.svg`
- [ ] SVG opens automatically in the browser
- [ ] SVG includes labels, dimensions, compass, legend, color coding
- [ ] Design section in area file links to the SVG

**Step 2: Test Scenario 3 iteration (critical test)**

Prompt: "I'd like to do a full landscape design for my backyard."
Then after first layout: request a change (e.g., "move the compost bin to the other side").

Verify:
- [ ] Claude regenerates SVG on design change
- [ ] Updated SVG opens in browser automatically
- [ ] Area file is updated with new SVG link
- [ ] No stale SVG or stale text remains

