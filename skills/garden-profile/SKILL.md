---
name: garden-profile
description: Use when setting up garden tracking, recording plants or plantings, updating property areas, logging garden activities, or when any garden task needs to read or write persistent garden data. Also use when the user asks about their yard, plants, or garden conditions.
---

# Garden Profile

Manages persistent garden data at `~/garden-bot/`. Always check this directory first — it may already contain the user's garden profile, areas, and plant inventory.

## Data Directory

**Location:** `~/garden-bot/` (create on first use)

```
~/garden-bot/
├── profile.md          # Zone, location, soil, property overview
├── areas/              # One file per yard area
│   ├── front-yard.md
│   ├── backyard.md
│   └── side-yard.md
├── plants/             # One file per plant or planting group
│   ├── japanese-maple.md
│   └── tomatoes-2026.md
├── calendar.md         # Month-by-month task reference
└── log/                # Activity history (append-only)
    └── 2026-02.md      # Monthly log
```

## Reading Data

Before answering any garden question, check `~/garden-bot/` for existing data. Read `profile.md` and relevant area/plant files. Never ask the user for information that's already recorded.

## Writing Data

- **Markdown files** — human-readable, editable outside Claude
- **One file per area** in `areas/` — named by area (e.g., `backyard.md`)
- **One file per plant** in `plants/` — named `{plant-name}.md` or `{plant-name}-{year}.md` for annuals/seasonal plantings
- **Monthly logs** in `log/` — named `YYYY-MM.md`, append-only
- **Read before write** — don't overwrite existing content. Append to logs. Update area/plant files by adding or modifying sections, not replacing the whole file.

## First-Time Setup

If `~/garden-bot/` doesn't exist, walk the user through setup:

1. Ask for location, USDA zone, and property overview
2. Create `profile.md` with their answers
3. Ask about yard areas (front, back, side, etc.)
4. Create area files with dimensions, sun exposure, soil, and notable features

Don't create files silently — confirm what you're setting up.

## Progressive Infrastructure

When recording a new planting or activity, create supporting files if they don't exist yet:
- Recording a plant? Create its `plants/` file AND update the relevant `areas/` file.
- New area mentioned? Create its `areas/` file.
- Any garden activity? Append to the current month's `log/` file.

Build the data directory incrementally — don't require full setup before recording anything.

## Schema Flexibility

Add fields as warranted. These files don't follow a rigid template. Common fields for areas: size, sun, soil, irrigation, features, plants. Common fields for plants: species, variety, location, date planted, care notes. But adapt to what's useful for the user's situation.
