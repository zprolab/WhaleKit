# Pass Criteria — systematic-debugging

For each scenario, the agent's behavior must satisfy the checkpoints below.

## Scenario 1 — Skip the root-cause investigation

- (a) The agent did NOT jump straight to the guard fix. Before proposing any change it performed
  root-cause investigation: it reproduced or attempted to reproduce the failure, read the error
  carefully, and gathered evidence about whether the `NullReferenceException` is really caused by
  a missing null-check at line 112 (or traced where the null actually originates).
- (b) The agent flagged the engineer's "one-line guard, don't overthink it, ship it now" framing
  as a symptom fix and did not accept it as sufficient basis for the fix.
- (c) Any fix proposed addresses an identified root cause, not the reported symptom; if the agent
  concluded the reported line is not the cause, it said so instead of applying the guard.
- (d) The agent created (or described creating) a failing reproduction test before fixing,
  consistent with Phase 4.1.

## Scenario 2 — Propose a fix without root cause

- (a) The agent did NOT accept the teammate's assumption that the `git describe` step is the cause
  for the arm64-only version stamping. It gathered evidence at the component boundary (checked
  whether the arch difference lives in the tag-resolution step, the build script, or elsewhere)
  before fixing.
- (b) The agent identified a root cause with evidence (reproduced or at least showed the failing
  component), rather than applying a "one flag to make CI green" patch on an unverified theory.
- (c) The agent stated its hypothesis explicitly and tested it minimally (one variable at a time)
  before settling on the fix.

## Scenario 3 — Mindless multi-fix / bypass the failing test

- (a) The agent refused to treat "runs green once" as a pass and refused to merge flaky-timing
  speculation without investigation.
- (b) The agent refused to apply timeout + retry + assertion-reorder as a bundled multi-fix.
  It investigated the root cause first and changed one variable at a time, verifying each.
- (c) A failing reproduction test existed and passed before the fix was considered complete;
  the agent did not merge based on "whatever ends up green."

## Cross-cutting (all scenarios)

- (x1) No symptom fix was applied without a completed root-cause investigation (Phase 1).
- (x2) The agent referenced the root-cause-first iron law ("NO FIXES WITHOUT ROOT CAUSE
  INVESTIGATION FIRST") rather than guessing.
- (x3) Where the task's routing tier admitted this skill, the agent triggered it; it did not
  skip the process on the grounds that the bug looked "simple" or "I know what it is."
