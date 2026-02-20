# Regression Harness

Use this harness after any change to `skills/*/SKILL.md`.

## Goal

Catch behavior regressions quickly across persistence, sourcing, design approval flow, and cross-skill integration.

## Test Setup

- Run tests in a fresh Claude session.
- Use a fresh garden workspace directory for each scenario unless the scenario explicitly requires carryover state.
- Save transcripts and note pass/fail against invariants below.
- Record pre-approval and post-approval file diffs for each design scenario.
- Confirm where SVG files open on the host machine (Chrome preferred; fallback is default web browser, never editor/design apps).
- Treat interrupted turns as potentially mutating; always inspect failure diff artifacts when present.
- Failure-path artifacts from runner use:
  - `snap-failure-<turn>.csv`
  - `diff-<turn>-failure-vs-<baseline>.txt`

## Design Evidence Artifacts

For scenarios 3/4/5, capture and retain:
- `saved-contract-turn*.txt` for every turn.
- `open-evidence.md` in each scenario folder with:
  - opened file path,
  - observed app,
  - timestamp,
  - screenshot reference or explicit note.

`open_target_verified` can be `PASS` only when `open-evidence.md` contains direct user-observed proof.

## Scenario 1: First-Time Profile Setup

Prompt:
`I just moved to Portland, OR zone 8b. Front yard is 30x15 south-facing lawn. Backyard is 40x30 with a large oak on the north half and a 10x12 patio. Help me start tracking my garden.`

Invariants:
- Asks follow-up questions before writing files when `profile.md` does not exist.
- Creates baseline profile and relevant area files after gathering context.
- Appends a log entry.
- Does not ask for data already recorded in created files later in the same scenario.

## Scenario 2: Expert Diagnosis Discipline

Prompt:
`My tomato seedlings have yellow lower leaves with dark brown concentric spots. What is this and what should I do?`

Invariants:
- Reads garden state first when files exist.
- Asks clarifying questions and waits for answers before final diagnosis.
- Uses web sources with correct hierarchy and citations from retrieved URLs.
- Persists diagnosis/actions to garden data.
- Time-based follow-up actions are written to `calendar.md`.
- Ends with `Saved:` as the final line, listing touched files.

## Scenario 3: New Layout Approval Gate

Prompt:
`Design my front yard for curb appeal with some edible plants.`

Invariants:
- Produces SVG preview layout(s) with labels, orientation, dimensions/scale reference, legend, and color conventions.
- Before approval, only preview SVG files are written under `areas/` (`areas/{area-name}-option-a.svg`, `areas/{area-name}-option-b.svg`); canonical files remain unchanged.
- Presents layout and gets feedback before saving design files.
- Leads with targeted spatial questions after showing layout.
- If future tasks are mentioned, writes concrete entries to `calendar.md`.
- After approval, writes canonical `areas/{area-name}-layout.svg` and links it from the area file design section.
- Ends with `Saved:` as the final line, listing touched files.

## Scenario 4: Design Modification Integrity

Prompt:
`Move the fire pit to the opposite side and reduce raised beds from 4 to 2.`

Invariants:
- Regenerates visual immediately to reflect changes.
- Before approval, does not modify canonical design files (`areas/{area-name}-layout.svg`, area `.md`, `calendar.md`, `log/`, `plants/`).
- Does not introduce unrequested features into committed design.
- Updates all affected area-file sections so no stale text remains.
- Appends to log (no editing/reordering existing entries).
- Uses `Optional ideas` section for non-committed suggestions.

## Scenario 5: Preference-Driven Alternatives

Prompt:
`I want a PNW native look with Japanese influence in this side yard.`

Invariants:
- Provides 2 viable layout options with tradeoffs before saving.
- Translates style terms into concrete spatial/material decisions.
- Saves only the approved option.
- Ends with `Saved:` as the final line, listing touched files.

## Pass Criteria

- All invariants in all scenarios pass.
- No guessed citations.
- No "would you like me to save?" behavior when save rules apply.

## Failure Handling

- Update the relevant `SKILL.md` with the minimum instruction change needed.
- Re-run only failed scenarios first.
- Re-run full harness before finalizing.
