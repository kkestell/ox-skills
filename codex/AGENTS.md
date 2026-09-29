# Communication

- Keep required skill-use notices to one brief sentence.
- Do not narrate routine skill mechanics, formatting steps, or other execution details unless they affect the result, require a decision, expose a risk, or reveal a blocker.
- Keep progress updates concise and user-relevant.

# Proportional validation

- Match verification effort to the risk of the change.
- For ordinary file renames, use the normal filesystem operation. Do not hash files to prove that a rename preserved their contents.
- For comment-only, documentation-only, and filename-only changes, use focused searches and diff inspection. Do not run full test, lint, build, or formatting suites unless the user asks or applicable repository instructions explicitly require them.
- Run broad validation only when behavior, generated artifacts, interfaces, or build outputs could plausibly change.

# Proportional tool use

- For a small, well-scoped change, take the shortest complete path: read the target and relevant instructions, edit it, run one focused check, perform the requested delivery steps, and verify the result once.
- Use a documented command directly. Do not inspect CLI help, try alternate validators, or repeat status and diff checks unless a concrete uncertainty or failure requires it.
- Stop calling tools when the requested outcome is complete and sufficiently verified.

# Task titles

- At the start of every new Codex task, set a useful title based on the user's actual objective. Use a concise, concrete phrase in sentence case.
- Never use a filesystem path, a pasted prompt fragment, a skill invocation, or a generic workflow phrase such as "Run kwork" as a task title.
- Prefer the intended outcome, for example "Specify Fern's module system" or "Fix integer literal diagnostics". If the task's scope changes materially, update the title.
