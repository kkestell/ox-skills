# Ox Skills

The skills keep their state in a [Fossil](https://fossil-scm.org) repository at `.ox/ox.fossil`, committed to git alongside the code, and use Fossil's own concepts rather than a separate task list and issue log. Every Fossil command runs against the repository file with `-R .ox/ox.fossil`; nothing is checked out. Run `fossil ui .ox/ox.fossil` to browse it, and the timeline shows every ticket change, work log, and review in order.

| Content                                     | Where it lives                                                                                          |
| ------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Tasks and review findings                   | Tickets, `Feature_Request` or `Code_Defect`, with Fossil's default statuses, severities, and priorities |
| Plans                                       | Wiki pages `plans/YYYY-MM-DD-NNN-slug`                                                                  |
| Work logs and reviews                       | Technotes tagged `work` or `review`                                                                     |
| Architecture, code style, glossary, testing | Optional wiki pages `architecture`, `code-style`, `glossary`, `testing`                                 |
| Templates                                   | Optional wiki pages `plans/_template`, `work/_template`, `reviews/_template`                            |

If a template page exists, the skill uses it; otherwise the skill falls back to its built-in default template.

A ticket's history tells the story of a change: `/ox-plan` links the plan, `/ox-work` marks it `Fixed` and links the work log and git commit, and `/ox-review` marks it `Closed` and links the review. Findings the review leaves open become new `Code_Defect` tickets, `Open` for Severe and Important and `Deferred` for Minor.

## Skills

### `/ox-init`

Creates `.ox/ox.fossil` if it is missing, imports an existing `docs/agents/` workflow (todo, issues, plans, work logs, reviews, and project documents) into it, and describes the workflow in `AGENTS.md`. Requires Fossil to be installed.

### `/ox-plan`

Plans a code or behavior change. Adds a `Feature_Request` ticket if none exists and writes a plan to a `plans/` wiki page.

### `/ox-work`

Implements a plan and commits. Writes a work log as a technote and marks the ticket `Fixed`.

### `/ox-review`

Reviews code in a diff, branch, commit, or files. Fixes findings that have obvious fixes, records the remaining findings as tickets, writes a review as a technote, closes the reviewed ticket, and commits.

## Workflows

Run each step in a fresh session.

### Implement a task

1. `/ox-plan add an export command` (or `/ox-plan 533f4406a1` for an existing ticket)
2. `/ox-work plans/2026-09-25-001-export`
3. `/ox-review the last commit`

### Fix a finding

1. `/ox-plan 732fce7493`
2. `/ox-work plans/2026-09-25-002-fix-final-token`
3. `/ox-review the last commit`

## Useful Fossil commands

```sh
fossil ticket show "All Tickets" -R .ox/ox.fossil            # list tickets
fossil ticket show 0 "status='Open'" -R .ox/ox.fossil        # every field, filtered
fossil ticket history 533f4406a1 -R .ox/ox.fossil            # one ticket's story
fossil wiki list -R .ox/ox.fossil                            # list wiki pages
fossil wiki export plans/2026-09-25-001-export -R .ox/ox.fossil
fossil wiki list -t -s -R .ox/ox.fossil                      # list technotes, id first
fossil wiki export -t 29d47147ea -R .ox/ox.fossil            # print a technote
fossil timeline -R .ox/ox.fossil
```

## Global install

From a local checkout:

```bash
npx skills add /path/to/ox-skills -g -a claude-code -a codex -s '*'
```

From GitHub:

```bash
npx skills add kkestell/ox-skills -g -a claude-code -a codex -s '*'
```
