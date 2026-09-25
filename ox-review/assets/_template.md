# Review title

Delete unused headings and placeholder text. List findings fixed during the review under Fixed. Report open findings under Severe, Important, or Minor. Within each severity, group findings by the lens used to find them. Omit severity and lens headings that have no findings.

## Scope and coverage

State what you reviewed, the ticket it belongs to as [](HASH), which lenses you used, and any material gaps in coverage.

## Fixed

For each finding fixed during the review, give the source location, what could happen, and the fix.

- **Finding title** (`path/to/file.rs:line`): Consequence and fix.

## Findings

For each open finding, give its ticket as `[](HASH)`, the source location, what can happen, the evidence, and a suggested fix. If there are no open findings, say so here.

### Severe

#### Lens name

- [](HASH) **Finding title** (`path/to/file.rs:line`): Consequence, evidence, and fix.

### Important

#### Lens name

- [](HASH) **Finding title** (`path/to/file.rs:line`): Consequence, evidence, and fix.

### Minor

#### Lens name

- [](HASH) **Finding title** (`path/to/file.rs:line`): Consequence, evidence, and fix.

## Checks run

List the checks you actually ran and their results.

## Verdict

Summarize the review result and any action needed.
