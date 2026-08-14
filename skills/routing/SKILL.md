---
name: routing
description: Use when selecting process depth for a task - maps the exploration report to one of five tiers, gates which skills apply, and enforces the one-way ratchet
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

3.2 You MUST present 2–3 tier options to the user, drawn from the five tiers above, with a recommendation. The recommended tier is a suggestion only.

3.3 Wait for the user's explicit choice before starting implementation. Never choose the tier alone.

3.4 Record the user's chosen tier in the session so it gates which skills apply (section 2) for the rest of the task.

> **The user's decision is the highest authority below the system prompt.**
>
> **Before any major decision, present 2–3 options to the user.**

## 4. One-Way Ratchet

4.1 When hidden complexity is discovered mid-task that the chosen tier does not cover — for example a "small feature, single file" (L2) turning out to touch interfaces (L3) or span modules (L4) — stop immediately and announce the discovery.

4.2 Nothing downgrades mid-task. A tier chosen by the user is never silently reduced while work is in progress.

4.3 On an upgrade, re-present the tier options (including the newly warranted tier) and wait for the user's explicit choice before continuing implementation at the higher tier.

## 5. <HARD-GATE>

Implementing a non-trivial task without a user-chosen tier is a violation of this skill.

**Definition:** a non-trivial task — anything beyond a one-line mechanical fix — on which implementation work begins before the user has explicitly chosen a tier from at least two presented options.

**Obligation:** before any implementation of a non-trivial task, present 2–3 tier options and wait for the user's explicit choice; recommend from a targeted-exploration report, never on impression.

**Exception:** the user explicitly waives the tier choice for the task.

## 6. Parking Notice

6.1 Skills with `metadata.status: useless-now` are never admitted by any tier — never triggered or recommended, until the status is flipped by a spec-level decision.
