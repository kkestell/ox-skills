---
name: ox-plan
description: Explore an Ox code or behavior change, add a ticket for it if none exists, and write a plan to a `plans/` wiki page in `.ox/ox.fossil`. Use for implementation planning, not standalone documentation edits.
argument-hint: "[ticket hash, jira ticket, feature idea, bug report, or improvement to explore]"
---

## Objective

Write a plan without changing the code, and tie it to a ticket.

## Design standard

The project is a personal project with one user, its author. Choose the simplest design that meets the stated need. State the assumptions the code makes about its inputs and let the code rely on them instead of checking them. Prefer crashing with a clear message over recovering from a failure the user can fix. Do not add configuration, abstraction, or extensibility for a need the user has not stated. When a request implies handling an unusual case, ask whether it actually happens before designing for it.

## Establish the work

1. Read `<feature_description> $ARGUMENTS </feature_description>`. If it is empty, list the `Open` tickets with `fossil ticket show "All Tickets" -R .ox/ox.fossil`, ask which one to plan, and stop.
2. If `.ox/ox.fossil` is missing, run the `ox-init` skill first. Every Fossil command below takes `-R .ox/ox.fossil`.
3. If the request names a ticket, read it with `fossil ticket show 0 "tkt_uuid LIKE 'HASH%'" --quote -R .ox/ox.fossil` and `fossil ticket history HASH -R .ox/ox.fossil`, and read any review technote its comments link. Otherwise, check `fossil ticket show "All Tickets" -R .ox/ox.fossil` for an existing ticket that matches the request and use it.
4. Read `AGENTS.md`, then the wiki pages `architecture`, `code-style`, `glossary`, and `testing` with `fossil wiki export NAME -R .ox/ox.fossil`, skipping any page that does not exist. Refer to these documents in the plan without repeating their contents.

## Explore the code

5. Search the relevant files and read the code to change, nearby examples, public APIs, and tests. Follow an existing pattern when it fits. If the request is too unclear to know where to look, brainstorm first.

## Brainstorm

6. Brainstorm with the user before writing when the user asks to brainstorm, the request is unclear, or exploring leaves a real engineering or design decision. Otherwise, go to Write.
7. Ask one focused question at a time and wait for the answer. For each decision, give the options, their trade-offs, and a recommendation. Do not ask what the repository documents or existing code already answer.
8. Speak clearly and simply. Use terms from the `glossary` page exactly, and do not use jargon, invented terms, or shorthand.
9. Say so directly when a request adds a lot of complexity, handles a case that will not happen in practice, contradicts the architecture or an earlier decision, or fits poorly with existing code. Name the cost and recommend a simpler option. Do not let the design grow complex to fit every request.
10. Stop brainstorming when the scope and every decision are settled.

## Write

11. If no ticket exists for the request, add one so the plan, work log, and review have a place to attach:

    ```sh
    fossil ticket add type Feature_Request title "Short title" status Open priority Medium subsystem area comment "One or two sentences on the need." -R .ox/ox.fossil
    ```

    `subsystem` is the area of the code the change touches. The command prints the ticket hash.

12. Read the wiki page `plans/_template`, or this skill's `assets/_template.md` if the repository has none, and use it to write the plan to a temporary file. Name the page `plans/YYYY-MM-DD-NNN-slug`, using the next sequence for the day from `fossil wiki list -R .ox/ox.fossil | grep '^plans/YYYY-MM-DD-'`. Link the ticket in the plan's Ticket section as `[](HASH)`. Then create the page and link it from the ticket:

    ```sh
    fossil wiki create plans/YYYY-MM-DD-NNN-slug <temp-file> -M markdown -R .ox/ox.fossil
    fossil ticket set HASH icomment "Plan: [wiki:plans/YYYY-MM-DD-NNN-slug]" -R .ox/ox.fossil
    ```

13. Keep the plan to relevant code references, tasks tied to files, decisions that need explanation, names, and tests for this change. Do not repeat the architecture documents, repository rules, standard validation commands, conversation history, rejected options, or work for a later change.
14. Use terms from the `glossary` page exactly. Use the same names in plan tasks, proposed code, comments, and documentation. Do not give one concept several names or give an existing term a new meaning. Define any new term in the plan's Naming section and use it consistently.
15. Do not review the plan yourself or ask another agent to review it. Do not commit to git. Give the final response and stop.

## Final response

When the plan is written, reply in the form below and nothing else. Lead with the main point, write plainly, and leave out the options you rejected, the code you explored, and the steps you took.

```markdown
Two to four sentences explaining, at a high level, what the code change does and how.

**Plan:** `plans/YYYY-MM-DD-NNN-slug` · **Ticket:** `533f4406a1` (created)

**Files:**

- `src/parser.rs` (modified)
- `src/tokens.rs` (created)

**Next:** `/ox-work plans/YYYY-MM-DD-NNN-slug`
```

Mark the ticket `(created)` if this run added it; otherwise omit the mark. List every file the plan will create or modify, marked `(created)` or `(modified)`.
