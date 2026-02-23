# Evidence Capture Runbook

Use this runbook to capture consistent evidence for regression gates.

## Scope

Focus area is design scenarios 3/4/5 and open-target verification.

## Required `open-evidence.md` Fields

Each design scenario folder must include `open-evidence.md` with:
- `Opened file path`
- `Observed app`
- `Timestamp (local)`
- `Screenshot reference or note`
- `Status` (`PASS` or `PENDING`/`FAIL`)

## Capture Procedure

1. Open expected SVG outputs for the scenario.
2. Confirm browser target (Chrome preferred; fallback browser accepted).
3. Capture screenshot evidence (or explicit note where screenshot is unavailable).
4. Record evidence in `open-evidence.md`.
5. Keep process snapshots as supporting artifacts only.

## Scenario-Specific Expectations

Scenario 3 (front yard):
- option-a SVG
- option-b SVG
- canonical layout SVG (if approval turn executed)

Scenario 4 (backyard modification):
- relevant backyard-south canonical/preview SVG opened in browser

Scenario 5 (side yard alternatives):
- option-a SVG
- option-b SVG
- canonical layout SVG (if approval turn executed)

## `open_target_verified` PASS Rule

`open_target_verified` can be `PASS` only when direct user-observed proof is present in `open-evidence.md`.

Acceptable direct proof:
- user-provided screenshot references,
- explicit user observation note with timestamp context.

## Common Failure Modes

1. Wrong file names recorded (for example option file vs layout file mismatch).
2. Evidence from one scenario copied to another.
3. Process snapshot interpreted as primary proof.
4. Timestamp omitted with no note.

## Quick Checklist

- [ ] Correct scenario path
- [ ] Correct SVG filenames
- [ ] Browser app recorded
- [ ] Timestamp or explicit note recorded
- [ ] Screenshot reference or explicit note recorded
- [ ] Status set consistently with evidence

## Related Docs

- Contracts: `docs/contracts.md`
- Regression procedure: `docs/runbooks/regression.md`
- Harness invariants: `dev/testing/regression-harness.md`
