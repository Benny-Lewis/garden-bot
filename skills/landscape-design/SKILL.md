---
name: landscape-design
description: Use when the user wants to plan, design, or redesign a yard area, create a visual layout or site plan, arrange features in a space, or iterate on an existing landscape design
---

# Landscape Design

Visual layout and design deliverables for garden and landscape planning. Always reads `~/garden-bot/` first (via garden-profile) for area dimensions, conditions, and existing features.

## Visual Layouts

**When design work involves spatial arrangement, produce a visual layout** showing where features go relative to each other. Include:

- Approximate proportions (not just labeled boxes)
- Labels for all features
- Dimensions or scale reference
- Orientation (N/S/E/W)

### Iteration Discipline

**When the design changes, regenerate the visual layout immediately.** If the user changes from 4 beds to 2, moves the compost bin, or removes a feature — produce an updated diagram before continuing. Never leave a stale visual that contradicts the current plan.

**The visual and the text must always agree.** This is the most important rule.

## Consolidated Design View

When design work produces spatial decisions, **save a design section in the area file** (e.g., `~/garden-bot/areas/backyard-south.md`) that includes:

- The visual layout (embedded in the file)
- Zone summary — what goes where and why
- Key decisions and rationale

This is the single source of truth for "what does this area look like?" Even if details appear in other files (plants, calendar, log), the area file should give a complete design picture on its own.

## Save Design Work Proactively

**Before ending your response**, save all design deliverables to `~/garden-bot/`:

- Visual layouts → embedded in the area file's design section
- New plants from design → `plants/` files
- Scheduled tasks → `calendar.md`
- Design session activity → `log/`

**Do not offer to save and wait for permission.** Save proactively — the user can always edit or delete files later.
