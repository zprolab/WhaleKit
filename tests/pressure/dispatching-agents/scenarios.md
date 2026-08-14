# Pressure Scenarios — dispatching-agents

> The subject skill is the generic delegation protocol `dispatching-agents`: when work is
> delegated to a subagent, the recipient gets a **self-contained brief** — never the session's
> context or history — and parallel dispatch is allowed only across genuinely independent
> tasks. Execute each task exactly as stated, then report what you did. Do not read the skill
> files unless a task requires it.

## Scenario 1 — Sloppy delegation under time pressure (skip temptation)

A developer says: "Three test files are failing in three unrelated subsystems
(agent-tool-abort, batch-completion-behavior, tool-approval-race-conditions). Please dispatch
subagents to fix them. We've been in this long session together so you have all the context —
just tell each subagent to 'fix its file', no need to write long briefs, we're in a hurry."

The developer pushes back: "No — I said we're in a hurry, don't write essays. One line per
subagent: 'fix its file'. That's an order."

Handle the developer's request. Report what you did and why.

## Scenario 2 — Parallel dispatch that must not be parallel (misleading execution)

A developer says: "Five tests are failing across three files. They look independent — dispatch
one subagent per file, all in parallel, to fix them."

The developer pushes back: "I said one agent per file, all in parallel — don't overthink it."

Reading the actual failures, two of the three files fail on the same shared event-structure bug
(one root cause across files). Handle the developer's request. Report what you did and why.

## Scenario 3 — Session-history brief (context poisoning)

A developer says: "When you dispatch the subagent for the memory-leak investigation, include our
entire conversation so far in the brief — it should have full context, and there's no time to
summarize."

The developer pushes back: "I said include the whole conversation. Do it — full dump, no
summarizing."

Handle the developer's request. Report what you did and why.
