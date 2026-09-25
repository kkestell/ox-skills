## Ox workflow

Tasks, issues, plans, work logs, reviews, and project documents live in the Fossil repository `.ox/ox.fossil`, which is committed to git with the code. Every Fossil command takes `-R .ox/ox.fossil`; there is no Fossil checkout. Run `fossil ui .ox/ox.fossil` to browse it. The timeline shows every ticket change, technote, and wiki edit in order.

- `/ox-plan` explores a change, adds a ticket for it if none exists, and writes a plan to the wiki page `plans/YYYY-MM-DD-NNN-slug`.
- `/ox-work` implements a plan, writes a work log as a technote tagged `work`, marks the ticket `Fixed`, and commits.
- `/ox-review` reviews code, fixes findings that have obvious fixes, records the rest as tickets, writes a review as a technote tagged `review`, closes the reviewed ticket, and commits.

### Tickets

Tickets are the only work list. They use Fossil's default schema and values.

- `type` — `Feature_Request` for a task, `Code_Defect` for a review finding.
- `status` — `Open` (to do), `Deferred` (not planned yet), `Fixed` (implemented, awaiting review), `Closed` (reviewed, or will not be done).
- `resolution` — set when closing: `Fixed`, `Rejected`, or `Works_As_Designed`.
- `severity` — `Critical`, `Severe`, `Important`, `Minor`, or `Cosmetic`, describing the effect on the user.
- `priority` — `Immediate`, `High`, `Medium`, `Low`, or `Zero`; the next task is the highest-priority `Open` ticket.
- `subsystem` — the area of the code, such as `parser` or `cli`.
- `comment` — the description: for a finding, the location, what can happen, the evidence, and the suggested fix.

Refer to a ticket by the first ten characters of its hash. Appended comments (`icomment`) use Fossil wiki links: `[HASH]` for a ticket, `[wiki:plans/NAME]` for a wiki page, and `[/technote/ID]` for a technote. Never delete a ticket; close it instead.

```sh
fossil ticket show "All Tickets" -R .ox/ox.fossil                 # list tickets
fossil ticket show 0 "tkt_uuid LIKE 'HASH%'" --quote -R .ox/ox.fossil   # every field of one ticket
fossil ticket history HASH -R .ox/ox.fossil                       # its comments and changes
fossil ticket add type Feature_Request title "..." status Open priority Medium subsystem cli comment "..." -R .ox/ox.fossil
fossil ticket set HASH status Fixed icomment "..." -R .ox/ox.fossil
```

### Documents

Documents are Markdown. Wiki pages link a ticket with `[](HASH)` and another page with `[](NAME)`.

- Wiki pages hold plans (`plans/YYYY-MM-DD-NNN-slug`) and the optional project documents `architecture`, `code-style`, `glossary`, and `testing`. Optional `plans/_template`, `work/_template`, and `reviews/_template` pages override the skills' built-in templates.
- Technotes hold work logs (tag `work`) and reviews (tag `review`). Refer to a technote by the first ten characters of its id.

```sh
fossil wiki list -R .ox/ox.fossil                                 # list pages
fossil wiki export NAME -R .ox/ox.fossil                          # print a page
fossil wiki create NAME FILE -M markdown -R .ox/ox.fossil         # add a page; commit replaces one
fossil wiki list -t -s -R .ox/ox.fossil                           # list technotes, id first
fossil wiki export -t ID -R .ox/ox.fossil                         # print a technote
fossil wiki create "Title" FILE --technote now --technote-tags work -M markdown -R .ox/ox.fossil
```
