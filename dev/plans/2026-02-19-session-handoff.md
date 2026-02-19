# Session Handoff (2026-02-19)

## Goal

Continue plugin hardening and finish SVG-era regression testing in a new session.

## Completed Work

1. Synced branch before edits:
- `git pull` returned `Already up to date`.

2. Landscape skill reconciled to SVG workflow and kept under word budget:
- `skills/landscape-design/SKILL.md` now uses SVG output (`{area-name}-layout.svg`) and links from area files.
- Word count checked at 498.

3. Re-applied behavior safeguards into `landscape-design` after concurrent edit conflict:
- No unrequested committed features (`Optional ideas`).
- Show 2 options with tradeoffs when multiple layouts are plausible.
- Translate style words into concrete spatial decisions.
- If future actions are mentioned, write concrete month/date entries in `calendar.md`.
- End responses with strict `Saved:` summary.

4. Cross-file updates:
- `README.md` updated from ASCII description to SVG description for `landscape-design`.
- `dev/testing/regression-harness.md` updated so Scenario 3 expects SVG outputs.
- `skills/garden-expert/SKILL.md` includes `Saved:` footer contract.
- `CLAUDE.md` includes search/reference policy and regression harness pointer.

## Test Method Used

Multi-turn testing was run with:
- First turn: `claude -p ... -- "<prompt>"`
- Follow-ups: `claude -p -c ... -- "<follow-up>"`
- One isolated temp folder per scenario.
- Per-turn snapshots written to CSV and compared to detect exactly when files changed.

## Test Results So Far

### Scenario 1 (profile setup)
- Pass: asked follow-up questions first, then created profile/areas/log after user answers.

### Scenario 2 (diagnosis discipline)
- Mostly pass: good diagnostic gating, citations, persistence to plants/log.
- Note: `calendar.md` was not updated in this run.

### Scenario 3 (new layout approval gate)
- Inconclusive in this run (turn outputs were empty due session/tool instability).

### Scenario 4 (modification integrity)
- Mixed: saved after explicit approval, but observed visual file change before approval in one run.
- Needs confirm/fix for strict no-write-before-approval behavior.

### Scenario 5 (preference-driven alternatives)
- Incomplete due usage cap.

### Manual SVG checks
- SVG files were generated and updated in iterative flow.
- Option SVG drafts were created before explicit save approval in at least one run.

## Current Risk / Open Issue

Primary remaining risk in `landscape-design`:
- The skill may still write design artifacts before explicit approval.
- Add or strengthen explicit instruction: do not write any design files (including draft option SVGs) until the user approves a specific design to save.

## Remaining Plan (Next Session)

1. Re-run incomplete/inconclusive tests:
- Scenario 3 (full)
- Scenario 5 (full)

2. Re-run confirmation tests for write-gating:
- Scenario 4
- Manual SVG mockup + iteration

3. If pre-approval writes still happen:
- Tighten `skills/landscape-design/SKILL.md` with explicit no-write-before-approval language.
- Re-run only failed scenarios first, then full harness.

4. Finalize once all invariants pass:
- Stage intended files.
- Commit with agreed message.

## Working Tree Snapshot At Handoff

`git status --short` at handoff:

```
 M CLAUDE.md
 M README.md
 M skills/garden-expert/SKILL.md
 M skills/landscape-design/SKILL.md
?? dev/plans/2026-02-18-svg-layout-implementation.md
?? dev/plans/2026-02-18-svg-layout-visualization-design.md
?? dev/samples/
?? dev/testing/regression-harness.md
```

---

## Update: Analysis + Plan Revision (2026-02-19, later session)

### Additional Work Completed

1. Archived test artifacts into the repo for traceability:
- `dev/testing/runs/2026-02-19/garden-bot-harness-svg-20260219`
- `dev/testing/runs/2026-02-19/garden-bot-svg-manual-20260219`
- `dev/testing/runs/2026-02-19/garden-bot-harness-20260219`

2. Confirmed host observation for file opening behavior:
- SVG files opened in Adobe Illustrator (default app association), not browser.
- This is now treated as a confirmed UX issue.

3. Completed deeper findings analysis (severity-ranked), then applied prompt-level fixes.

### Findings Summary (from archived evidence)

#### High
- Pre-approval canonical writes occurred in landscape flow:
  - canonical layout file changed before explicit approval in one scenario.
  - preview option SVGs written before approval in another scenario.
- Browser opening behavior was not respected in practice (opened Illustrator).

#### Medium
- `Saved:` contract formatting was inconsistent (not always strict final-line form).
- Time-based follow-up actions were not always written to `calendar.md` in diagnosis flow.

#### Low
- Preview/canonical naming behavior was ambiguous.
- Some terminal-exported content showed encoding artifacts.

#### Coverage Gaps
- One SVG harness scenario produced empty turns (inconclusive).
- One SVG harness scenario was interrupted by usage cap.

### Fixes Applied After Analysis

1. `skills/landscape-design/SKILL.md`
- Added explicit preview-vs-canonical write gating:
  - before approval: preview SVGs only.
  - before approval: do not update canonical files (`{area}-layout.svg`, area `.md`, `calendar.md`, `log/`, `plants/`).
  - after approval: save canonical layout and related files.
- Added explicit open behavior:
  - use Google Chrome when available; otherwise default web browser.
  - never open editor/design apps.
- Clarified save section timing:
  - save checklist applies after user approval.
- Tightened `Saved:` contract:
  - must be the final line.
- Word count rechecked and kept under threshold:
  - 483 words.

2. `skills/garden-expert/SKILL.md`
- Added explicit rule for time-based follow-ups:
  - if advice includes time markers (today/in X days/month/date/after frost), write actions to `calendar.md`.
- Tightened `Saved:` contract:
  - must be final line.

3. `dev/testing/regression-harness.md`
- Added explicit pre/post approval file-diff requirement.
- Added host check for SVG open target (Chrome preferred; fallback browser).
- Added invariants for:
  - preview-only pre-approval writes.
  - canonical-only post-approval writes.
  - strict final-line `Saved:`.
  - diagnosis follow-up actions persisted to `calendar.md`.

### Updated Retest Plan (approved)

Run this order after usage resets:

1. Targeted retest A (write gating):
- Scenario 3 and Scenario 4
- Validate preview-only pre-approval writes and canonical post-approval writes.

2. Targeted retest B (diagnosis persistence):
- Scenario 2
- Validate time-based follow-ups are written to `calendar.md`.
- Validate strict final-line `Saved:`.

3. Targeted retest C (preference flow completion):
- Scenario 5 full sequence
- Validate 2 options + tradeoffs and approved-option-only commit behavior.

4. Environment behavior check:
- Confirm SVG opens in Chrome (or fallback web browser), not Illustrator.

5. Full harness rerun:
- Scenarios 1–5 end-to-end after targeted passes.

### Decision Principle Used

Bitter Lesson alignment was preserved:
- favor lightweight behavioral gating and save discipline over adding domain knowledge.
- no new gardening knowledge/reference payload was added to skills.

---

## Update: Targeted Retest Cycle (2026-02-19, later session)

### New Automation Added

- Added `dev/testing/scripts/retest-runner.ps1` to:
  - seed isolated scenario folders,
  - run multi-turn `claude -p/-c` flows,
  - capture per-turn snapshots/diffs,
  - capture browser/editor process snapshots,
  - record environment facts (including `.svg` association and Chrome availability).

### Targeted Run v2 (`garden-bot-retest-20260219-targeted-v2`)

- Evidence root:
  - `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v2`

- Key outcomes:
  - Scenario 4 showed correct pre-approval gating in this run:
    - pre-approval diff added preview only (`areas/backyard-south-option-a.svg`),
    - post-approval diff updated canonical files and removed preview.
  - Scenario 2 and Scenario 5 had major behavioral failures:
    - missing/incorrect persistence despite claiming saves,
    - missing strict single-line `Saved:` footer behavior.
  - Scenario 3 stalled on repeated "need dimensions" behavior and did not progress to canonical save.

- Environment evidence:
  - `environment-check.txt` showed `.svg` file association set to Illustrator (`Applications\\Illustrator.exe`).
  - Chrome exists at `C:\Program Files\Google\Chrome\Application\chrome.exe`.
  - Process snapshots showed Chrome processes but no proof of a clean deterministic open action per turn.

### Prompt/Skill Hardening Applied After v2

- `skills/landscape-design/SKILL.md`
  - strengthened read-first behavior (cite known dimensions/zone before asking),
  - added "never claim save without completed writes",
  - enforced strict single-line final `Saved:` format,
  - added Windows-specific Chrome-direct launch guidance (avoid `.svg` app association fallback).
  - word count rechecked: 492.

- `skills/garden-expert/SKILL.md`
  - strengthened read-first behavior and no-false-missing-data rule,
  - added "never claim save without completed writes",
  - enforced strict single-line final `Saved:` format.

- `dev/testing/scripts/retest-runner.ps1`
  - improved scenario prompts (explicit dimensions/context in follow-ups),
  - added isolation fix: builds run-local `plugin-under-test` (only `CLAUDE.md` + `skills/`) to prevent contamination from archived repo data,
  - passes `--add-dir <scenarioDir>` explicitly for scenario workspace access.

### Targeted Run v3 Status (`garden-bot-retest-20260219-targeted-v3`)

- Run aborted at Scenario 3 turn 3 due Claude usage limit reset window.
- Evidence root:
  - `dev/testing/runs/2026-02-19/garden-bot-retest-20260219-targeted-v3`
- `scenario3/turn3.txt` captured:
  - `You're out of extra usage · resets 4pm (America/Los_Angeles)`

### Remaining Work (next continuation)

1. Re-run targeted scenarios with the isolation-fixed runner after usage reset:
- Scenario 3
- Scenario 4
- Scenario 2
- Scenario 5

2. Build strict pass/fail matrix with evidence paths against every invariant in:
- `dev/testing/regression-harness.md`

3. If targeted passes, run full harness (Scenarios 1-5) using the same runner setup.

4. If failures remain, apply minimum structural skill edits only (Bitter Lesson style), then re-run failed scenarios before final full harness.

---

## Update: Checkpoint Planning Pack Complete (2026-02-19, latest)

The staged analysis-and-plan workflow is complete through Checkpoint 6.

### New planning/results documents

- `dev/testing/results/retest-evidence-inventory-2026-02-19.md` (Checkpoint 1)
- `dev/testing/results/retest-severity-matrix-2026-02-19-checkpoint2.md` (Checkpoint 2)
- `dev/testing/results/retest-root-cause-map-2026-02-19-checkpoint3.md` (Checkpoint 3)
- `dev/plans/2026-02-19-checkpoint4-improvement-plan.md` (Checkpoint 4)
- `dev/plans/2026-02-19-checkpoint5-retest-matrix.md` (Checkpoint 5)
- `dev/plans/2026-02-19-checkpoint6-go-packet.md` (Checkpoint 6)

### Current guidance

- Treat pre-fix targeted-v2/v3 behavior findings as provisional where isolation could affect outcomes.
- Use the isolation-safe runner configuration for all authoritative reruns.
- Use the Checkpoint 6 go packet as the canonical execution source after usage reset.
