# garden-bot

Claude Code plugin for gardening and landscaping assistance. It combines:
- persistent garden profile management,
- source-backed gardening diagnosis and recommendations,
- SVG-based landscape design workflows.

## Install

From marketplace:

```text
/plugin marketplace add Benny-Lewis/plugins
/plugin install garden-bot@plugins
```

From source:

```bash
git clone https://github.com/Benny-Lewis/garden-bot.git
claude --plugin-dir ./garden-bot
```

## Requirements

- Web search should be enabled for best `garden-expert` citation quality.
- Without web search, `garden-expert` still responds but source reliability can degrade.

## Enforced Contracts

- Final response line: final non-empty line must be exactly:
  - `Saved: <paths>`, or
  - `Saved: none - <reason>`
- Design preview-vs-canonical save gating:
  - Before approval, write preview SVGs only:
    - `areas/{area-name}-option-a.svg`
    - `areas/{area-name}-option-b.svg`
  - Before approval, do not modify canonical design/persistence files:
    - `areas/{area-name}-layout.svg`
    - area `.md`
    - `calendar.md`
    - `log/`
    - `plants/`
  - After approval, write canonical `areas/{area-name}-layout.svg` and related markdown updates.
- SVG open policy:
  - Prefer Google Chrome; otherwise default web browser.
  - On Windows, launch Chrome directly when available.
  - Never open editor/design apps for SVG review.

## Regression Evidence Requirements

For runs from `dev/testing/scripts/retest-runner.ps1`, retain:
- `saved-contract-turn*.txt` for each turn.
- `diff-snap*.txt` for normal turns.
- `snap-failure-*.csv` and `diff-*-failure-vs-*.txt` for failed/interrupted turns.
- For scenarios 3/4/5: `open-evidence.md` with opened path, observed app, timestamp, and screenshot reference or explicit note.

## Repository Docs

- Main docs index: `docs/README.md`
- Plans: `docs/plans/README.md`
- Testing results: `docs/testing/results/README.md`
- Run artifact retention: `dev/testing/runs/README.md`
- Regression harness: `dev/testing/regression-harness.md`

## Skills

### garden-profile
Manages persistent garden data in the working directory (profile, areas, plants, calendar, log). First run is conversation-first before writing files.

### garden-expert
Provides source-backed diagnosis and actions grounded in local garden context.

### landscape-design
Creates SVG layout options with approval gating and canonical-save rules.

## Data Directory

Garden data is stored in the directory where Claude is run:

```bash
mkdir my-garden && cd my-garden
claude --plugin-dir /path/to/garden-bot
```

Typical files:

```text
./
|-- profile.md
|-- areas/
|-- plants/
|-- calendar.md
`-- log/
```

## License

MPL-2.0
