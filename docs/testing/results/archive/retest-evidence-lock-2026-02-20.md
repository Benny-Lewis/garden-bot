# Retest Evidence Lock (Checkpoint 1B)

Date: 2026-02-20  
Purpose: Freeze the evidence set and classify each source by validity before full severity analysis.

## Scope Locked

- Targeted rerun artifacts:
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v2`
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v3`
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4`
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v5`
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v6`
- Result matrices and evidence docs:
  - `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v4.md`
  - `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v5-partial.md`
  - `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v6-partial.md`
  - `docs/testing/results/archive/open-target-evidence-2026-02-20.md`
  - `docs/testing/results/archive/retest-evidence-inventory-2026-02-19.md`
- Harness source of truth:
  - `dev/testing/scripts/retest-runner.ps1`
- Planning/handoff context:
  - `docs/plans/archive/2026-02-19-checkpoint6-go-packet.md`
  - `docs/plans/archive/2026-02-19-usage-reset-handoff.md`
  - `docs/plans/archive/2026-02-20-usage-block-handoff.md`

## Validity Classification

### A. Authoritative (high confidence for current analysis)

1. `targeted-v5` scenario3 pre-approval behavior:
- `scenario3/diff-snap0-snap1.txt`
- `scenario3/diff-snap1-snap2.txt`
- `scenario3/front-yard-option-a.svg`
- `scenario3/front-yard-option-b.svg`
- Reason: post-isolation-fix run; direct file-level evidence in scenario directory.

2. `targeted-v6` interruption + partial-write behavior:
- `scenario3/turn3.txt` (usage interruption)
- `scenario3/diff-snap2-current-after-failed-turn3.txt` (partial canonical writes despite failure)
- Reason: direct contradictory failure-path behavior captured after hardened run.

3. Browser-open user evidence:
- `docs/testing/results/archive/open-target-evidence-2026-02-20.md`
- Reason: direct user-observed screenshots showing Chrome open target for scenario-anchored files in v5.

4. Current harness behavior:
- `dev/testing/scripts/retest-runner.ps1`
- Reason: source code confirms active instrumentation and failure-snapshot logic.

### B. Bounded-authoritative (usable with explicit caveat)

1. `targeted-v4` matrix and run artifacts:
- `docs/testing/results/archive/retest-matrix-2026-02-19-targeted-v4.md`
- `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/*`
- Caveat: working-directory leakage existed; write-path conclusions are provisional.
- Supporting leakage evidence:
  - `dev/testing/runs/archive/2026-02-19/garden-bot-retest-20260219-targeted-v4/leakage-artifacts/`

2. Environment association checks (v4/v5/v6):
- `environment-check.txt` files
- Caveat: host registry/app association is authoritative; per-turn open target still needs user proof when available.

### C. Provisional (historical context only)

1. `targeted-v2`, `targeted-v3` behavior assertions:
- Reason: earlier run conditions were weaker (before final isolation hardening), so these runs are directional, not final-certification evidence.

## Evidence Rules for Next Analysis Phase

1. Prioritize A evidence for root conclusions.
2. Use B evidence only when caveat is explicitly restated.
3. Use C evidence only to generate hypotheses, never to close a finding.
4. Treat all usage-interrupted turns as:
- `INCOMPLETE` for contract completion checks,
- but still inspect post-failure diffs for unintended writes.

## Key Gaps Still Open

1. No completed post-fix targeted run through scenarios 4, 2, 5 (blocked by usage cap).
2. Open-target verification is high-confidence for scenario3 (v5), but not yet scenario4/5.
3. No post-fix full-harness (`full-v1`) evidence yet.

## Checkpoint Outcome

- Evidence is now locked and classified for comprehensive severity analysis.
- Next step: build full issue/failure matrix (P0-P3, with confidence and caveat tags) using this lock.

