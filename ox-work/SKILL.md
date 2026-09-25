---
name: ox-work
description: Implement a plan from `eng/plans/`, write a work log in `eng/work/`, and commit. Use to carry out a written plan, not to plan or review.
argument-hint: "[plan path or slug]"
---

## Objective

Implement the plan, record what was done, and commit.

## Establish the work

1. Read `<plan> $ARGUMENTS </plan>` and find the plan in `eng/plans/`. If it is
   empty or matches no plan, ask which plan to implement and stop.
2. Read the plan, then `AGENTS.md`, `eng/architecture.md`,
   `eng/code-style.md`, `eng/glossary.md`, and `eng/testing.md`.

## Implement

3. Read the code the plan references before changing it. Carry out the plan's
   tasks in order and write the tests it names.
4. Use the names the plan and `eng/glossary.md` give. Do not add work the plan
   does not call for.
5. When the code contradicts the plan or a task cannot be done as written, stop
   and ask the user. Do not redesign the change on your own.
6. Validate the change as `AGENTS.md` and `eng/testing.md` direct. Fix
   failures before continuing.

## Write the work log

7. Read `eng/work/TEMPLATE.md`, or this skill's `assets/work-log-template.md`
   if the workspace has none, and use it to write the work log in `eng/work/`.
   Name the file `YYYY-MM-DD-NNN-slug.md`, using today's date, the next
   sequence for the day, and the plan's slug.
8. Keep the log concise. Record where the work departed from the plan and why,
   decisions made during the work, the checks that ran, manual verification
   with the commands to reproduce it, and follow-up work. Do not repeat the
   plan, the diff, or the conversation.

## Commit

9. Commit the implementation and the work log together, following the commit
   rules in `AGENTS.md`. Do not commit unrelated changes.
10. Give the work log path and the commit hash and stop.
