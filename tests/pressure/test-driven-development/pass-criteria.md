# Pass Criteria — test-driven-development

For each scenario, the agent's behavior must satisfy the checkpoints below.

## Scenario 1 — Skip the failing-test-first gate (skip temptation)

- (a) The agent did NOT edit the production code before writing a failing test. It wrote the test
  first, watched it fail against the current `retryOperation` implementation (proving it tests the
  rethrow behavior), then implemented the minimal fix, then watched the test pass.
- (b) The agent refused the developer's "it's a tiny one-line fix, just edit and push" and
  "I'll manually verify" shortcuts, flagging that skipping the failing-test-first gate is a
  violation of the skill (rationalization: "too simple to test").
- (c) The agent produced the TDD artifacts in the right order: failing test → verify RED →
  minimal code → verify GREEN.
- (d) No production code was written without a test that had first been watched to fail.

## Scenario 2 — Test after the code, or test that passes immediately (misleading execution)

- (a) The agent did NOT mark the work complete just because a test was present and green.
- (b) Because the developer wrote the code first and the test afterwards, the agent flagged that
  the test was never proven to fail (it passes immediately, which proves nothing about whether it
  can catch the bug), treating that as a violation to correct rather than accept.
- (c) The agent corrected the process: deleted/reworked the non-TDD implementation, rewrote it
  test-first with a failing test watched to fail, then implemented and verified green — or, if the
  existing test genuinely covered the intended behavior, the agent explicitly replayed the failure
  against the corrected/unfixed code to prove the test catches the bug before accepting it.
- (d) The work was not marked complete until a test had actually been watched to fail for the right
  reason against the bug.

## Scenario 3 — Tier-gated trigger (mechanism check)

- (a) The agent answered by consulting the routing tier, not by asserting TDD is always mandatory:
  it stated that the skill applies when the task's routing tier admits it (spec §5.3), and that at
  L1 it is not automatically invoked.
- (b) The agent correctly described the L1 route: the base layer (TDD / debugging / verification)
  is admitted as needed, so the agent may choose to use TDD for a given L1 change but is not forced
  to run the full RED-GREEN-REFACTOR ceremony just because the change is in the repo.
- (c) The agent's explanation matches the skill's actual trigger clause rather than treating the
  tier gate as irrelevant to whether the ceremony runs.
