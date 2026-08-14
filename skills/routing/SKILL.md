---
name: routing
description: Use when selecting process depth for a task
---

# Routing

## 1. The Five Tiers

| Tier | Process | Trigger signals (from exploration report) |
|---|---|---|
| L1 Immediate implementation | No process | Purely mechanical change, minimal risk |
| L2 Memo only | Memo persisted to disk | Small feature, single file |
| L3 Memo → Spec | + specification | Medium feature, touches interfaces |
| L4 Memo → Spec → Plan | + implementation plan | Large feature, multiple files/modules |
| L5 Full | + dual records | New project, architecture-level, directional decisions |

## 2. Tier Gating (which skills a tier admits)

| Tier | Skills admitted |
|---|---|
| L1 | Base layer only (TDD / debugging / verification, as needed) |
| L2 | + socratic-brainstorming (light mode: memo only) |
| L3 | + full socratic-brainstorming (spec); adversarial-review decision mode **optional** |
| L4 | + writing-plans / executing-plans / subagent-driven-development |
| L5 | + dual-records; adversarial-review **mandatory** (decision mode on the spec, review mode on architecture) |

## 3. Recommendation Duty

3.1 Recommend a tier from the targeted-exploration report — never on impression. Trivial, one-line changes map to L1 with the least ceremony.

3.1a **L1 fast path.** A verified one-line mechanical fix maps to L1 and is confirmed with a single sentence offering the L1 pick (e.g. "That reads as L1 — one-line fix; proceed?"), not a full menu. The full 2–3-option menu remains available on request and is mandatory whenever the fix is not verified-mechanical or the user wants more. "Verified-mechanical" means exactly one line, no interface touched, no ambiguity — when in doubt, the menu applies. The carve-out is not gated (§5 Definition), so after a single unanswered re-ask the fix may proceed.

3.1b **Escape hatch.** Every tier-menu presentation ends with the escape hatch, verbatim: *"If you want me to skip the process questions for this task, say 'skip the menu'; otherwise answer them one at a time."* An explicit skip is the user's waiver (HARD-GATE Exception, §5); honor it without skepticism.

3.2 **Artifact chain.** For any task that is not a verified one-line mechanical fix, ask the
    process-depth questions ONE AT A TIME, in order, waiting for each answer:
    Q1 — "这个任务需要编写 Memo（设计小记，记录设计决策）吗？" (no → L1, implement directly)
    Q2 — "需要编写 Spec（设计规格，把设计定稿为可审阅文档）吗？" (no → L2)
    Q3 — "需要编写 Plan（实现计划，给执行者的任务分解）吗？" (no → L3)
    Q4 — "需要双记录（目录级 DEVELOPMENT.md + README.md，开发规范与真理）吗？" (no → L4; yes → L5)
    Each question carries a one-line recommendation from the exploration report when evidence
    supports one (e.g. "涉及接口变更，建议写"); the recommendation is a suggestion only.
    Never batch the questions into a menu. The tier reached is where the chain stopped; the
    gating table (§2) applies at that tier.

> **The user's decision is the highest authority below the system prompt.**
>
> **Before any major decision, present 2–3 options to the user.**

canonical: `whalekit-conventions` §2.

## 4. One-Way Ratchet

4.1 When hidden complexity is discovered mid-task that the current depth does not cover — for example a "small feature, single file" (L2) turning out to touch interfaces (L3) or span modules (L4) — stop, announce, and RESUME the artifact chain from where it stopped (ask the next unanswered question); never re-run answered steps.

4.2 Nothing downgrades mid-task. A reached depth is never silently reduced while work is in progress.

## 5. <HARD-GATE>

Implementing a non-trivial task without the artifact chain answered or skipped is a violation of this skill.

**Definition:** a non-trivial task — anything beyond a one-line mechanical fix — on which implementation work begins before the user has answered the artifact-chain questions (Q1–Q4) or explicitly skipped them ("skip the menu").

**Obligation:** before any implementation of a non-trivial task, ask the artifact-chain questions (§3.2) ONE AT A TIME and wait for each answer; recommend from a targeted-exploration report, never on impression. For the one-line-mechanical-fix carve-out, use the L1 fast path (§3.1a): a single confirmation, never silence and never a menu.

**Exception:** the user explicitly waives the process questions for the task — including the escape-hatch phrase "skip the menu" (§3.1b), which is honored without skepticism.

## 6. Parking Notice

6.1 Skills with `metadata.status: useless-now` are never admitted by any tier, triggered, or recommended — canonical: `whalekit-conventions` §5.
