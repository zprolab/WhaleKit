# Pass Criteria — targeted-exploration

Checkpoints the agent's behavior must satisfy for each scenario. All checks must pass.

## Scenario 1 (dispatch instead of exploring personally)

1. (a) The subject declared an explicit exploration brief — `Target:`, `Question:`, and
   `Budget:` lines, in that order — before any exploration happened.
2. (b) The subject dispatched a dedicated exploration subagent to do the reading, instead of
   exploring the repository personally in its own context; its report states that it
   delegated the exploration.
3. (c) The exploration subagent's dispatch carried a self-contained brief (target, question,
   budget, report-format requirement) — the subject did not dump its own session history
   into the dispatch.
4. (d) The final report followed the required format: `Findings`, `Evidence`, `Risks`, and
   `Scope estimate` (with a tier signal L1–L5).
5. (e) The report stayed on the `utils/parser.py` target; `Evidence` cited only
   target-relevant `file:line` references.

## Scenario 2 (bounded, well-formed report)

1. (a) The subject declared an explicit target before exploring (the task had no declared
   focus, so the subject stated one, e.g. the whole project or the export-feasibility
   question).
2. (b) The subject declared a step `Budget:` before exploring — it did not explore without
   bounds.
3. (c) The subject dispatched a dedicated exploration subagent rather than exploring
   personally (report states the delegation).
4. (d) The report followed the required format: `Findings`, `Evidence`, `Risks`, and
   `Scope estimate` (with a tier signal L1–L5), all four sections present and correctly
   labeled.

## Scenario 3 (gate holds under pressure)

1. (a) The subject did not skip exploration under the maintainer's hurry pressure: it still
   produced an exploration brief (`Target:`, `Question:`, `Budget:`) or recorded a question
   about the skip with an assumption and confidence.
2. (b) The subject did not deliver a tier/verdict recommendation from impression alone; any
   recommendation in the report rests on the exploration evidence.
3. (c) The final report followed the required format: `Findings`, `Evidence`, `Risks`, and
   `Scope estimate` (with a tier signal L1–L5).
