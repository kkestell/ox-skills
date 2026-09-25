---
name: ox-work
description: Implement a plan from a `plans/` wiki page in `.ox/ox.fossil`, write a work log as a technote, mark the ticket `Fixed`, and commit. Use to carry out a written plan, not to plan or review.
argument-hint: "[plan page name or slug]"
---

## Objective

Implement the plan, record what was done, and commit.

## Establish the work

1. Read `<plan> $ARGUMENTS </plan>` and find the plan in `fossil wiki list -R .ox/ox.fossil | grep '^plans/'`. If it is empty or matches no page, ask which plan to implement and stop. Every Fossil command below takes `-R .ox/ox.fossil`.
2. Read the plan with `fossil wiki export plans/YYYY-MM-DD-NNN-slug -R .ox/ox.fossil` and note the ticket hash in its Ticket section. Then read `AGENTS.md` and the wiki pages `architecture`, `code-style`, `glossary`, and `testing`, skipping any page that does not exist.

## Implement

3. Read the code the plan references before changing it. Carry out the plan's tasks in order and write the tests it names.
4. Use the names the plan and the `glossary` page give. Do not add work the plan does not call for.
5. When the code contradicts the plan or a task cannot be done as written, stop and ask the user. Do not redesign the change on your own.
6. Validate the change as `AGENTS.md` and the `testing` page direct. Fix failures before continuing.

## Commit the code

7. Commit the implementation, following the commit rules in `AGENTS.md`. Do not commit unrelated changes. Note the commit hash.

## Write the work log

8. Read the wiki page `work/_template`, or this skill's `assets/_template.md` if the repository has none, and use it to write the work log to a temporary file. Link the plan as `[](plans/YYYY-MM-DD-NNN-slug)` and the ticket as `[](HASH)`, and give the git commit hash. Then create it as a technote whose timeline comment is `Work: <plan title>`:

   ```sh
   fossil wiki create "Work: <plan title>" <temp-file> --technote now --technote-tags work -M markdown -R .ox/ox.fossil
   ```

   Read the technote id from `fossil wiki list -t -s -R .ox/ox.fossil` (most recent first, id in the first column).

9. Keep the log concise. Record where the work departed from the plan and why, decisions made during the work, the checks that ran, manual verification with the commands to reproduce it, and follow-up work. Do not repeat the plan, the diff, or the conversation.

## Update the ticket

10. Mark the ticket implemented and link the work log:

    ```sh
    fossil ticket set HASH status Fixed icomment "Implemented in git commit abc1234. Work log: [/technote/ID]" -R .ox/ox.fossil
    ```

11. Amend `.ox/ox.fossil` into the implementation commit with `git add .ox/ox.fossil && git commit --amend --no-edit`, so the code and its record land together. Give the final response and stop.

## Final response

When the work is committed, reply in the form below and nothing else. Lead with the main point, write plainly, and leave out the checks that passed and the steps you took.

```markdown
One or two sentences saying what was built and whether the plan's goal is met.

**Surprises:**

- A departure from the plan, a detour, something unexpected in the code, or follow-up work.

**Work log:** technote `29d47147ea` · **Ticket:** `533f4406a1` (Fixed) · **Commit:** `abc1234` · **Lines:** +120 / −45 (net +75)

**Files:**

- `src/parser.rs` (modified)
- `src/tokens.rs` (created)
- `.ox/ox.fossil` (modified)

**Next:** `/ox-review commit abc1234`
```

Write `None.` under Surprises if the work went as planned. Count lines from the commit, excluding `.ox/`, with `git diff --shortstat HEAD~1 HEAD -- . ':(exclude).ox'`. List every file the commit created or modified, marked `(created)` or `(modified)`.
