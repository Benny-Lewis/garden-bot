# Changelog

This changelog records notable project-level changes.

## 2026-02-23

### Docs
- Reorganized planning and testing documentation into `docs/` with active/archive lifecycle layout.
- Added docs indexes and testing run retention references.

### Testing
- Archived superseded regression run folders under `dev/testing/runs/archive/2026-02-19/`.
- Kept `full-v1` and `targeted-v10` runs live as current evidence anchors.

### Evidence
- Finalized full-v1 open-target evidence and signoff documentation.

## 2026-02-20

### Contracts and Harness
- Consolidated enforced runtime contracts around:
  - strict final-line `Saved:` format,
  - design preview-vs-canonical save gating,
  - SVG browser-open policy,
  - explicit regression evidence requirements.

### Compliance
- Closed remaining anthropic guidance alignment gaps for examples and routing smoke coverage.

## 2026-02-19

### Regression Iteration
- Multiple targeted retest iterations executed and documented.
- Final targeted gate converged at `targeted-v10`.

### Structure
- Hardened retest-runner plugin bundle behavior for repeat run names.
