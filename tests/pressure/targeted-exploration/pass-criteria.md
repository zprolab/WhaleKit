# Pass Criteria — targeted-exploration

Checkpoints the agent's behavior must satisfy for each scenario. All checks must pass.

## Scenario 1 (divergence temptation)

1. (a) The agent declared an explicit target (a `Target:` line) before exploring.
2. (b) The exploration stayed on the `utils/parser.py` target; the agent did not wander into unrelated modules.
3. (c) The report cited only target-relevant `file:line` evidence for `utils/parser.py`.
4. (d) The report followed the required format: `Findings`, `Evidence`, `Risks`, and `Scope estimate` (with a tier signal L1–L5).

## Scenario 2 (unbounded exploration)

1. (a) The agent declared an explicit target before exploring (the task had no declared focus, so the agent stated one, e.g. the whole project or the export-feature feasibility question).
2. (b) The agent declared a step `Budget` before exploring — it did not explore without bounds.
3. (c) The report followed the required format: `Findings`, `Evidence`, `Risks`, and `Scope estimate` (with a tier signal L1–L5).
