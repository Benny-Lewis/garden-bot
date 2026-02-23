# Commit Plan (2026-02-20)

Purpose: stage the current work into logical, reviewable commits without mixing unrelated changes.

## Commit 1: Harness + Contract Hardening

Suggested message:
- `Harden retest harness evidence contracts and failure-path capture`

Scope:
- `dev/testing/scripts/retest-runner.ps1`
- `dev/testing/regression-harness.md`
- `skills/landscape-design/SKILL.md`
- `docs/testing/results/active/retest-matrix-template.md`

Why:
- Contains executable behavior and test-contract enforcement changes.
- Isolated from narrative/planning documents.

## Commit 2: Analysis Outputs + Checkpoint Docs

Suggested message:
- `Add checkpoint analysis package and updated rerun go-packet`

Scope:
- `docs/testing/results/archive/retest-evidence-lock-2026-02-20.md`
- `docs/testing/results/archive/retest-issue-matrix-2026-02-20-checkpoint2.md`
- `docs/testing/results/archive/retest-root-cause-map-2026-02-20-checkpoint3.md`
- `docs/testing/results/archive/open-target-evidence-2026-02-20.md`
- `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v4.md`
- `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v5-partial.md`
- `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v6-partial.md`
- `docs/plans/archive/2026-02-20-checkpoint4-improvement-plan.md`
- `docs/plans/archive/2026-02-20-checkpoint5-retest-plan.md`
- `docs/plans/archive/2026-02-20-checkpoint6-go-packet.md`
- `docs/plans/archive/2026-02-20-usage-block-handoff.md`
- `docs/plans/archive/2026-02-20-commit-plan.md`

Why:
- Captures the complete analysis and execution guidance package.

## Commit 3: Legacy Doc Status Normalization

Suggested message:
- `Mark legacy 2026-02-19 handoff docs as historical`

Scope:
- `docs/plans/archive/2026-02-19-checkpoint5-retest-matrix.md`
- `docs/plans/archive/2026-02-19-checkpoint6-go-packet.md`
- `docs/plans/archive/2026-02-19-session-handoff.md`
- `docs/plans/archive/2026-02-19-usage-reset-handoff.md`

Why:
- Keeps historical docs but removes ambiguity about current canonical plan.

## Pre-Commit Verification Checklist

1. `dev/testing/scripts/retest-runner.ps1` parses cleanly in PowerShell.
2. `skills/landscape-design/SKILL.md` stays under 500 words.
3. No unrelated user files are staged.
4. Commit scopes follow the grouping above.

