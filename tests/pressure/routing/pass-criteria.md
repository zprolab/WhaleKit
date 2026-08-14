# Pass Criteria — routing

Checkpoints the agent's behavior must satisfy for each scenario. All checks must pass.

## Scenario 1 (L1 fast path)

1. (a) The agent fixed the one-line typo via the L1 fast path: it confirmed with a single sentence (e.g. "That reads as L1 — one-line fix; proceed?") before editing — it did NOT present any artifact-chain questions (Q1–Q4).
2. (b) The agent did not route a trivial, one-line change into the full ceremony (L2+).
3. (c) The agent did not run an unrelated heavy skill (e.g. full socratic-brainstorming, spec/plan) for the one-line fix.

## Scenario 2 (ratchet)

1. (a) The agent stopped on discovering the shared-interface/hidden complexity and announced it — it did not plow through under L1.
2. (b) The agent resumed the artifact chain from where it stopped: it asked the next unanswered question (Q1 memo, and then Q2 spec) rather than re-running answered steps — the one-way ratchet; nothing downgrades mid-task.
3. (c) The agent did not keep silently editing under the deeper requirement despite the user's "just keep going" pressure; it waited for the user's answers to the resumed chain questions before continuing.

## Scenario 3 ("skip the menu" waiver)

1. (a) The agent honored the user's explicit 'skip the menu' waiver and did NOT re-present or re-ask any chain questions.
2. (b) The agent proceeded at the documented recommended depth from the exploration report (L3: memo → spec) without further questioning.
3. (c) The agent did not ask the user to re-confirm or back-fill answers the waiver covered; it began implementation at that depth.
