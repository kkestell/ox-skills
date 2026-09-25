---
name: ox-review
description: "Review code in a diff, branch, commit, or specified files, write findings in `docs/agents/reviews/`, and record them in `docs/agents/issues.csv`. Supports general and language-specific focused code reviews. Do not use for plan critiques or standalone documentation reviews."
argument-hint: "[general|lens[,lens...]] [review scope]"
---

## Objective

Review the code the user names. Write findings without changing code unless the user also asks for fixes. Follow review and delegation rules in `AGENTS.md`.

This skill and `docs/agents/reviews/` are for code reviews. Plan critiques and standalone documentation reviews are outside its scope. Read plans and documentation as context for code under review; the documentation lens checks guidance for that code.

## Choose what to review

Read `<input_document> $ARGUMENTS </input_document>`. Use `general` unless the user names one or more lenses from the list below. Ask for clarification only when the answer would change what you review.

For a diff, branch, or commit, inspect its changes and the code that calls or depends on them. For named files, directories, or the whole codebase, review that full scope. For a feature review, check other code the feature needs, even when it is outside the diff.

For a general review, choose lenses that fit the code and its risks, including language-specific lenses when applicable. For a focused review, stay within the requested lenses and examine the relevant code closely. Read only the matching lens files linked below. Each lens is either general or specific to one language.

## Review

Trace behavior through callers, state changes, resource lifetimes, and tests. Judge implementation choices by their purpose and consequence. Do not treat a language feature or coding pattern as a defect on its own.

Read the requirements that define the behavior. If the user has approved a new design, review against that design. Flag complex or expensive code that adds no required behavior. Do not recommend extra code for a hypothetical edge case alone.

Check suspected bugs by tracing the code, reproducing the behavior, or running a focused check. Follow `AGENTS.md` when choosing validation. A lens does not require a fixed set of commands, a new test for each error path, or a broader review than the requested scope. Report only supported findings, and say when you reviewed only part of the code.

## Report

If `docs/agents/issues.csv` or `docs/agents/todo.md` is missing, run the `ox-init` skill first. Read `docs/agents/issues.csv` and give each finding, confirmed or not, the next unused id (`OX-NNNN`, one more than the highest id in the file).

Read `docs/agents/reviews/_template.md`, or this skill's `assets/_template.md` if the workspace has none, and use it to write the review in `docs/agents/reviews/YYYY-MM-DD-NNN-slug.md`, using the next sequence for the day. State the scope, selected lenses, and significant gaps in coverage. Group confirmed findings by severity (high, medium, low), then by lens within each severity. For each finding, give its id, the source location, what can happen, the evidence, and a suggested fix. List unconfirmed issues separately with their ids and say what would confirm them. Record the checks you ran. If there are no findings, say so. End with a short verdict.

## Record issues

Append one row to `docs/agents/issues.csv` for each finding and each unconfirmed issue, in the order they appear in the review. Never reorder or delete existing rows, because `todo.md` links to rows by line number. Quote a field that contains a comma, a quote, or a newline as CSV requires. The columns are:

- `id` — the finding's `OX-NNNN` id.
- `created` — the current local date and time as `YYYY-MM-DD HH:MM`.
- `title` — the finding title.
- `severity` — `high`, `medium`, or `low`.
- `lens` — the lens that found it, or empty.
- `confirmed` — `true` for a confirmed finding, `false` for an unconfirmed issue.
- `status` — `planned` for high and medium severity, `unplanned` for low.
- `review` — the review path relative to `docs/agents/`, such as `reviews/2026-09-25-001-slug.md`.

Add each high and medium severity issue to `docs/agents/todo.md` as an unchecked item, `- [ ] [OX-NNNN](issues.csv:LINE): Title`, where `LINE` is the row's line number in `issues.csv`. When the user, the plan, or the work log for the reviewed change names a task in `todo.md`, nest the item under that task. Otherwise add it as a new top-level item. Low severity issues stay out of `todo.md`.

## General lenses

`general` is the review mode that chooses applicable lenses; it is not a lens.

- [`resources`](references/general/resources.md) — resource ownership, lifetime, and cleanup.
- [`error-handling`](references/general/error-handling.md) — failures, useful errors, cancellation, and partial effects.
- [`api-design`](references/general/api-design.md) — caller contracts and shared interfaces.
- [`naming`](references/general/naming.md) — clear and consistent vocabulary.
- [`performance`](references/general/performance.md) — material costs for realistic inputs.
- [`testing`](references/general/testing.md) — behavior coverage and reliable assertions.
- [`readability`](references/general/readability.md) — clear control flow and local reasoning.
- [`comments`](references/general/comments.md) — useful explanations of intent, constraints, and consequences in the code.
- [`concurrency`](references/general/concurrency.md) — shared state, task lifetime, and cancellation.
- [`security`](references/general/security.md) — trust boundaries, permissions, and secrets.
- [`correctness`](references/general/correctness.md) — required behavior and reachable state changes.
- [`architecture`](references/general/architecture.md) — responsibilities, dependencies, and needless complexity.
- [`dependencies`](references/general/dependencies.md) — library choices and integration costs.
- [`documentation`](references/general/documentation.md) — caller guidance and design documents associated with the code under review.
- [`simplicity`](references/general/simplicity.md) — less code and fewer concepts with behavior preserved.

## Rust lenses

Use these only for Rust code. Future language lenses belong in their own language directory, with no language-specific rules in general lenses.

- [`rust-ownership`](references/rust/ownership.md) — borrowing, clones, allocation, and shared ownership.
- [`rust-idioms`](references/rust/idioms.md) — `Result`/`Option`, traits, generics, macros, and Rust concurrency types.
- [`rust-cargo`](references/rust/cargo.md) — Cargo manifests, lockfiles, features, and toolchain costs.
