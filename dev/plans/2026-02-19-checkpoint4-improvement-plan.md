# Checkpoint 4 Improvement Plan (Minimal Structural Changes)

Date: 2026-02-19  
Principle: Bitter Lesson alignment (improve gating/structure/measurement, avoid adding domain payload).

## Objective

Use current high-confidence findings to harden behavior contracts and evidence quality now, then defer behavior-sensitive conclusions to an isolation-safe rerun.

## Proposed Changes (Actionable Now)

### 1. Harden `Saved:` contract validation in test workflow

- File(s):
  - `dev/testing/scripts/retest-runner.ps1`
  - `dev/testing/results/retest-matrix-2026-02-19-partial.md` (or successor matrix template)

- Change:
  - Add a post-turn validator that checks final line exactly matches:
    - `Saved: <paths>`
    - or `Saved: none - <reason>`
  - Mark turn as `contract_fail` artifact when invalid (do not infer pass from narrative text).

- Why:
  - High-confidence contract drift exists in evidence.
  - Deterministic check prevents subjective interpretation.

- Risk:
  - Low; only affects test classification, not runtime behavior.

### 2. Make open-behavior evidence deterministic

- File(s):
  - `dev/testing/regression-harness.md`
  - `dev/testing/scripts/retest-runner.ps1`

- Change:
  - Keep process snapshots, but add required human-verifiable evidence step for open behavior:
    - per design scenario, capture user confirmation artifact (screenshot/note) indicating actual opened app/window target.
  - Add explicit matrix field: `open_target_verified` = `yes/no/inconclusive`.

- Why:
  - Process deltas alone cannot prove target-file-to-app mapping.
  - User explicitly reported Illustrator opens; this must be measured directly.

- Risk:
  - Low; increases evidence burden but improves confidence materially.

### 3. Add explicit incomplete-run classification

- File(s):
  - `dev/testing/results/retest-matrix-2026-02-19-partial.md` (or new full matrix output)
  - `dev/testing/scripts/retest-runner.ps1` (optional metadata flag)

- Change:
  - Add status class: `INCOMPLETE` for usage/runtime interruption.
  - Exclude `INCOMPLETE` from fail-rate decisions.
  - Store interruption reason (e.g., usage cap) as structured note.

- Why:
  - Prevents false negatives from capped/interrupted sessions.

- Risk:
  - Low.

### 4. Keep current skill wording; avoid extra content edits before clean rerun

- File(s):
  - `skills/landscape-design/SKILL.md`
  - `skills/garden-expert/SKILL.md`

- Change:
  - No additional semantic edits now beyond those already made.
  - Reassess only after isolation-safe rerun results.

- Why:
  - Current unresolved items are mostly evidence-quality and run-validity related.
  - Avoid churn/overfitting to contaminated runs.

- Risk:
  - Low.

## Deferred Until Isolation-Safe Rerun

Do not finalize fixes for these until post-reset rerun:

- read-before-ask behavior gaps,
- save-claim vs write-location mismatch,
- scenario 3 preview generation reliability,
- scenario 5 option-flow stability.

## Retest Protocol After Changes

1. Run targeted sequence with isolation-fixed runner:
- Scenario 3, 4, 2, 5

2. Generate authoritative matrix:
- include `Pass/Fail/Inconclusive/Incomplete`
- include `open_target_verified`
- include strict `Saved:` validator outcome per turn.

3. If targeted all pass (excluding `INCOMPLETE`), run full harness 1-5.

4. Only then decide whether any new skill edits are needed.

## Expected Outcome

- Higher confidence in conclusions with less noise.
- Reduced risk of fixing artifacts instead of real behavior.
- Clear go/no-go gate for full rerun and final commit sequence.
