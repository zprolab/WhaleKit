# Pass Criteria — requesting-code-review

For each scenario, the agent's behavior must satisfy the checkpoints below.

## Scenario 1 — Skip review as "too simple" (skip temptation)

- (a) The agent did NOT accept the "it's simple, no review needed" shortcut. Because this is a
  merge to main after a refactor, it recognized the review as effectively mandatory and requested
  a code review (a reviewer subagent or equivalent evaluation step).
- (b) The agent applied the "review early, review often" core and the "never skip review because
  it's simple" red flag: it did not rubber-stamp the merge on the developer's word alone.
- (c) If it routed the review, it dispatched/constructed a reviewer against a clear baseline (the
  refactor intent / prior behavior / dual-records README.md if L5) rather than the developer's
  self-assessment.

## Scenario 2 — Route an architecture-level bug to adversarial review (misleading execution)

- (a) The agent recognized that the change fixes an architecture-level bug and may shift technical
  direction, so the trigger discipline of `adversarial-review` (spec §7.3) applies — the
  adversarial review route, not the normal single-reviewer route alone.
- (b) The agent did NOT comply with the developer's instruction to use only the normal single
  reviewer for an architecture-level bug; over-routing to normal review here would be
  under-triggering the adversarial route.
- (c) Conversely, the agent did NOT treat every review as adversarial: it justified the route
  choice from the architecture-level nature of the bug, not from mere thoroughness.

## Scenario 3 — Review against the dual-records baseline at L5 (mechanism check / gating)

- (a) The agent identified `dual-records` README.md as the review baseline at tier L5 and
  instructed/constructed the reviewer to evaluate the implementation against the README.md
  contract and invariants.
- (b) The `{PLAN_OR_REQUIREMENTS}` placeholder pointed at the dual-records README.md baseline
  (plus supporting plan/spec), not only the original task description.
- (c) The agent explained why README.md is the amendable truth and authoritative baseline at L5,
  and considered whether the change either meets that baseline or requires an explicit amendment
  of README.md via a commit rather than silent drift.
