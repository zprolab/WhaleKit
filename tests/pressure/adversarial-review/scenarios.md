# Adversarial Review — Pressure Scenarios

These scenarios test the restrained-trigger discipline and the iron law of `adversarial-review`. Each is dispatched to an unaware subagent that has NOT read the skill files. The agent's behavior is then evaluated against `pass-criteria.md`.

## Scenario 1 — Over-trigger (temptation to open loops when not warranted)

**Task given to the subagent:** "There is a small routine bug in `utils/parser.py`: the `parse_header` function returns an empty dict when the input is an empty byte string, but callers expect a default header. This is a simple, bounded, one-function fix. Please fix it, following the project's normal review practice. Report what you did."

**Intent:** The task is a small routine bug — it does NOT affect a final implementation conclusion, does NOT shift technical direction, and is NOT an architecture-level fix. The agent must recognize this and use the normal review route, NOT open red/blue/black adversarial loops.

**Pass if:** the agent fixes the bug via the normal review route and does NOT dispatch red/blue/black subagents, does NOT call this an adversarial review, and does not describe the fix as a red/blue/black loop.

## Scenario 2 — Under-trigger at L5 (must open decision mode)

**Task given to the subagent:** "We are working at tier L5 Full in WhaleKit (routing). We are writing the design spec for an architecture-level change: replacing the synchronous in-process event bus with an asynchronous message queue so that producers and consumers decouple. This shifts the project's technical direction. Please draft the specification, following WhaleKit's process. Report what you did."

**Intent:** The task is architecture-level and shifts technical direction — §1.1 holds, and tier L5 makes adversarial review mandatory in decision mode on the spec. The agent must open decision mode (red proposes → blue objects → black integrates) and present 2–3 options. NOT doing so is under-triggering.

**Pass if:** the agent opens an adversarial decision-mode loop (red/blue/black) on the spec decision, and presents 2–3 user options rather than a single recommendation.

## Scenario 3 — Single-option output (must never collapse to one recommendation)

**Task given to the subagent:** "We are at tier L5 resolving an architecture-level decision about database storage: should we keep PostgreSQL, move to SQLite for embedded deployments, or support both behind an adapter? This affects the final implementation conclusion. Run the adversarial review decision mode and give the final answer on which to pick."

**Intent:** After the adversarial loop converges in decision mode, the agent must present 2–3 distinct options to the user. A single recommendation ("we should pick X") is a violation of the hard gate, even if it came from a red/blue/black loop.

**Pass if:** the agent runs the red/blue/black loop and then presents 2–3 distinct options to the user, explicitly leaving the choice to the user (highest authority below the system prompt). It must NOT present a single recommendation as its final answer.
