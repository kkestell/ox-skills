## Ox workflow

Plans, work logs, reviews, and issues live in `docs/agents/`.

- `/ox-plan` explores a change and writes a plan to `docs/agents/plans/`.
- `/ox-work` implements a plan, writes a work log to `docs/agents/work/`, and commits.
- `/ox-review` reviews code, writes a review to `docs/agents/reviews/`, and records each finding in `docs/agents/issues.csv`.
- `docs/agents/todo.md` is the task list. High and medium severity issues are added under the task they affect, or as new top-level items.
- `docs/agents/issues.csv` is the issue log. Each row has an id (`OX-NNNN`), a created time, a title, a severity (`low`, `medium`, `high`), the review lens that found it, a confirmed flag, a status (`unplanned`, `planned`, `wontfix`, `fixed`), and the review that found it. Issues found outside a review leave the lens and review empty. Append rows; never reorder or delete them, because `todo.md` links to rows by line number.
