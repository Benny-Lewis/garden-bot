# Checkpoint 5 Retest Matrix and Execution Checklist

Date: 2026-02-19  
Purpose: Authoritative rerun plan after usage reset, using isolation-safe harness.

## Preconditions

1. Run from repo root:
- `C:\Users\Ben\dev\garden-bot`

2. Use current harness:
- `dev/testing/scripts/retest-runner.ps1`
- Must include:
  - run-local `plugin-under-test`,
  - `--add-dir <scenarioDir>`.

3. Capture user-observed open evidence for design scenarios:
- quick screenshot or short note per scenario confirming which app opened SVG.

## Status Classes

- `PASS`: invariant satisfied with direct evidence.
- `FAIL`: invariant violated with direct evidence.
- `INCONCLUSIVE`: evidence insufficient (no direct proof either way).
- `INCOMPLETE`: run interrupted by usage/runtime issue.

`INCOMPLETE` does not count as `FAIL` but blocks final signoff.

## Phase A: Targeted Rerun (blocking gate)

Run:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode targeted `
  -RunName garden-bot-retest-20260219-targeted-v4
```

Evidence root:
- `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v4`

### Scenario 3 (approval gate + previews)

Required checks:
- SVG previews are created pre-approval.
- Canonical files unchanged pre-approval.
- Canonical files updated post-approval.
- Final line is strict single-line `Saved: ...`.
- `open_target_verified` captured (Chrome/browser vs Illustrator/editor).

Core evidence:
- `scenario3/diff-snap0-snap1.txt`
- `scenario3/diff-snap1-snap2.txt`
- `scenario3/diff-snap2-snap3.txt`
- `scenario3/turn2.txt`
- `scenario3/turn3.txt`
- `scenario3/process-*.csv`
- user screenshot/note

### Scenario 4 (modification integrity)

Required checks:
- Preview regenerated immediately.
- Pre-approval preview-only writes.
- Post-approval canonical writes.
- No unrequested committed features.
- Final line strict `Saved: ...`.
- `open_target_verified` captured.

Core evidence:
- `scenario4/diff-snap0-snap1.txt`
- `scenario4/diff-snap1-snap2.txt`
- `scenario4/turn1.txt`
- `scenario4/turn2.txt`
- `scenario4/process-*.csv`
- user screenshot/note

### Scenario 2 (diagnosis persistence + strict output contract)

Required checks:
- Reads existing state first.
- Asks clarifying questions before diagnosis.
- Uses sources/citations.
- Persists diagnosis/actions.
- Writes time-based follow-ups to `calendar.md`.
- Final line strict `Saved: ...`.

Core evidence:
- `scenario2/turn1.txt`
- `scenario2/turn2.txt`
- `scenario2/diff-snap0-snap1.txt`
- `scenario2/diff-snap1-snap2.txt`
- `scenario2/calendar.md`
- `scenario2/log/*`
- `scenario2/plants/*`

### Scenario 5 (2-option flow + approved-option save)

Required checks:
- Provides 2 options with tradeoffs before save.
- Translates style terms concretely.
- Saves only approved option.
- Final line strict `Saved: ...`.
- `open_target_verified` captured.

Core evidence:
- `scenario5/turn1.txt`
- `scenario5/turn2.txt`
- `scenario5/turn3.txt`
- `scenario5/diff-snap0-snap1.txt`
- `scenario5/diff-snap1-snap2.txt`
- `scenario5/diff-snap2-snap3.txt`
- `scenario5/process-*.csv`
- user screenshot/note

### Phase A Gate

Proceed to full harness only if:
- no `FAIL` in targeted scenarios,
- no `INCOMPLETE`,
- no `INCONCLUSIVE` on high-severity invariants (pre/post approval writes, strict final `Saved:`, open-target verification).

## Phase B: Full Harness Rerun

Run:

```powershell
powershell -ExecutionPolicy Bypass -File dev/testing/scripts/retest-runner.ps1 `
  -Mode full `
  -RunName garden-bot-retest-20260219-full-v1
```

Evidence root:
- `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-full-v1`

Evaluate all invariants in:
- `dev/testing/regression-harness.md`

## Matrix Output Requirements

For each invariant row, include:
- Scenario
- Invariant text
- Status (`PASS/FAIL/INCONCLUSIVE/INCOMPLETE`)
- Evidence path(s)
- One-line rationale
- Confidence (`High/Medium/Low`)
- `open_target_verified` where relevant

Output files:
- `dev/testing/results/retest-matrix-2026-02-19-targeted-v4.md`
- `dev/testing/results/retest-matrix-2026-02-19-full-v1.md`

## Stop Conditions

Stop and revise before proceeding if any of the following occur:
- Usage/runtime interruption (`INCOMPLETE`).
- Any high-severity `FAIL`.
- Any mismatch between `Saved:` claim and file diffs.
- Open target appears to be Illustrator/editor instead of browser for design scenarios.

## Post-Run Decision

1. If all pass:
- finalize summary,
- stage logical commits,
- prepare release-ready handoff.

2. If failures remain:
- apply minimum instruction/harness changes only,
- rerun failed scenarios first,
- then rerun full harness.
