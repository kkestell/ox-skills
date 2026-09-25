# Simplicity

- Find changes that leave less code and fewer concepts to understand while preserving required behavior. Prefer deleting concepts, representations, and branches over shortening syntax or introducing abstractions.
- Report defensive code for cases that cannot happen in practice, configuration or extensibility with a single use, and reinvented facilities the platform or a dependency already provides as code to remove.
- Current contracts and tests can encode incidental implementation choices; surface those choices for reconsideration rather than using them to dismiss a simplification.
- Separate behavior-preserving simplification from proposals that require a design decision. Do not manufacture findings or present unverified line savings as measured reductions.
