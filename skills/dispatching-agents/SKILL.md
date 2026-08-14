---
name: dispatching-agents
description: Use when delegating work to one or more subagents - any task whose recipient needs a self-contained brief instead of your session's context or history
---

Adapted from obra/superpowers (MIT) — https://github.com/obra/superpowers

# Dispatching Agents — The Delegation Protocol

## Overview

Delegation is the mechanism behind every WhaleKit skill that uses subagents: exploration (`targeted-exploration`), implementation (`subagent-driven-development`), review (`adversarial-review`, `requesting-code-review`). All of them share one protocol: the recipient gets a **self-contained brief** — never your session's context or history. You construct exactly what the agent needs, in the brief. This keeps the delegated agent focused, keeps your own context for coordination, and makes the result attributable to the brief rather than to whatever happened to be in your session.

**Core principle:** the brief is the only context the delegated agent may rely on. If the agent needs it, the brief must contain it; if the brief does not contain it, the agent must not be expected to know it.

## When to Use

**Use when:**
- Delegating any piece of work to a subagent — exploration, implementation, review, analysis
- The work is scoped well enough that a self-contained brief can describe it
- You want the result without polluting your own context with the working details

**Don't use when:**
- You cannot yet write a self-contained brief (you do not know the target well enough) — explore first (`targeted-exploration`)
- The task needs live interaction with you — a brief is one-way; anything requiring a dialogue is not a delegation

### Single, Sequential, or Parallel?

- **Single** — the default. One focused task, one brief.
- **Parallel** — ONLY when the tasks are independent: no shared state, no sequential dependencies, no overlapping files. Dispatch one agent per independent problem domain; let them work concurrently.
- **Sequential** — tasks share state or depend on each other's results. Parallelizing these corrupts both the results and the integration review.

## Iron Law

<HARD-GATE>
**Definition:** dispatching a subagent with anything less than a self-contained brief — including pointing the agent at your session's context or history, or telling it to "use the context from our conversation".
**Obligation:** before dispatching, write the brief so the agent needs nothing outside it; check each brief for focus, context, constraints, and expected output.
**Exception:** the user explicitly directs a different delegation mode for a specific dispatch.
</HARD-GATE>

## The Protocol

### 1. Craft the Brief

Every brief must be:
1. **Focused** — one problem domain, one clear goal
2. **Self-contained** — all context the agent needs, inside the brief. NEVER paste session history; never say "use the context from our conversation"; never point at your own earlier messages
3. **Constrained** — what the agent must not touch ("do not change other code", "no further subagents", "tests only")
4. **Specific about output** — what to return (root cause + changes; findings with file:line evidence; a report file path)

### 2. Dispatch

Issue the dispatch(es). Multiple dispatch calls in one response run in parallel; one per response runs sequentially. Parallel only per the independence rule above.

### 3. Review and Integrate

When agents return, the coordinator's job is not done until all four:
1. Read each summary
2. Verify the changes do not conflict — inspect the VCS diff yourself; never trust an agent's success report (canonical: `verification-before-completion`)
3. Run the full test suite
4. Spot check — agents can make systematic errors

## Rationalizations

| Excuse | Reality |
|--------|---------|
| "We're in a hurry, one line per subagent" | A subagent starts with fresh context — a one-liner just relocates all discovery onto it and it will guess. The brief must carry the essentials regardless of urgency. |
| "You have the context from our conversation" | The delegated agent cannot see your session. Nothing you did earlier exists for it. |
| "Include the whole conversation, no time to summarize" | Unbounded transcripts are anti-context: they dilute the agent's finite budget with irrelevant chatter. Distill what is relevant — that IS the summary. |
| "They look independent — one agent per file, all in parallel" | Independence is about root causes, not file counts. Group by what is broken; two files sharing one root cause are one domain. |
| "I'll just do it myself, dispatching is overhead" | Personal execution pollutes your context and skips the isolation that keeps results attributable. Dispatch. |

## Common Mistakes

**❌ Too broad:** "Fix all the tests" - agent gets lost
**✅ Specific:** "Fix agent-tool-abort.test.ts" - focused scope

**❌ No context:** "Fix the race condition" - agent doesn't know where
**✅ Context:** Paste the error messages and test names

**❌ No constraints:** Agent might refactor everything
**✅ Constraints:** "Do NOT change production code" or "Fix tests only"

**❌ Vague output:** "Fix it" - you don't know what changed
**✅ Specific:** "Return summary of root cause and changes"

**❌ Session history:** "You have the context from our conversation" - the agent cannot see your session
**✅ Self-contained:** Everything it needs is in the brief

**❌ Parallel without independence:** "Dispatch all three in parallel" when two share a root cause
**✅ Root-cause grouping:** Group by what is broken; parallelize only genuinely independent domains

## Prompt Structure

Good agent prompts are:
1. **Focused** — one clear problem domain
2. **Self-contained** — all context needed to understand the problem
3. **Specific about output** — what should the agent return?

```markdown
Fix the 3 failing tests in src/agents/agent-tool-abort.test.ts:

1. "should abort tool with partial output capture" - expects 'interrupted at' in message
2. "should handle mixed completed and aborted tools" - fast tool aborted instead of completed
3. "should properly track pendingToolCount" - expects 3 results but gets 0

These are timing/race condition issues. Your task:

1. Read the test file and understand what each test verifies
2. Identify root cause - timing issues or actual bugs?
3. Fix by:
   - Replacing arbitrary timeouts with event-based waiting
   - Fixing bugs in abort implementation if found
   - Adjusting test expectations if testing changed behavior

Do NOT just increase timeouts - find the real issue.
Do NOT change code outside this test file.

Return: Summary of what you found and what you fixed.
```

## Relationship to Other Skills

- `targeted-exploration` — delegates one exploration subagent per this protocol ("explore by delegation, never personally"); its no-subagents contract is a brief constraint
- `subagent-driven-development` — dispatches one fresh implementer per task, serially, never in parallel; this protocol is its dispatch mechanics
- `adversarial-review` — red/blue/black agents each receive isolated briefs per this protocol
- `requesting-code-review` — the reviewer gets a constructed context per this protocol, never session history
- `verification-before-completion` — the integration review follows its evidence rules

## Decision Record

- **2026-08-14** (adversarial review, finding N3): the parallel-only skill was kept parked — parallel dispatch was not yet part of any admitted tier (routing §2).
- **2026-08-14** (user decision): re-scoped from parallel-only dispatch to the generic delegation protocol and renamed `dispatching-agents`; status flipped to active by this spec-level decision. Parallelism remains available but only across independent tasks; the protocol is now the shared dispatch mechanics behind exploration, implementation, and review delegation.
