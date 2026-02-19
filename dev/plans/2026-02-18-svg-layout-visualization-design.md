# SVG Layout Visualization Design

**Date:** 2026-02-18
**Status:** Approved — implementation complete

## Problem

The landscape-design skill produces ASCII art layouts (`+ - | . * #`) for garden/landscape plans. While functional and token-efficient, ASCII lacks spatial accuracy, color coding, and visual quality. Users can't easily distinguish features or assess proportions.

## Decision

Replace ASCII with direct SVG generation. Claude writes SVG markup and saves as `.svg` files — zero dependencies, opens in any browser.

### Options Considered

| Option | Visual Quality | Dependencies | Token Cost | Verdict |
|--------|---------------|-------------|-----------|---------|
| ASCII (current) | Low | None | Low | Insufficient visual quality |
| Raw SVG | High | None | Medium (~3x ASCII) | **Selected** — best simplicity/quality ratio |
| Excalidraw MCP | Very High | MCP + browser | Low | Too much infrastructure |
| Mermaid MCP | Medium | MCP | Low | Wrong tool (flowcharts, not spatial) |
| D2 / Kroki | High | API or Docker | Low-Medium | Graph-oriented, not spatial |
| HTML Canvas | Very High | None | High | Conflicts with "no scripts" finding #11 |

### Why SVG

- Zero dependencies — SVG is just XML text
- Pixel-precise positioning with real coordinates
- Color coding makes features instantly distinguishable
- Opens in any browser, scales perfectly
- ~120 lines / ~4,500 chars for a full backyard layout — manageable token cost
- Direct output (no multi-step script pipeline that caused finding #11 failures)

## Changes to landscape-design SKILL.md

Three edits:

1. **Visual format** (line 23-25): Replace ASCII instruction with SVG file generation + color conventions + auto-open in browser
2. **Consolidated design view** (line 45): Embedded ASCII → linked SVG (`![Layout](area-layout.svg)`)
3. **Save checklist** (line 61): Updated to match SVG file pattern

## Iteration Flow

1. Claude generates SVG → saves as `{area-name}-layout.svg`
2. Opens in user's default browser automatically
3. User views and gives feedback
4. Claude regenerates SVG → opens updated version
5. Repeat until approved → saves link in area `.md` file

## SVG Conventions

- Simple elements only: `<rect>`, `<circle>`, `<text>`, `<line>`, `<ellipse>`
- Color coding: green (planting), brown (beds/wood), gray (hardscape), blue (water)
- Required: compass, dimensions, legend, labels
- No embedded scripts or animations
- File naming: `{area-name}-layout.svg`

## Sample

See `dev/samples/backyard-layout-sample.svg` for a reference implementation.

## Verification Needed

- Test with existing scenarios (especially Scenario 2: mockup request, Scenario 3: structured design with iteration)
- Confirm SVG regeneration works on design changes (the critical iteration test)
- Confirm auto-open works cross-platform
