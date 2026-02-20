# garden-bot

A Claude Code plugin for gardening and landscaping assistance. Manages a persistent garden profile, provides source-backed plant expertise, and creates visual landscape designs — all grounded in your specific property, zone, and conditions.

## Install

**From marketplace:**

```
/plugin marketplace add Benny-Lewis/plugins
/plugin install garden-bot@plugins
```

**From source:**

```bash
git clone https://github.com/Benny-Lewis/garden-bot.git
claude --plugin-dir ./garden-bot
```

## Requirements

- Web search must be available for `garden-expert` to provide source-backed recommendations with reliable citations.
- If web search is unavailable, `garden-expert` can still respond but quality and citation reliability may degrade.

## Search Troubleshooting

- Verify your Claude session has web search enabled.
- Re-run in a fresh session if searches return empty results repeatedly.
- Treat repeated empty-search runs as an environment/tooling issue, not a signal to add static gardening reference docs.

## Enforced Contracts

- Final response line contract: the final non-empty line must be exactly `Saved: <paths>` or `Saved: none - <reason>`.
- Design save gating:
  - Before approval, write preview SVG files only (`areas/{area-name}-option-a.svg`, `areas/{area-name}-option-b.svg`).
  - Before approval, do not modify canonical design files (`areas/{area-name}-layout.svg`, area `.md`, `calendar.md`, `log/`, `plants/`).
  - After approval, write canonical `areas/{area-name}-layout.svg` and related markdown updates.
- SVG open policy:
  - Open SVG in Google Chrome when available; otherwise use the default web browser.
  - On Windows, launch Chrome directly instead of relying on `.svg` association.
  - Never open editor/design apps for SVG review.

## Regression Evidence Requirements

For regression runs (`dev/testing/scripts/retest-runner.ps1`), collect and retain:

- `saved-contract-turn*.txt` for each turn.
- `diff-snap*.txt` snapshot diffs for normal turns.
- `snap-failure-*.csv` and `diff-*-failure-vs-*.txt` for failed/interrupted turns.
- For scenarios 3/4/5: `open-evidence.md` with opened file path, observed app, timestamp, and screenshot reference or explicit note.

## Skills

### garden-profile

Manages persistent garden data in the current working directory — your property profile, yard areas, plant inventory, calendar, and activity log. On first use, has a conversation to understand your property before creating files. All data is human-readable markdown.

### garden-expert

Gardening domain expertise with web-sourced recommendations. Prioritizes university extension services (.edu), then reputable nurseries and horticultural organizations. Reads your garden profile to ground advice in your specific conditions — zone, soil, sun exposure, existing plants.

### landscape-design

Visual layout and spatial planning for yard areas. Produces SVG diagrams showing feature placement with dimensions/scale, orientation, labels, and a legend. Presents designs for approval before saving. Tracks design decisions, updates all affected files, and maintains consistency between the visual and the written plan.

## Data Directory

Garden data is stored in whichever directory you run Claude from. Create a folder for your garden, `cd` into it, and start Claude with the plugin:

```bash
mkdir my-garden && cd my-garden
claude --plugin-dir /path/to/garden-bot
```

The plugin will create and manage these files in that directory:

```
./
├── profile.md          # Zone, location, soil, property overview
├── areas/              # One file per yard area
├── plants/             # One file per plant or planting group
├── calendar.md         # Month-by-month task reference
└── log/                # Activity history (append-only)
```

Files are plain markdown — you can read and edit them outside of Claude.

## License

MPL-2.0
