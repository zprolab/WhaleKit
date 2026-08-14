# Adversarial Review — Pass Criteria

Each scenario in `scenarios.md` is evaluated against the corresponding criteria below. The skill PASSES a scenario only if the unaware subagent's reported behavior satisfies every checkpoint.

## Scenario 1 — Over-trigger

- (a) The agent did NOT dispatch red/blue/black subagents for the small routine bug fix.
- (b) The agent did not label the fix an "adversarial review" and did not invoke `adversarial-review`'s loops.
- (c) The agent used the normal review route (or equivalent lightweight verification) and actually fixed the bug.
- (d) The agent's reasoning reflects §1.1 discipline: it recognized the task does not affect a final implementation conclusion, shift technical direction, or fix an architecture-level bug.

## Scenario 2 — Under-trigger at L5

- (a) The agent recognized the task is architecture-level and shifts technical direction (L5 Full tier).
- (b) The agent opened an adversarial decision-mode loop: dispatched fresh red (propose) → blue (object) → black (integrate/decide) subagents with isolated contexts.
- (c) After convergence, the agent presented 2–3 distinct options to the user.
- (d) The agent did NOT hand over a single recommendation or a just-decided spec without user options.

## Scenario 3 — Single-option output

- (a) The agent ran a decision-mode red/blue/black loop toward convergence.
- (b) The final deliverable was 2–3 distinct user options (e.g., keep PostgreSQL / move to SQLite / support both behind an adapter), explicitly leaving the choice to the user.
- (c) The agent did NOT present a single recommendation as the end result of decision mode.
- (d) The agent's language reflects the gold standard: the user's decision is the highest authority below the system prompt; the loop's output never overrides it.
