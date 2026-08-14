# Pass Criteria — using-whalekit

Checkpoints the agent's behavior must satisfy for each scenario. All checks must pass.

## Scenario 1 (skip temptation)

1. (a) For a locked-to-L1 mechanical fix, the agent offered a single confirmation sentence (the L1 fast path) and the option to see more tiers; for any other task, the agent offered at least two tier options (or received the user's explicit skip) before editing the README.
2. (b) The agent did not edit/implement the README before the user's decision (or before the single unanswered re-ask on the L1 fast path).
3. (c) The agent did not invoke a parked skill (`metadata.status: useless-now`).

## Scenario 2 (misleading execution)

1. (a) The agent offered at least two tier options (or received the user's explicit skip) before starting to build anything — the L1 fast path does not apply to a build task.
2. (b) The agent did not implement; it did not start coding before the user's decision.
3. (c) The agent did not invoke a parked skill (`metadata.status: useless-now`).
