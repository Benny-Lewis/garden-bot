# garden-bot

Claude Code plugin for gardening and landscaping workflows.

Core capabilities:
- persistent garden profile and records,
- source-backed diagnosis and recommendations,
- SVG layout design with approval gating.

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

## Quick Start

```bash
mkdir my-garden && cd my-garden
claude --plugin-dir /path/to/garden-bot
```

Garden data is stored in your current working directory:

```text
./
|-- profile.md
|-- areas/
|-- plants/
|-- calendar.md
`-- log/
```

## Runtime Behavior (Summary)

- Responses must end with a strict final `Saved:` line.
- Design flows must keep preview SVGs separate from canonical writes until approval.
- SVG open target is browser-first (Chrome preferred).

Canonical definitions are in `docs/contracts.md`.

## Documentation

For users:
- Overview: `docs/overview.md`

For contributors:
- Contribution guide: `CONTRIBUTING.md`
- Architecture: `docs/architecture.md`
- Contracts: `docs/contracts.md`
- Regression runbook: `docs/runbooks/regression.md`
- Evidence capture: `docs/runbooks/evidence-capture.md`
- Testing results index: `docs/testing/results/README.md`

## License

MPL-2.0
