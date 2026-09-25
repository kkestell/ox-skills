---
name: ox-init
description: "Create the Fossil repository `.ox/ox.fossil` if it is missing, import an existing `docs/agents/` workflow into it, and describe the Ox workflow in `AGENTS.md`. Use when setting up the Ox skills in a repository."
---

## Objective

Set up the Fossil repository the Ox skills share, and move any existing Markdown and CSV workflow files into it. Do not overwrite anything that already exists in the repository.

## Create the repository

1. Run `command -v fossil`. If Fossil is not installed, tell the user it is required (`brew install fossil` or see https://fossil-scm.org) and stop.
2. Create `.ox/` if it does not exist.
3. If `.ox/ox.fossil` does not exist, run `fossil new .ox/ox.fossil`. Do not open a Fossil checkout; the skills only use the repository file through `-R .ox/ox.fossil`. Keep Fossil's default ticket schema and field values.

## Import an existing workflow

4. If `docs/agents/` does not exist, skip to Document the workflow. Otherwise import its contents in the order below, so later items can link earlier ones. Every Fossil command takes `-R .ox/ox.fossil`. Do your best with files that do not match the old layout exactly; import what you can and report what you could not.
5. **Project documents.** Create a wiki page for each `docs/agents/*.md` other than `todo.md`, named after the file without `.md` (`architecture.md` becomes `architecture`). Use `fossil wiki create NAME FILE -M markdown`.
6. **Plans.** Create a wiki page `plans/NAME` for each `docs/agents/plans/*.md`, named after the file without `.md`, including `_template.md` as `plans/_template`.
7. **Issues.** Add one ticket for each row of `docs/agents/issues.csv`, in file order, and keep a map from the old `OX-NNNN` id to the new hash:

   ```sh
   fossil ticket add type Code_Defect title "TITLE" severity SEVERITY priority PRIORITY status STATUS resolution RESOLUTION subsystem AREA comment "Imported from issues.csv as OX-NNNN, created CREATED. Lens: LENS." -R .ox/ox.fossil
   ```

   - `severity`: `high` becomes `Severe`, `medium` becomes `Important`, `low` becomes `Minor`.
   - `priority`: `High` for Severe, `Medium` for Important, `Low` for Minor.
   - `status` and `resolution`: `scheduled` becomes `Open`; `unscheduled` becomes `Deferred`; `fixed` becomes `Closed` with resolution `Fixed`; `wontfix` becomes `Closed` with resolution `Rejected`. Omit `resolution` unless the ticket is `Closed`.
   - `subsystem`: the area of the code the finding is about, judged from the review or title, or omit it.
   - Read the finding's details from the review the row names, if it exists, and add the location and suggested fix to the comment.

8. **Tasks.** Add one `Feature_Request` ticket for each task item in `docs/agents/todo.md`. An item that links an `OX-NNNN` issue is not a task; it refers to the ticket imported in step 7, and if the item is checked, set that ticket to `Closed` with resolution `Fixed`. For a task, `status` is `Closed` with resolution `Fixed` when checked and `Open` when unchecked, `priority` is `Medium`, and the comment says `Imported from todo.md.` and, for a nested item, `Part of: PARENT TITLE`. Use `subsystem` for the area of the code when the title makes it clear.
9. **Work logs and reviews.** Create a technote for each `docs/agents/work/*.md` (tag `work`, timeline comment `Work: TITLE`) and each `docs/agents/reviews/*.md` (tag `review`, timeline comment `Review: TITLE`), using the file's first heading as `TITLE` and the `YYYY-MM-DD` at the start of the filename as the timestamp:

   ```sh
   fossil wiki create "Work: TITLE" FILE --technote YYYY-MM-DD --technote-tags work -M markdown -R .ox/ox.fossil
   ```

   Import `work/_template.md` and `reviews/_template.md` as the wiki pages `work/_template` and `reviews/_template` instead. Read each technote's id from `fossil wiki list -t -s`.

10. **Links.** Before creating each page or technote, rewrite references in its text where the target is clear: `docs/agents/plans/NAME.md` becomes `[](plans/NAME)`, `OX-NNNN` becomes `[](HASH)` from the map, and references to a work log or review become `[](/technote/ID)` when that technote already exists. Leave a reference alone if you cannot tell what it points to. After the technotes exist, append a comment to each imported ticket that names a review: `fossil ticket set HASH icomment "Found in review [/technote/ID]." -R .ox/ox.fossil`.
11. **Remove the old files.** Run `git rm -r docs/agents` so the files stay in git history. If an `AGENTS.md` section describes the old `docs/agents/` workflow, replace it in the next step.

## Document the workflow

12. Read `AGENTS.md` at the repository root, or create it if it is missing.
13. If it does not already describe the Fossil-based Ox workflow, add the section in this skill's `assets/agents-section.md`, replacing any section that describes the old `docs/agents/` layout. Keep it concise and adjust the repository path only if the repository keeps it elsewhere. If the workflow is already described, leave it as is.
14. Do not commit. Give the final response and stop.

## Final response

When setup is done, reply in the form below and nothing else. Lead with the main point, write plainly, and leave out the checks that passed and the steps you took.

```markdown
One sentence saying what was set up, or that the Ox workflow was already in place.

**Imported:** 14 tickets (5 from issues.csv, 9 from todo.md), 6 plans, 4 work logs, 3 reviews, 2 project documents.

**Not imported:**

- `docs/agents/notes.md` — reason.

**Files:**

- `.ox/ox.fossil` (created)
- `AGENTS.md` (modified)
- `docs/agents/` (removed)
```

Omit Imported and Not imported when there was nothing to import. List every file you created, modified, or removed.
