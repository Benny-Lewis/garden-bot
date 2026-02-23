---
name: landscape-design
description: Use when the user wants to plan, design, or redesign a yard area, create a visual layout or site plan, arrange features in a space, or iterate on an existing landscape design
---

# Landscape Design

Create and maintain spatial landscape designs. Read existing garden files first and cite known dimensions/zone before asking new questions.

## Visual Layouts

When design work is spatial, produce a visual layout with:

- Approximate proportions (not just labeled boxes)
- Labels for all features
- Dimensions or scale reference
- Orientation (N/S/E/W)
- A legend/key
- Consistent symbology (reuse conventions from existing area diagrams)

Use dimensions from saved area data. **If dimensions aren't recorded, ask — don't assume.**

Use SVG visuals. Before approval, write preview files only (for example `{area-name}-option-a.svg`, `{area-name}-option-b.svg`) and open them for review. Before approval, do not update `{area-name}-layout.svg`, area `.md`, `calendar.md`, `log/`, or `plants/`. After approval, save `{area-name}-layout.svg` and related files. Use only `<rect>`, `<circle>`, `<text>`, `<line>`; no scripts/animations. Colors: green=planting, brown=beds, gray=hardscape, blue=water. Open in Google Chrome when available, otherwise default web browser. On Windows, launch Chrome directly instead of relying on `.svg` association. Never open editor/design apps.

### Iteration Discipline

When the design changes, regenerate the visual immediately before continuing.

Present the visual and get feedback before saving any design (new or modified).

Do not add unrequested features to committed designs. Put extras in `Optional ideas` until approved.

After showing a layout, lead with targeted spatial questions and analysis.

When multiple layouts are plausible, show 2 options with tradeoffs before saving either one.

## Consolidated Design View

When spatial decisions are made, save a design section in the area file with:

- Link to the layout SVG (`![Layout](backyard-south-layout.svg)`)
- Zone summary — what goes where and why
- Key decisions — **what** was chosen and **why** (not just structural details)

If the user gives style words (for example Japanese, cottage, PNW native), translate them into concrete choices (forms, materials, plant structure, circulation) in the zone summary.

Update all sections of affected area files, not only the design section. Remove stale notes/goals/descriptions.

When a design spans multiple sub-areas, create/update a parent overview file with a full-yard visual and zone summary.

## Save Design Work Proactively

After user approval and before ending your response, save to the working directory:

- Visual layouts → `{area-name}-layout.svg` next to the area file, linked from its design section
- New plants from design → `plants/` files
- Scheduled tasks → `calendar.md`
- Design session activity → `log/` **(append-only at the end of the file — add new entries, never edit or reorder previous entries)**

If you mention future actions (build, buy, plant, move, install, prune), you MUST add them to `calendar.md` with a concrete month/date.

Do not offer to save and wait for permission. Save proactively.

Never claim files were saved unless those writes completed this turn.

Final line must be single-line `Saved: <paths>` or `Saved: none - <reason>`. Nothing may follow.
