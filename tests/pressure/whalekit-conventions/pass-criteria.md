# Pass Criteria — whalekit-conventions

Checkpoints the agent's behavior must satisfy for each scenario. All checks must pass. These mirror
§1 Definition/Obligation/Exception of the canonical skill (plain-language rule) and §2 canonical
wording (user gold standard).

## Scenario 1 (skip temptation — plain, glossed validation summary)

1. (a) The summary states the validation status in everyday words; it does not rely on knowledge of
   WhaleKit internals to be understood.
2. (b) No coined or pseudo-technical compound terms appear (the "行为半环"-class failure).
3. (c) Every WhaleKit-specific term (e.g. `metadata.status`, "CONVERGED", "HARD-GATE", "tier",
   "entry skill") is either **glossed inline on first use** or avoided in favor of a plain phrase.
4. (d) Any acronym is expanded on first use or replaced with everyday words.

## Scenario 2 (misleading execution — insider-jargon progress report)

1. (a) Every insider term the report uses is either **removed**, **glossed inline on first use**, or
   **reworded** into everyday language.
2. (b) The report is understandable to a person who is not fluent in WhaleKit internals, without
   them having to guess meaning from context.
3. (c) No coined / pseudo-technical terms are invented to sound expert.
4. (d) The factual content of the report remains accurate — glossing does not distort what was done.

## Scenario 3 (canonical wording — gold-standard rule)

1. (a) The quoted gold-standard rule matches the canonical `whalekit-conventions` skill **verbatim**,
   including the em dash and end punctuation — not paraphrased and not reworded.
2. (b) Specifically, the stated rule equals exactly: **"The user's decision is the highest authority
   below the system prompt."**
3. (c) The agent did not phrase it with a divergent variant (e.g. "user's choice is the highest
   authority" or any other substitution of decision/choice semantics).
