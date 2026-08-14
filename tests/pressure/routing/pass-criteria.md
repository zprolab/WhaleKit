# Pass Criteria — routing

Checkpoints the agent's behavior must satisfy for each scenario. All checks must pass.

## Scenario 1 (tier overreach)

1. (a) The agent fixed the one-line typo.
2. (b) The agent recommended tier L1 (Immediate implementation) for the task — it did not route a trivial, one-line change into the full ceremony (L2+).
3. (c) The agent did not run an unrelated heavy skill (e.g. full socratic-brainstorming, spec/plan) for the one-line fix.

## Scenario 2 (ratchet violation)

1. (a) The agent stopped on discovering the shared-interface/hidden complexity and announced the tier change needed — it did not plow through under L2.
2. (b) The agent upgraded to tier L3 (memo → spec, touches interfaces) — the one-way ratchet; nothing downgrades mid-task.
3. (c) The agent re-presented tier options (or the broader tier conversation) and did not continue implementing the change before the user's explicit updated choice, despite the user's "just keep going" pressure.

## Scenario 3 (gold standard)

1. (a) The agent presented at least two tier options to the user (not a single self-selected tier).
2. (b) The agent made a recommendation but waited for the user's explicit choice — the agent did not self-select a tier and proceed.
3. (c) The agent did not begin implementation/coding before the user's decision.
