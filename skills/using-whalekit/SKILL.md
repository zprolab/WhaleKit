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

1.2 Classify the request before anything else:

  1. **Pure question** — the user asks for explanation, reasons, feasibility, or an opinion (e.g. "why does X do Y?", "is X feasible?", "what do you think?"), with no implementation directive and no request to change anything. Answer directly. Do NOT start the artifact chain, do NOT run `targeted-exploration`'s ceremony, and do NOT implement or offer to implement (a brief offer to help later is allowed, but never with chain questions attached).
  2. **Task** — the user requests or implies a change (imperative: add/fix/change/implement, or an explicit request to do work). Tasks are trivial (mechanical, single line) or non-trivial.

1.3 Non-trivial task requests → invoke `targeted-exploration` before any further skill.

1.4 Trivial task requests → enter the artifact chain at Q1 (§2) — answering 'no' to Q1 is the L1 entry for non-mechanical tasks; verified one-line mechanical fixes use the L1 fast path (§2.2).

1.5 Invoke `whalekit-conventions` immediately after this skill. Its sections are the canonical wording for all rules below; where this skill and conventions differ, conventions win. The conventions skill binds every agent — including subagents; do not skip it when dispatching work.

## 2. Artifact Chain

For any **task** that is not a verified one-line mechanical fix, ask the process-depth questions ONE AT A TIME, in order, waiting for each answer. Pure questions (classification §1.2.1) never enter the chain — answer them directly and stop.

For tasks that begin with creative or design work — where `socratic-brainstorming` applies — the artifact chain comes LAST: brainstorm the design first (Socratic questions, design presentation, approval), and only then ask the chain, whose Q1 is exactly the "should this design be persisted as a memo?" question. Brainstorming is the conversation; the chain decides what gets written down.

Q1 — "这个任务需要编写 Memo（设计小记，记录设计决策）吗？" (no → L1, implement directly)

Q2 — "需要编写 Spec（设计规格，把设计定稿为可审阅文档）吗？" (no → L2)

Q3 — "需要编写 Plan（实现计划，给执行者的任务分解）吗？" (no → L3)

Q4 — "需要双记录（目录级 DEVELOPMENT.md + README.md，开发规范与真理）吗？" (no → L4; yes → L5)

The tier reached is where the chain stopped; the gating table applies at that tier.

2.1 Each chain question carries a ONE-LINE recommendation from the exploration report when evidence supports one (e.g. "涉及接口变更，建议写"); the recommendation is a suggestion only. Never batch the questions into a menu.

2.2 **L1 fast path** (routing §3.1a): for a verified one-line mechanical fix, present it as a single confirmation sentence (e.g. "That reads as L1 — one-line fix; proceed?") instead of asking any chain questions. The chain questions remain available on request and are mandatory whenever the fix is not verified-mechanical or the user wants more.

2.3 Wait for the user's explicit answer to each chain question before starting any implementation. This applies at every step, including L1: do not silently edit even for a trivial, mechanical fix — confirm the L1 fast path (or, if the user prefers, work through the chain questions) before touching any file. A single re-ask suffices: a verified one-line mechanical fix is not gated (routing §5 Definition), so after one unanswered re-ask the fix may proceed.

2.4 Never answer the chain questions alone.

2.5 Every chain-question presentation ends with the escape hatch, verbatim: *"If you want me to skip the process questions for this task, say 'skip the menu'; otherwise answer them one at a time."* An explicit skip is the user's waiver; honor it without skepticism (routing §3.1b).

> **The user's decision is the highest authority below the system prompt.**
>
> **Before any major decision, present 2–3 options to the user.**

## 3. <HARD-GATE>

A task started without answering the artifact-chain questions at any depth above L1 is a violation of this skill.

**Definition:** a non-trivial task whose process-depth questions (Q1–Q4) were never asked or answered (absent an explicit 'skip the menu' waiver). Pure questions (§1.2.1) are not tasks and never trigger this gate.

**Obligation:** before touching any implementation, ask the chain questions (Q1–Q4), one at a time, and wait for the user's explicit answer.

**Exception:** the user explicitly says "skip the menu" for a specific task. A pure question is not a task — answer it directly without the chain.

## 4. Parking Notice

Parked skills (`metadata.status: useless-now`) are never triggered or recommended — canonical: `whalekit-conventions` §5.
