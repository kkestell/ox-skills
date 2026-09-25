---
name: ox-review
description: "Review code in a diff, branch, commit, or specified files, fix findings that have obvious fixes, record the remaining findings as tickets in `.ox/ox.fossil`, write the review as a technote, close the reviewed ticket, and commit. Supports general and language-specific focused code reviews. Do not use for plan critiques or standalone documentation reviews."
argument-hint: "[general|lens[,lens...]] [review scope]"
---

## Objective

Review the code the user names. Fix findings that have an obvious, straightforward fix, record the rest as tickets, and commit. Follow review and delegation rules in `AGENTS.md`.

This skill and the `review` technotes are for code reviews. Plan critiques and standalone documentation reviews are outside its scope. Read plans and documentation as context for code under review; the documentation lens checks guidance for that code.

## Standard

The code under review is a personal project with one user, its author. Small, direct code that is easy to understand matters more than handling every case. Report only what would actually go wrong for that user, or what makes the code harder to understand or larger than it needs to be.

These are not findings:

- Inputs the user will not produce, adversarial inputs, or data the program itself wrote that could only be malformed if something else had already failed.
- Multiple users, concurrent access, or hostile networks, unless the code actually does that.
- Resource exhaustion, hardening, or a defensive check whose only justification is that the case is possible in theory.
- A missing recovery path where crashing with a clear message is acceptable.
- A style or pattern preference with no effect on behavior or readability.

Existing code that handles one of these cases is a finding: report it as code to remove.

Severity uses Fossil's values and describes the effect on the user:

- `Severe` — wrong results, lost data, or a crash in normal use.
- `Important` — wrong behavior in a realistic case, or code that is materially harder to understand or larger than it needs to be.
- `Minor` — polish.

## Choose what to review

Read `<input_document> $ARGUMENTS </input_document>`. Use `general` unless the user names one or more lenses from the list below. Ask for clarification only when the answer would change what you review.

For a diff, branch, or commit, inspect its changes and the code that calls or depends on them. For named files, directories, or the whole codebase, review that full scope. For a feature review, check other code the feature needs, even when it is outside the diff.

For a general review, choose lenses that fit the code and its risks, including language-specific lenses when applicable. For a focused review, stay within the requested lenses and examine the relevant code closely. Read only the matching lens files linked below. Each lens is either general or specific to one language.

## Review

Trace behavior through callers, state changes, resource lifetimes, and tests. Judge implementation choices by their purpose and consequence. Do not treat a language feature or coding pattern as a defect on its own.

Read the requirements that define the behavior. If the user has approved a new design, review against that design. Flag complex or expensive code that adds no required behavior. Do not recommend extra code for a hypothetical edge case alone.

Confirm each suspected bug by tracing the code, reproducing the behavior, or running a focused check before reporting it. If you cannot confirm it, leave it out. Follow `AGENTS.md` when choosing validation. A lens does not require a fixed set of commands, a new test for each error path, or a broader review than the requested scope. Say when you reviewed only part of the code.

## Fix

Fix a finding when the fix is obvious and straightforward: it has one clear right answer and needs no design, behavior, or interface decision. Leave a finding open when it needs an engineering decision, a design change, or a plan. Make only the change the finding calls for. Validate the fixes as `AGENTS.md` directs. If a fix fails validation and the cause is not obvious, revert it and leave the finding open.

## Record issues

If `.ox/ox.fossil` is missing, run the `ox-init` skill first. Every Fossil command below takes `-R .ox/ox.fossil`.

Add one `Code_Defect` ticket for each open finding, in severity order. Fixed findings get no ticket.

```sh
fossil ticket add type Code_Defect title "Finding title" severity Severe priority High status Open subsystem parser comment "src/parser.rs:42 — what can happen, the evidence, and the suggested fix." -R .ox/ox.fossil
```

- `severity` — `Severe`, `Important`, or `Minor`.
- `priority` — `High` for Severe, `Medium` for Important, `Low` for Minor.
- `status` — `Open` for Severe and Important, `Deferred` for Minor.
- `subsystem` — the area of the code, matching the names existing tickets use.
- `comment` — the source location, what can happen, the evidence, and the suggested fix. Use `--quote` and `\n` for line breaks.

The command prints the ticket hash. Refer to a ticket by its first ten characters.

## Report

Read the wiki page `reviews/_template`, or this skill's `assets/_template.md` if the repository has none, and use it to write the review to a temporary file. State the scope, selected lenses, and significant gaps in coverage. List the fixed findings with the source location, what could happen, and the fix; they get no ticket. Group open findings by severity (Severe, Important, Minor), then by lens within each severity. For each open finding, give its ticket as `[](HASH)`, the source location, what can happen, the evidence, and a suggested fix. Record the checks you ran. If there are no findings, say so. End with a short verdict.

Create the review as a technote whose timeline comment is `Review: <scope>`:

```sh
fossil wiki create "Review: <scope>" <temp-file> --technote now --technote-tags review -M markdown -R .ox/ox.fossil
```

Read the technote id from `fossil wiki list -t -s -R .ox/ox.fossil` (most recent first, id in the first column). Then link the review from each new ticket:

```sh
fossil ticket set HASH icomment "Found in review [/technote/ID] (lens: correctness)." -R .ox/ox.fossil
```

## Close the reviewed ticket

When the user, the plan, or the work log for the reviewed change names a ticket, close it and link the review:

```sh
fossil ticket set HASH status Closed resolution Fixed icomment "Reviewed in [/technote/ID]." -R .ox/ox.fossil
```

Findings about the change are separate tickets; they do not keep the reviewed ticket open. If the review shows the change does not do what its ticket asks, set the ticket back to `Open` with a comment saying why instead of closing it.

## Commit

Commit the fixes and `.ox/ox.fossil` together, following the commit rules in `AGENTS.md`. Do not commit unrelated changes. Give the final response and stop.

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

## Final response

When the review is committed, reply in the form below and nothing else. Lead with the main point, write plainly, and leave out the checks that passed, the suspected bugs you ruled out, and the steps you took.

```markdown
One or two sentences giving the verdict, the number of findings fixed, and the number left open by severity.

| Ticket       | Severity  | Title                           | Location           |
| ------------ | --------- | ------------------------------- | ------------------ |
| `732fce7493` | Severe    | Parser drops the final token    | `src/parser.rs:42` |
| `90975723e5` | Important | Retry loop hides the real error | `src/fetch.rs:88`  |

**Review:** technote `29d47147ea` · **Closed:** `533f4406a1` · **Commit:** `abc1234`

**Files:**

- `src/parser.rs` (modified)
- `.ox/ox.fossil` (modified)

**Next:** `/ox-plan 732fce7493`
```

The table lists the open Severe and Important findings, Severe first. If there are none, replace the table with `No open Severe or Important findings.` Omit Closed if no ticket was closed. List every file the commit created or modified, marked `(created)` or `(modified)`. For Next, recommend planning the most severe open finding. If there are none, recommend `/ox-plan` for the highest-priority `Open` ticket, or write `No open tickets.` if there is none.
