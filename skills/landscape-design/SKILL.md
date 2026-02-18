---
name: landscape-design
description: Use when the user wants to plan, design, or redesign a yard area, create a visual layout or site plan, arrange features in a space, or iterate on an existing landscape design
---

# Landscape Design

Visual layout and design deliverables for garden and landscape planning. Always reads the working directory first (via garden-profile) for area dimensions, conditions, and existing features.

## Visual Layouts

**When design work involves spatial arrangement, produce a visual layout** showing where features go relative to each other. Include:

- Approximate proportions (not just labeled boxes)
- Labels for all features
- Dimensions or scale reference
- Orientation (N/S/E/W)
- A legend or key for symbols used
- Consistent symbology — check existing area diagrams in the working directory and reuse their conventions

Use dimensions from saved area data. **If dimensions aren't recorded, ask — don't assume.**

Produce layouts as inline art directly in your response — **use basic ASCII characters** (`+ - | . * #`) for consistent rendering across terminals. **Do not generate scripts, coordinate systems, or rendering tools.**

### Iteration Discipline

**When the design changes, regenerate the visual layout immediately.** If the user changes from 4 beds to 2, moves the compost bin, or removes a feature — produce an updated diagram before continuing. Never leave a stale visual that contradicts the current plan.

**Present the visual and get user feedback before saving any design to files — new or modified.** Don't save a design the user hasn't seen and approved.

After presenting a layout, **lead with targeted spatial questions and analysis** — don't wait for open-ended direction.

**The visual and the text must always agree.** This is the most important rule.

## Consolidated Design View

When design work produces spatial decisions, **save a design section in the area file** (e.g., `areas/backyard-south.md`) that includes:

- The visual layout (embedded in the file)
- Zone summary — what goes where and why
- Key decisions — **what** was chosen and **why** (not just structural details)

This is the single source of truth for "what does this area look like?" Even if details appear in other files (plants, calendar, log), the area file should give a complete design picture on its own.

**Update all sections of affected area files** — not just the design section. Don't leave stale notes, goals, or descriptions that contradict the new design.

When a design spans multiple sub-areas, **create or update a parent overview file** (e.g., `backyard.md` for `backyard-north.md` + `backyard-south.md`) with a full-yard visual and zone summary.

## Save Design Work Proactively

**Before ending your response, check every item below** and save to the working directory:

- Visual layouts → embedded in the area file's design section
- New plants from design → `plants/` files
- Scheduled tasks → `calendar.md`
- Design session activity → `log/` **(append-only at the end of the file — add new entries, never edit or reorder previous entries)**

**Do not offer to save and wait for permission.** Save proactively — the user can always edit or delete files later.
