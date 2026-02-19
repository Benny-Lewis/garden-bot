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
