# landscape-design REFACTOR — Comprehensive Analysis

**Date:** 2026-02-17
**Phase:** REFACTOR Phase 4 complete
**Skill version:** 503 words (post-Phase 4 edits)
**Transcripts analyzed:** 10 total — 3 GREEN, 2 Phase 1, 2 Phase 3, 2 Phase 4 round 1, 2 Phase 4 round 2

---

## Phase 2 Edits Summary (8 findings addressed)

These were addressed in SKILL.md before Phase 3 re-testing:

| # | Finding | Fix applied |
|---|---------|-------------|
| 2 | Key decisions & rationale not saved | Added "what was chosen and why" to consolidated design view |
| 4 | Area overview not updated after design | Added "Update the area overview — don't leave stale descriptions" |
| 5 | No legend on diagrams | Added "A legend or key for symbols used" to visual checklist |
| 6 | Dimensions assumed vs asked | Added "If dimensions aren't recorded, ask — don't assume" |
| 7 | Ad-hoc symbology across sessions | Added "check existing area diagrams and reuse their conventions" |
| 8 | Parent area file pattern | Added instruction to create/update parent overview file |
| 9 | No confirmation before saving modifications | Added "present the updated visual before saving to files" for modifications |
| 10 | Log entries rewritten instead of appended | Added "(append-only — add new entries for changes, never edit previous entries)" |

**Phase 3 re-test results:** All 8 findings PASS. No regressions on the 3 GREEN behaviors (visual layouts, consolidated design, proactive persistence).

---

## Phase 4 Edits Summary

### Round 1 — HIGH findings #11-15 (446→482 words)

| # | Finding | Fix applied |
|---|---------|-------------|
| 11 | Scripts instead of inline art | Added "Produce layouts as inline art... Do not generate scripts, coordinate systems, or rendering tools." |
| 12 | Single-turn designs bypass approval | Broadened gate from modification-only to "any design to files" |
| 13 | Agent defers instead of leading | Added "lead with targeted spatial questions and analysis" |
| 14 | Save checklist inconsistent | Strengthened intro to "check every item below" |
| 15 | Stale content in non-design sections | Changed to "Update all sections of affected area files" |

**Round 1 test results (Scenarios 3+4):**
- #11 PASS — all ASCII, no scripts, 3-min response vs 20+ min script approach
- #12 PASS (Scenario 3) / **FAIL (Scenario 4)** — saved before presenting visual for modification
- #13 PASS — led with zone breakdowns and targeted spatial questions
- #14 PASS (files saved) / PARTIAL (calendar skipped despite clear build tasks)
- #15 MOSTLY PASS — comprehensive updates, but patio.md left stale in Scenario 3
- #10 **FAIL** — edited existing log entry (Scenario 4) and inserted in wrong position (Scenario 3)

### Round 2 — Fixes for 3 new issues (482→503 words)

| Issue | Fix applied |
|-------|-------------|
| Unicode misalignment in terminals | Changed to "use basic ASCII characters (`+ - | . * #`) for consistent rendering across terminals" |
| Modification gate still failed | Added "— new or modified" to the save gate instruction |
| Log append-only violated | Strengthened to "at the end of the file — add new entries, never edit or reorder previous entries" |

**Round 2 test results (simplified Scenarios 3+4):**
- #11 PASS — pure ASCII (`+`, `-`, `|`, `#`, `*`), zero Unicode, zero scripts
- #12 PASS — both new design (Session 1) and modification (Session 2) presented visual before saving
- #13 PASS — led with analysis, zone breakdowns, 3 targeted spatial questions in both sessions
- #14 PARTIAL — Session 1 skipped calendar (build tasks implied but not calendared). Session 2 skip was reasonable (swap doesn't change timeline).
- #15 PASS — Session 2 traced positional swap through 4 files, every reference caught. Excellent.
- #10 PASS — Session 2 appended new entry at end, Session 1's entry untouched

**All HIGH findings resolved except #14 calendar consistency (filed as MEDIUM #24).**

---

## Findings Summary — All Phases

Organized by impact. Evidence drawn from all 6 test transcripts.

### HIGH IMPACT — Would meaningfully change the user experience

| # | Finding | Evidence | Proposed fix |
|---|---------|----------|-------------|
| **11** | Agent builds scripts/tools instead of inline art | Scenario 3 re-test: 20+ min on Python `generate_layout.py`, 18-min bake times, token limit crashes, sticky script across sessions. User noted "a lot of inefficient back and forth on getting the layout working." | Add: "Produce visual layouts as inline art directly in your response (Unicode box-drawing characters are fine). Approximate proportions are sufficient — do not build scripts, coordinate systems, or rendering tools." |
| **12** | Single-turn designs bypass user approval | GREEN S1: massive design + 8 file saves in one shot, user never approved the layout. GREEN S2: same. Only S3 (multi-turn) iterated naturally. | Broaden "present before saving" to ALL designs, not just modifications. Current instruction only gates modifications. |
| **13** | Agent defers instead of leading with analysis | Scenario 3 re-test: agent mirrored user's questions back instead of analyzing the layout. User had to prompt "can you ask me some specific questions?" Agent acted as order-taker, not design collaborator. | Add: lead with analysis and targeted spatial questions after presenting initial layout, don't wait for open-ended user direction. |
| **14** | File save checklist inconsistently followed | GREEN S3: raspberries, tomatoes, 5-phase timeline discussed — zero plant files, zero calendar updates created. S1 saved 8 files, S2 saved 2. | Strengthen emphasis on save checklist. Current instruction lists the checklist but it's treated as optional. |
| **15** | Stale content in non-design sections | Scenario 4 re-test: `patio.md` notes still reference "extend south 8ft for the fire pit zone" after fire pit was moved away. The "update overview" instruction only covers overview/design sections, not notes/goals/constraints. | Broaden "update all sections of affected files" — not just design/overview sections. |

### MEDIUM IMPACT — Would improve quality

| # | Finding | Evidence |
|---|---------|----------|
| **16** | Aesthetic briefs not explored spatially | Scenario 3 re-test: user gave "PNW, Japanese, cottage" aesthetic brief — agent labeled beds "ORNAMENTAL BORDER" generically, never explored what that aesthetic means spatially or materially. |
| **17** | No design alternatives offered | Scenario 3 re-test: user said "extend patio into L-shape" — agent executed immediately without presenting options. Agent is an order-taker, not a collaborator. |
| **18** | Symbology still inconsistent across fresh sessions | GREEN comparison: tree = `🌳` in S1/S2, `.~~.` in S3. Same concept drawn 3 different ways. "Check existing diagrams" instruction works cross-session but not for brand-new designs (no prior diagrams to reference). |
| **19** | No separation of scales in diagrams | S3 GREEN naturally produced overview + detail diagrams (U-bed structure, planting plan). Other scenarios crammed everything into one diagram. Multi-scale approach is more readable. |
| **20** | Unsolicited additions to designs | GREEN S1 added an espaliered pear tree never discussed. Scenario 3 re-test added a lawn panel the user didn't ask for. Suggestions should be flagged separately from committed design elements. |

### LOW IMPACT / PLATFORM CONSTRAINTS

| # | Finding | Notes |
|---|---------|-------|
| **21** | Token limit crashes on large diagrams | ASCII/Unicode art is token-expensive. Agent recovered gracefully in both cases. Platform limitation, not a skill issue. |
| **22** | Cosmetic formatting drift | Agent changed `=` to `≈` and `-` to `—` in existing files without being asked. Minor trust issue. |
| **23** | No views/sight lines discussion | Standard landscape design consideration never raised in any scenario. Nice-to-have, not a regression. |
| **24** | Calendar not updated with design build tasks | Session 1 Phase 4 Round 2: log says "Next steps: Build raised beds, source fire pit, lay stepping stones" but calendar.md not updated. Save checklist says "Scheduled tasks → calendar.md" but "check every item below" isn't strong enough. Filed from #14. |

---

## What Works Well (reinforce, don't change)

- **Structured Q&A** for design feedback — S3's 4-question targeted format was the UX high point
- **Comparison tables** showing what changed between design iterations
- **"Present what I already know"** table before asking questions — grounds conversation in existing data
- **Domain knowledge** is strong and accurate (fire safety, sun orientation, PNW native plants, soil)
- **Design process discipline** — "not yet" on planting details during spatial planning phase
- **Proactive persistence** after confirmation — consistent across all scenarios
- **Cross-session design continuity** — reads existing designs, modifies coherently
- **Log entries as append-only** historical record (after Phase 2 fix)
- **Basic ASCII** (`+ - | . * #`) renders consistently across terminals — Unicode box-drawing looks cleaner but misaligns in Git Bash and Windows Terminal

---

## Phase 4 Status — REFACTOR Complete

**Skill at 503 words.** All HIGH findings (#11-15) resolved. Two REFACTOR test rounds completed.

### Remaining MEDIUM findings (for future consideration)
| # | Finding | Priority for next cycle |
|---|---------|----------------------|
| 16 | Aesthetic briefs not explored spatially | Low — domain knowledge issue, hard to fix with skill instructions |
| 17 | No design alternatives offered | Low — agent acts as order-taker, would need significant instruction |
| 18 | Symbology inconsistent across fresh sessions | Resolved by ASCII constraint — limited character set creates natural consistency |
| 19 | No separation of scales in diagrams | Low — cosmetic improvement |
| 20 | Unsolicited additions to designs | Medium — could add "flag suggestions separately from committed elements" |
| 24 | Calendar not updated with build tasks | Medium — save checklist wording could be strengthened |

### Next steps
- Task 11: Integration testing (all 3 skills together)
- Task 12: Finalize plugin (merge to main, documentation)

---

## Test Transcript Inventory

### GREEN Phase (archived)
- `docs/testing/transcripts/green-phase/2026-02-17-001129-*` — Scenario 1
- `docs/testing/transcripts/green-phase/2026-02-17-001721-*` — Scenario 2
- `docs/testing/transcripts/green-phase/2026-02-17-094417-*` — Scenario 3

### Phase 1 (archived)
- `docs/testing/transcripts/green-phase/2026-02-17-*` — Scenarios 4 & 5 (in green-phase dir)

### Phase 3 Re-tests (in ~/dev/landscaping-gardening/)
- `2026-02-17-144523-*`, `2026-02-17-144747-*`, `2026-02-17-145115-*` — Scenario 3 re-test (3 exports due to compactions)
- `2026-02-17-151529-*` — Scenario 4 re-test

### Phase 4 Round 1 (in ~/dev/landscaping-gardening/)
- `2026-02-17-164127-*` — Scenario 3 (from-scratch, full multi-turn)
- `2026-02-17-164927-*` — Scenario 4 (modification, swap fire pit and bench)

### Phase 4 Round 2 (in ~/dev/landscaping-gardening/)
- `2026-02-17-170734-*` — Simplified Scenario 3 (from-scratch, direct prompt)
- `2026-02-17-171309-*` — Simplified Scenario 4 (modification, move fire pit)

### Data Snapshot
- `docs/testing/snapshots/post-phase1-garden-bot/` — ~/garden-bot/ state after Phase 1 Scenarios 4-5
