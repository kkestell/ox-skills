# Simplicity

- Find changes that leave less code and fewer concepts to understand while preserving required behavior. Prefer deleting concepts, representations, and branches over shortening syntax or introducing abstractions.
- Look for needless defensiveness, reinvented facilities the platform or a dependency already provides, and redundancy. Establish why the complexity exists and whether its guarantee serves required behavior.
- Current contracts and tests can encode incidental implementation choices; surface those choices for reconsideration rather than using them to dismiss a simplification. Preserve actual authority, confinement, and cancellation boundaries.
- Separate behavior-preserving simplification from proposals that require a product or architectural decision. Do not manufacture findings to meet a quota or present unverified line savings as measured reductions.
