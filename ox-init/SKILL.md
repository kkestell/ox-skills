---
name: ox-init
description: "Create `docs/agents/todo.md` and `docs/agents/issues.csv` if they are missing and describe the Ox workflow in `AGENTS.md`. Use when setting up the Ox skills in a repository."
---

## Objective

Set up the files the Ox skills share. Do not overwrite anything that already exists.

## Create the workflow files

1. Create `docs/agents/` if it does not exist.
2. If `docs/agents/todo.md` does not exist, copy this skill's `assets/todo.md` there.
3. If `docs/agents/issues.csv` does not exist, copy this skill's `assets/issues.csv` there. It contains only the header row.

## Document the workflow

4. Read `AGENTS.md` at the repository root, or create it if it is missing.
5. If it does not already describe the Ox workflow, add the section in this skill's `assets/agents-section.md`. Keep it concise and adjust paths only if the repository keeps these files elsewhere. If the workflow is already described, leave it as is.

## Report

6. List the files you created or changed and stop.
