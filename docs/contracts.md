# Runtime Contracts

This document is the canonical source of runtime contract requirements.

## 1) Final Response Line Contract

The final non-empty line of every model response must be one of:
- `Saved: <paths>`
- `Saved: none - <reason>`

Notes:
- This is a strict formatting contract.
- Any additional non-empty line after `Saved:` violates the contract.

## 2) Design Preview vs Canonical Save Gating

Before approval:
- Write preview SVG files only under `areas/`:
  - `areas/{area-name}-option-a.svg`
  - `areas/{area-name}-option-b.svg`
- Do not modify canonical files:
  - `areas/{area-name}-layout.svg`
  - area markdown files (`areas/*.md`)
  - `calendar.md`
  - `log/`
  - `plants/`

After approval:
- Write canonical `areas/{area-name}-layout.svg`.
- Apply related markdown updates in the same turn.

## 3) SVG Open Behavior Policy

When opening SVGs for review:
- Prefer Google Chrome.
- If Chrome is unavailable, use the default web browser.
- Never open editor/design applications for SVG review.
- On Windows, launch Chrome directly when available.

## 4) Regression Evidence Artifact Contract

Required per-turn artifacts:
- `saved-contract-turn*.txt`

Required diff artifacts:
- `diff-snap*.txt`

Required failure artifacts when a turn fails/interruption occurs:
- `snap-failure-*.csv`
- `diff-*-failure-vs-*.txt`

Required design-scenario artifacts (scenarios 3/4/5):
- `open-evidence.md` with:
  - opened file path,
  - observed app,
  - timestamp,
  - screenshot reference or explicit note.

## 5) Open Target Verification Rule

`open_target_verified` may be `PASS` only when `open-evidence.md` contains direct user-observed evidence.

Process snapshots (`process-before-turn*.csv`, `process-after-turn*.csv`) are supporting evidence only.

## 6) Contract Change Process

If a contract is intentionally changed:
- update this document first,
- update related runbooks,
- update `README.md` and `CLAUDE.md` summaries,
- record the change in `docs/changelog.md`.
