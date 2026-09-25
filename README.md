# Ox Skills

## Skills

Each artifact directory may contain a `_template.md`; if it does, the skill uses it, otherwise the skill falls back to its built-in default template.

### `/ox-init`

Creates `docs/agents/todo.md` and `docs/agents/issues.csv` if they are missing and describes the workflow in `AGENTS.md`.

### `/ox-plan`

Plans a code or behavior change. Writes a plan to `docs/agents/plans/`.

### `/ox-work`

Implements a plan and commits. Writes a work log to `docs/agents/work/`.

### `/ox-review`

Reviews code in a diff, branch, commit, or files. Writes a review to `docs/agents/reviews/`, records each finding in `docs/agents/issues.csv`, and adds high and medium severity issues to `docs/agents/todo.md`.

## Global install

From a local checkout:

```bash
npx skills add /path/to/ox-skills -g -a claude-code -a codex -s '*'
```

From GitHub:

```bash
npx skills add kkestell/ox-skills -g -a claude-code -a codex -s '*'
```
