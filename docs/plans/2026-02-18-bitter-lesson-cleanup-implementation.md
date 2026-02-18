# Bitter Lesson Cleanup — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Clean up garden-bot v0.1.0 repo to align with the skills' lean, Bitter-Lesson-informed philosophy.

**Architecture:** 7 independent cleanup tasks executed sequentially, one commit each. No code logic changes — only file deletions, renames, and small text edits.

**Tech Stack:** Git, markdown

**Design doc:** `docs/plans/2026-02-18-bitter-lesson-cleanup-design.md` (moves to `dev/plans/` in Task 4)

---

### Task 1: Remove `claude-skills-documentation.md`

**Files:**
- Delete: `claude-skills-documentation.md`

**Step 1: Verify file exists and check for references**

Run: `grep -r "claude-skills-documentation" . --include="*.md" --include="*.json" -l`
Expected: No files reference it (or only the design/review docs)

**Step 2: Remove from git**

```bash
git rm claude-skills-documentation.md
```

**Step 3: Commit**

```bash
git commit -m "Remove skills documentation reference copy (18KB, unused at runtime)"
```

**Step 4: Verify**

Run: `ls claude-skills-documentation.md`
Expected: File not found

---

### Task 2: Remove `references/` dirs + redundant `.gitkeep` files

**Files:**
- Delete: `skills/garden-expert/references/.gitkeep`
- Delete: `skills/landscape-design/references/.gitkeep`
- Delete: `skills/garden-expert/.gitkeep`
- Delete: `skills/garden-profile/.gitkeep`
- Delete: `skills/landscape-design/.gitkeep`

**Step 1: Remove all 5 files**

```bash
git rm skills/garden-expert/references/.gitkeep
git rm skills/landscape-design/references/.gitkeep
git rm skills/garden-expert/.gitkeep
git rm skills/garden-profile/.gitkeep
git rm skills/landscape-design/.gitkeep
```

**Step 2: Verify skill dirs still tracked**

Run: `git ls-files skills/`
Expected: 3 SKILL.md files remain. No .gitkeep files. No references/ dirs.

**Step 3: Commit**

```bash
git commit -m "Remove vestigial .gitkeep and references/ directories"
```

---

### Task 3: Rewrite CLAUDE.md for shipped status

**Files:**
- Modify: `CLAUDE.md`

**Step 1: Read current CLAUDE.md**

Read the full file to understand current structure.

**Step 2: Rewrite**

Replace entire contents with a shipped-status version that keeps:
- Title and description
- Architecture section (update paths: `docs/` → `dev/`)
- Skill Authoring lessons learned section
- "Don't mention claude in git commit messages"

Remove:
- Progress checklist
- Test Data State
- Testing Methodology (replace with: "Test results and methodology: `dev/testing/`")
- landscape-design REFACTOR — Final Status
- Environment section
- Web search note

Target: under 50 lines.

**Step 3: Verify**

Read the rewritten file. Confirm:
- No stale references to `.worktrees/`, `~/garden-bot/`, or specific test data
- Skill Authoring section preserved
- Paths reference `dev/` (anticipating Task 4 rename)

**Step 4: Commit**

```bash
git add CLAUDE.md
git commit -m "Rewrite CLAUDE.md for shipped status, remove development artifacts"
```

---

### Task 4: Reorganize repo — `docs/` → `dev/`

**Files:**
- Rename: `docs/` → `dev/`
- Create: `dev/testing/results/` (move 5 analysis docs here)
- Create: `dev/testing/transcripts/` (move 4 transcript files here)
- Delete: `docs/testing/landscaping-gardening-scenario-1-repo/` (entire dir)
- Modify: `.gitignore`

**Step 1: Remove the scenario repo**

```bash
git rm -r docs/testing/landscaping-gardening-scenario-1-repo/
```

**Step 2: Create new directory structure and move files**

```bash
mkdir -p dev/plans dev/testing/results dev/testing/transcripts
```

Move plan docs:
```bash
git mv docs/plans/2026-02-16-garden-bot-design.md dev/plans/
git mv docs/plans/2026-02-16-garden-bot-implementation.md dev/plans/
git mv docs/plans/2026-02-18-bitter-lesson-review.md dev/plans/
git mv docs/plans/2026-02-18-bitter-lesson-cleanup-design.md dev/plans/
git mv docs/plans/2026-02-18-bitter-lesson-cleanup-implementation.md dev/plans/
```

Move analysis/results docs:
```bash
git mv docs/testing/garden-expert-baseline.md dev/testing/results/
git mv docs/testing/garden-profile-baseline.md dev/testing/results/
git mv docs/testing/integration-results.md dev/testing/results/
git mv docs/testing/landscape-design-baseline.md dev/testing/results/
git mv docs/testing/landscape-design-refactor-analysis.md dev/testing/results/
```

Move transcripts:
```bash
git mv docs/testing/scenario1-baseline-transcript.txt dev/testing/transcripts/
git mv docs/testing/scenario1-green-transcript.txt dev/testing/transcripts/
git mv docs/testing/scenario2-green-transcript.txt dev/testing/transcripts/
git mv docs/testing/scenario3-green-transcript.txt dev/testing/transcripts/
```

Move remaining test data file:
```bash
git mv docs/testing/scenario2-baseline-garden-log.md dev/testing/results/
```

**Step 3: Update .gitignore**

Change:
```
docs/testing/snapshots/
docs/testing/transcripts/
```
To:
```
dev/testing/snapshots/
dev/testing/transcripts/
```

**Step 4: Verify structure**

Run: `find dev/ -type f | sort`
Expected:
```
dev/plans/2026-02-16-garden-bot-design.md
dev/plans/2026-02-16-garden-bot-implementation.md
dev/plans/2026-02-18-bitter-lesson-cleanup-design.md
dev/plans/2026-02-18-bitter-lesson-cleanup-implementation.md
dev/plans/2026-02-18-bitter-lesson-review.md
dev/testing/results/garden-expert-baseline.md
dev/testing/results/garden-profile-baseline.md
dev/testing/results/integration-results.md
dev/testing/results/landscape-design-baseline.md
dev/testing/results/landscape-design-refactor-analysis.md
dev/testing/results/scenario2-baseline-garden-log.md
dev/testing/transcripts/scenario1-baseline-transcript.txt
dev/testing/transcripts/scenario1-green-transcript.txt
dev/testing/transcripts/scenario2-green-transcript.txt
dev/testing/transcripts/scenario3-green-transcript.txt
```

Run: `ls docs/ 2>&1`
Expected: No such directory (fully moved)

**Step 5: Commit**

```bash
git add -A
git commit -m "Reorganize docs/ to dev/, separate results from transcripts, remove scenario repo"
```

---

### Task 5: Annotate plan docs as historical

**Files:**
- Modify: `dev/plans/2026-02-16-garden-bot-design.md` (line 1)
- Modify: `dev/plans/2026-02-16-garden-bot-implementation.md` (line 1)

**Step 1: Add header to design doc**

Prepend to `dev/plans/2026-02-16-garden-bot-design.md`:
```markdown
> **Historical document** — reflects what was planned, not what shipped. Key deviations: ASCII replaced SVG, reference files never needed, CWD replaced ~/garden-bot/, MPL-2.0 replaced MIT, manual testing replaced subagent testing. See shipped skills for actual implementation.

```

(Blank line after the blockquote, before existing content.)

**Step 2: Add header to implementation plan**

Prepend same header to `dev/plans/2026-02-16-garden-bot-implementation.md`.

**Step 3: Verify**

Read first 3 lines of each file. Confirm header present.

**Step 4: Commit**

```bash
git add dev/plans/2026-02-16-garden-bot-design.md dev/plans/2026-02-16-garden-bot-implementation.md
git commit -m "Annotate original plan docs as historical"
```

---

### Task 6: Fix README install section

**Files:**
- Modify: `README.md`

**Step 1: Read current README**

Read the file. Find the install section.

**Step 2: Replace marketplace placeholder**

Change:
```markdown
**From a marketplace** (if listed):

\```
/plugin install garden-bot@marketplace-name
\```
```

To:
```markdown
**From marketplace:**

\```
/plugin marketplace add Benny-Lewis/Benny-Lewis-plugins
\```

Then browse available plugins and install garden-bot:

\```
/plugin
\```
```

**Step 3: Verify**

Read the updated install section. Confirm no placeholder text remains.

**Step 4: Commit**

```bash
git add README.md
git commit -m "Fix README install instructions with actual marketplace path"
```

---

### Task 7: Remove specific URL from garden-expert

**Files:**
- Modify: `skills/garden-expert/SKILL.md` (line 18)

**Step 1: Read current line**

Read `skills/garden-expert/SKILL.md`. Find the line with `extension.oregonstate.edu`.

**Step 2: Edit**

Change:
```
If web search returns no results, fetch extension service pages directly (e.g. `extension.oregonstate.edu/gardening/vegetables`). Only cite URLs you actually retrieved successfully — never guess at URLs in your citations.
```

To:
```
If web search returns no results, fetch extension service pages directly. Only cite URLs you actually retrieved successfully — never guess at URLs in your citations.
```

**Step 3: Verify**

Run: `grep -r "oregonstate" skills/`
Expected: No matches

**Step 4: Commit**

```bash
git add skills/garden-expert/SKILL.md
git commit -m "Remove specific URL from garden-expert source hierarchy"
```
