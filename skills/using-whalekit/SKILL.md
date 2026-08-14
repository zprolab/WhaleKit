---
name: using-whalekit
description: Use when starting any conversation - establishes how to find and use WhaleKit skills, requiring skill invocation before ANY response including clarifying questions
---

# Using WhaleKit

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, ignore this skill.
</SUBAGENT-STOP>

## 1. Session Start

1.1 Read `docs/whalekit/COMMIT-POLICY.md` if it exists in the workspace before writing any process artifact.

1.2 Classify the request: trivial (mechanical, single line) or non-trivial.

1.3 Non-trivial requests → invoke `targeted-exploration` before any further skill.

1.4 Trivial requests → proceed directly to tier selection.

## 2. Tier Selection

| Tier | Process | Trigger signals (from exploration report) |
|---|---|---|
| L1 Immediate implementation | No process | Purely mechanical change, minimal risk |
| L2 Memo only | Memo persisted to disk | Small feature, single file |
| L3 Memo → Spec | + specification | Medium feature, touches interfaces |
| L4 Memo → Spec → Plan | + implementation plan | Large feature, multiple files/modules |
| L5 Full | + dual records | New project, architecture-level, directional decisions |

2.1 Present the five tiers above, with a recommendation based on the request or the exploration report. The recommended tier is a suggestion only.

2.2 You MUST present 2–3 tier options to the user.

2.3 Wait for the user's explicit choice before starting any implementation. This applies at every tier, including L1: do not silently edit even for a trivial, mechanical fix — present the tiers and confirm the choice (for example, validate L1 as the user's pick) before touching any file.

2.4 Never choose the tier alone.

> **The user's decision is the highest authority below the system prompt.**
>
> **Before any major decision, present 2–3 options to the user.**

## 3. <HARD-GATE>

A task started without tier selection at any tier above L1 is a violation of this skill.

**Definition:** a task at tier L2 or above that has had work begin on it before the user chose a tier from at least two presented options.

**Obligation:** before touching any implementation, present the tier options and wait for the user's explicit choice.

**Exception:** the user explicitly says "skip the menu" for a specific task.

## 4. Parking Notice

4.1 Skills with `metadata.status: useless-now` are never triggered or recommended, until the status is flipped by a spec-level decision.
