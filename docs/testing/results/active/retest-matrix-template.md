# Retest Matrix Template

Date: YYYY-MM-DD  
Run: `dev/testing/runs/<date>/<run-name>`  
Mode: targeted|full

## Gate Block

- Decision: **GO** | **NO-GO**
- Blockers:
  - <blocker 1>
  - <blocker 2>
- Status counts:
  - PASS: <n>
  - FAIL: <n>
  - INCONCLUSIVE: <n>
  - INCOMPLETE: <n>

## Matrix

| Scenario | Invariant | Status | Confidence | open_target_verified | Evidence | Rationale |
|---|---|---|---|---|---|---|
| <scenario> | <invariant> | PASS/FAIL/INCONCLUSIVE/INCOMPLETE | High/Medium/Low | PASS/FAIL/INCONCLUSIVE/n/a | `<path>` | <one-line rationale> |

## Notes

- Include `saved-contract-turn*.txt` evidence for every turn.
- For scenarios 3/4/5, include `open-evidence.md` and screenshot/note reference.
- For interrupted runs, include `snap-failure-*` and `diff-*-failure-vs-*.txt` if present.
