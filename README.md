# garden-bot

A Claude Code plugin for gardening and landscaping assistance. Manages a persistent garden profile, provides source-backed plant expertise, and creates visual landscape designs — all grounded in your specific property, zone, and conditions.

## Install

**From a marketplace** (if listed):

```
/plugin install garden-bot@marketplace-name
```

**From source:**

```bash
git clone https://github.com/Benny-Lewis/garden-bot.git
claude --plugin-dir ./garden-bot
```

## Skills

### garden-profile

Manages persistent garden data in the current working directory — your property profile, yard areas, plant inventory, calendar, and activity log. On first use, has a conversation to understand your property before creating files. All data is human-readable markdown.

### garden-expert

Gardening domain expertise with web-sourced recommendations. Prioritizes university extension services (.edu), then reputable nurseries and horticultural organizations. Reads your garden profile to ground advice in your specific conditions — zone, soil, sun exposure, existing plants.

### landscape-design

Visual layout and spatial planning for yard areas. Produces ASCII art diagrams showing feature placement with dimensions, orientation, and a legend. Presents designs for approval before saving. Tracks design decisions, updates all affected files, and maintains consistency between the visual and the written plan.

## Data Directory

Garden data is stored in whichever directory you run Claude from. Create a folder for your garden, `cd` into it, and start Claude with the plugin:

```bash
mkdir ~/my-garden && cd ~/my-garden
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
