---
name: garden-profile
description: Manages persistent garden files in the current working directory. Use when the user asks to set up, read, or update saved garden state (for example "start tracking my garden", "record this planting", or "update my backyard notes"). Do not use for standalone diagnosis or layout-only requests unless persistence is required.
---

# Garden Profile

Manages persistent garden data in the current working directory. Check the working directory first for existing garden files.

## Data Directory

Location: the current working directory (the user chooses where data lives by running Claude from that folder).

```text
./
|- profile.md
|- areas/
|  |- front-yard.md
|  |- backyard.md
|  `- side-yard.md
|- plants/
|  |- japanese-maple.md
|  `- tomatoes-2026.md
|- calendar.md
`- log/
   `- 2026-02.md
```

## Reading Data

Before answering garden questions, read `profile.md` and relevant area/plant files. Never ask for information already recorded.

## Writing Data

- Use markdown files only.
- Keep one file per area in `areas/` (for example `backyard.md`).
- Keep one file per plant or planting group in `plants/`.
- Keep monthly logs in `log/YYYY-MM.md` and append only.
- Read before write. Do not overwrite whole files when a section update is enough.

## First-Time Setup

If `profile.md` does not exist, have a conversation before creating files. Ask for goals, experience, soil, irrigation, existing features, and intended yard use. Create files only after enough context is gathered.

## Progressive Infrastructure

When recording new information, create supporting files as needed:
- new plant -> update `plants/` and relevant `areas/` file,
- new area -> create `areas/{area}.md`,
- any activity -> append to current month in `log/`.

Build data incrementally. Do not require full setup before recording useful facts.

## Schema Flexibility

Use flexible schemas and add fields only when they improve decisions for this user.

## Save Contract

When you create or update files, save directly in this turn.

Never claim files were saved unless those writes completed this turn.

Final line must be single-line `Saved: <paths>` or `Saved: none - <reason>`. Nothing may follow.

## Failure Modes

- If expected garden files are missing, state what is missing, ask targeted follow-ups, then create only the files needed for this turn.
- If a file is unreadable or write fails (for example permission denied), report the path and error plainly, continue with accessible files, and end with `Saved: none - <reason>` when no writes succeed.

## Examples

- Should trigger: "Start tracking my garden and save today's updates."
- Should not trigger: "What disease causes black spots on tomato leaves?"
- Expected behavior: manage local garden files and persistence; do not run diagnosis workflow unless persistence is requested.
