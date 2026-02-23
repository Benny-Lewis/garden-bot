# Anthropic Guidance Compliance Review (2026-02-20)

## Inputs

- Source guide:
  - `C:\Users\Ben\Downloads\The-Complete-Guide-to-Building-Skill-for-Claude.regenerated.md`
  - `C:\Users\Ben\Downloads\The-Complete-Guide-to-Building-Skill-for-Claude_md_package.zip`
  - `C:\Users\Ben\Downloads\The-Complete-Guide-to-Building-Skill-for-Claude.pdf`
- Audited implementation:
  - `skills/garden-profile/SKILL.md`
  - `skills/garden-expert/SKILL.md`
  - `skills/landscape-design/SKILL.md`
  - `.claude-plugin/plugin.json`
  - `dev/testing/regression-harness.md`

## Status Legend

- `PASS`: Meets standard with direct evidence.
- `PARTIAL`: Mostly aligned but missing a required/expected reinforcement.
- `FAIL`: Clear gap versus guidance requirement/checklist.

## Compliance Matrix

| ID | Standard | Status | Evidence | Gap |
|---|---|---|---|---|
| A-01 | Skill packaging and naming (`SKILL.md`, kebab-case names). | PASS | Guide: line 128, line 379, line 380, line 384. Repo: `skills/garden-profile/SKILL.md`, `skills/garden-expert/SKILL.md`, `skills/landscape-design/SKILL.md`. | None. |
| A-02 | Required frontmatter fields and safe frontmatter content. | PASS | Guide: line 377, line 387, line 391, line 399, line 403, line 459. Repo: `skills/garden-profile/SKILL.md:2`, `skills/garden-profile/SKILL.md:3`, `skills/garden-expert/SKILL.md:2`, `skills/garden-expert/SKILL.md:3`, `skills/landscape-design/SKILL.md:2`, `skills/landscape-design/SKILL.md:3`. | None. |
| A-03 | Description quality (what + when + specific trigger phrases; avoid overtriggering). | PASS | Guide: line 391, line 405. Repo: `skills/garden-profile/SKILL.md:3`, `skills/garden-expert/SKILL.md:3`, `skills/landscape-design/SKILL.md:3`. | None after this session’s description tightening. |
| A-04 | Progressive disclosure and size discipline. | PASS | Guide: line 145, line 153, line 158, line 1237. Repo skill sizes: `garden-profile` 340 words, `garden-expert` 405 words, `landscape-design` 497 words. | None. |
| A-05 | Critical instruction placement and explicit save contracts. | PASS | Guide: line 1159. Repo: `skills/garden-profile/SKILL.md:65`, `skills/garden-profile/SKILL.md:71`, `skills/garden-expert/SKILL.md:43`, `skills/landscape-design/SKILL.md:66`. | None. |
| A-06 | Error handling guidance included in skill instructions. | PARTIAL | Guide checklist: line 1375. Repo: `skills/garden-expert/SKILL.md:18`, `skills/landscape-design/SKILL.md:23` include fallbacks; `skills/garden-profile/SKILL.md` has no explicit failure-mode subsection. | Add tiny failure-mode block for missing/unreadable garden files and permission errors. |
| A-07 | Examples included in skill body. | FAIL | Guide checklist: line 1377. Repo: no explicit "Examples" sections in `skills/garden-profile/SKILL.md`, `skills/garden-expert/SKILL.md`, `skills/landscape-design/SKILL.md`. | Add 1 short example block per skill (one typical query, one expected behavior summary). |
| A-08 | Triggering test coverage (obvious/paraphrased/unrelated). | PARTIAL | Guide: line 1338, line 1341. Repo harness has scenario tests (`dev/testing/regression-harness.md:33`, `dev/testing/regression-harness.md:44`, `dev/testing/regression-harness.md:57`, `dev/testing/regression-harness.md:71`, `dev/testing/regression-harness.md:84`) but no explicit unrelated-topic trigger suite. | Add a lightweight trigger test appendix with should-trigger/should-not-trigger prompts. |
| A-09 | Distribution metadata and install clarity. | PASS | Repo: `.claude-plugin/plugin.json:2`, `.claude-plugin/plugin.json:3`, `.claude-plugin/plugin.json:4`, `.claude-plugin/plugin.json:8`, `.claude-plugin/plugin.json:10`, `.claude-plugin/plugin.json:11`, `README.md:5`. | None. |

## Minimal Structural Fixes (Bitter Lesson Style)

1. Add one compact `## Examples` section to each skill with:
   - one should-trigger prompt,
   - one non-trigger prompt,
   - expected behavior in one line.
2. Add a compact `## Failure Modes` section in `skills/garden-profile/SKILL.md` for:
   - missing garden files,
   - unreadable/permission-denied files.
3. Extend `dev/testing/regression-harness.md` with a trigger-smoke block (no domain expansion), then track those rows in the retest matrix.

## Changes Applied in This Session

- Tightened frontmatter trigger boundaries:
  - `skills/garden-profile/SKILL.md:3`
  - `skills/garden-expert/SKILL.md:3`
  - `skills/landscape-design/SKILL.md:3`
- Added explicit save contract to `garden-profile`:
  - `skills/garden-profile/SKILL.md:58`
  - `skills/garden-profile/SKILL.md:62`
  - `skills/garden-profile/SKILL.md:64`
