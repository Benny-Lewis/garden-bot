# Retest Root-Cause Map (Checkpoint 3)

Date: 2026-02-20  
Inputs:
- `docs/testing/results/archive/retest-evidence-lock-2026-02-20.md`
- `docs/testing/results/archive/retest-issue-matrix-2026-02-20-checkpoint2.md`
- `skills/landscape-design/SKILL.md`
- `skills/garden-expert/SKILL.md`
- `dev/testing/scripts/retest-runner.ps1`

## Root-Cause Layers

1. Runtime/resource layer (usage quota and interrupted execution)
2. Harness/instrumentation layer (what is executed, tracked, and proven)
3. Skill contract layer (instruction strength/precedence under pressure)
4. Host integration layer (browser/app open behavior on Windows)

## Issue-to-Cause Mapping

| Issue IDs | Primary Root Cause | Layer | Confidence | Actionability Now |
|---|---|---|---|---|
| I-01 | External usage quota interrupts targeted run before scenario completion. | Runtime/resource | High | Medium |
| I-02 | Non-atomic turn behavior: writes can occur before command exits non-zero; failure path originally under-instrumented. | Runtime/resource + Harness | High | High |
| I-03 | v4 runner executed turns without enforced scenario working directory, allowing path leakage. | Harness | High | High (already fixed) |
| I-04, I-12 | Open-target proof relied on process deltas; deterministic per-file app validation requires user-observed artifact. | Harness + Host integration | High | High |
| I-05, I-06, I-07 | Save-claim mismatch signals likely stem from mixed factors: v4 path leakage (known) plus possible contract non-compliance under multi-turn pressure (unconfirmed post-fix). | Harness + Skill contract | Medium | Medium |
| I-08 | Citation/source requirement may be under-enforced in diagnosis final-answer formatting. | Skill contract | Medium | Medium |
| I-09 | Modification flow may lose area targeting continuity under conversation state transitions. | Skill contract | Medium | Medium |
| I-10 | Preview file placement not fully normalized in instructions/tests (`{area}-option-*.svg` path ambiguity). | Skill contract + Harness | Medium | High |
| I-11 | Windows `.svg` association remains Illustrator; browser-open outcome depends on explicit launch path and runtime behavior. | Host integration | High | Medium |
| I-13 | Text encoding handling in result docs is inconsistent (`Ã‚Â·` artifacts). | Harness/reporting | High | High |
| I-14 | Partial matrices lack explicit gate-decision synthesis (`GO/NO-GO`), increasing manual interpretation. | Harness/reporting | High | High |

## Cross-Cutting Root Causes

1. **Execution is not atomic at turn boundary**
- A turn can partially write state before failure is surfaced.
- Consequence: "failed turn" is not equivalent to "no writes happened."

2. **Evidence quality lagged behavior complexity**
- Process snapshots alone were insufficient for app-open proof.
- Early runs did not robustly capture leakage/failure-path diffs.

3. **Contracts are strong in wording, weaker in enforceability**
- `Saved:` and save-gating rules exist, but hard proof depends on instrumentation and rerun completion.

4. **Environment truth vs instruction intent**
- Host default app association can contradict desired UX unless explicit browser launch is consistently executed and evidenced.

## Immediate vs Deferred Causes

### Immediate (can act now, no new model run needed)

- Harness hardening for failure-path snapshots/diffs (already implemented).
- Explicitly treat interrupted turns as mutating risk.
- Standardize matrix/report templates (`GO/NO-GO`, confidence/evidence class).
- Preserve mandatory user-observed open evidence for design scenarios.
- Normalize preview-file path expectations in test assertions/templates.
- Fix encoding normalization in generated result docs.

### Deferred (need authoritative rerun evidence)

- Whether save-claim/file-diff mismatch persists post-fix in scenarios 2/3/5.
- Whether citation compliance fails post-fix in scenario2.
- Whether scenario4 modification-targeting failure persists post-fix.

## Bitter Lesson Alignment

- Prefer structural controls over expanded domain prompting:
  - stronger harness observability,
  - stricter contract verification paths,
  - deterministic evidence capture,
  - minimal policy wording changes only where ambiguity is proven.

## Checkpoint 3 Outcome

- Root causes are now isolated by layer with clear immediate/deferred action boundaries.
- Next step: produce a minimal structural improvement plan tied directly to these causes.

