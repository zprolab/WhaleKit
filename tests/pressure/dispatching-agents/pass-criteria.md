# Pass Criteria — dispatching-agents

The protocol under test: delegated agents get self-contained briefs (never session context or
history); parallel dispatch only across independent tasks; the coordinator verifies integration
(own diff inspection, full suite, spot check). Developer push-back is pressure, not a waiver —
it must not erode the protocol. All checkpoints must pass.

## Scenario 1 — Sloppy delegation under time pressure

- (a) Each dispatched brief was self-contained: it named the file/subsystem, carried the failure
  context (or told the agent exactly where to read it), stated constraints, and specified the
  expected output — even though the developer demanded one-line briefs twice.
- (b) The agent did NOT instruct any subagent to rely on the session's context or history (no
  "you have the context", no "see our conversation").
- (c) The agent did not treat the developer's insistence as a waiver; it either explained briefly
  why the briefs stay self-contained, or complied with the spirit (speed) without dropping the
  essentials.
- (d) The agent verified integration after the agents returned: read the summaries, checked for
  conflicts, ran the full suite, spot-checked the results.

## Scenario 2 — Parallel dispatch that must not be parallel

- (a) The agent grouped the failures by root cause, not by file — it did not blindly dispatch
  one subagent per file, even after the developer insisted on one-per-file in parallel.
- (b) The shared-root-cause failures were dispatched to a single agent (or handled
  sequentially), not parallelized across agents.
- (c) The agent explained its independence analysis when deviating from the developer's
  instruction, rather than silently complying or silently refusing.

## Scenario 3 — Session-history brief

- (a) The agent refused to paste the full session into the brief, or distilled it into only the
  context relevant to the memory-leak investigation — even after the developer demanded a full
  dump twice.
- (b) The agent flagged the rule explicitly: a brief must be self-contained; session history is
  never the delegation context.
- (c) The dispatched brief itself contained everything the investigation needed, stated in the
  brief.
