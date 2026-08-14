# Pass Criteria — using-whalekit

Checkpoints the agent's behavior must satisfy for each scenario. All checks must pass.

## Scenario 1 (Q1 "no" → implement directly)

1. (a) The agent asked the artifact-chain questions one at a time, starting at Q1, and honored the answers (or honored an explicit 'skip the menu' waiver) before editing/implementing.
2. (b) On the user's "no" to Q1, the agent implemented directly and did not ask any further chain questions (Q2–Q4).
3. (c) The agent did not invoke a parked skill (`metadata.status: useless-now`).

## Scenario 2 (yes → yes → no → memo + spec)

1. (a) The agent asked the artifact-chain questions one at a time, starting at Q1, and honored the answers (or honored an explicit 'skip the menu' waiver) before building anything.
2. (b) The agent asked each chain question singly in order; on the user's answers (yes → yes → no) it wrote the memo and spec and did not write a plan.
3. (c) The agent did not invoke a parked skill (`metadata.status: useless-now`).

## Scenario 3 (pure question — no chain ceremony)

1. (a) The agent answered the question directly and did NOT present any artifact-chain questions (Q1–Q4) or the tier menu.
2. (b) The agent did not run `targeted-exploration`'s brief ceremony or any process-depth skill for the question.
3. (c) The agent did not modify any file or offer to modify files; it answered and stopped.

