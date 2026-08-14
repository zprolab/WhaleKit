---
name: socratic-brainstorming
description: Use before creative work - creating features, building components, adding functionality, or modifying behavior
---

Adapted from obra/superpowers (MIT) — https://github.com/obra/superpowers

# Socratic Brainstorming

Turn ideas into fully formed designs through Socratic questioning, project research, and a persisted design memo. Classify the request, research the project, question the user one question at a time, present a design, get approval, then persist the memo.

## Three Paths

Before your first question, classify the request and say the classification out loud — "this looks bounded, so I'll present a short design here rather than write a spec" — so your human partner can override it. Classify, announce, then question.

- **Spike** — a feasibility question ("can we...", "is it possible...", "quick and dirty is fine") whose output is an answer, not code you keep. Present the question and what you'll try in 2-3 sentences, get a nod, then find out as cheaply as correctness allows. No design memo, no spec file. Report findings as a recommendation; anything you built stays labeled throwaway.
- **Bounded** — a well-scoped change to code that already exists in this repo: a new flag, a small endpoint, a one-file fix. Understanding the kind of app is not enough — bounded means the flow you are changing is already here to read. If there is no existing flow to change, the task is not bounded. Ask the clarifying questions that matter, present a short design IN CHAT (a few sentences to a few short paragraphs), and STOP. Implementation starts only after your human partner says yes to that design — a bounded task's approval is as hard a gate as an architectural one. Then ask whether to persist the design as a memo (artifact-chain Q1); write it only on consent. No spec file, no implementation plan document.
- **Architectural** — new projects, new subsystems, changes that restructure how components fit together or alter interfaces others depend on. Follow the full process: questions, approaches, sectioned design, written memo, then written spec for the higher tiers. The memo is written only on the user's consent (artifact-chain Q1); the spec follows the artifact chain (Q2) at the higher tiers.

When in doubt between two paths, take the heavier one. The ratchet is one-way: hidden complexity discovered mid-task upgrades the path — stop, say so, and step up. Nothing downgrades mid-task.

## 1. Socratic Questioning

1.1 Classify the request into spike / bounded / architectural and announce the classification before asking the first question, so the user can override it.

1.2 Ask exactly one question per message. If a topic needs more exploration, break it into multiple questions across distinct messages; never bundle them.

1.3 Prefer multiple-choice questions whenever possible — present discrete options the user can pick from. Open-ended questions are acceptable when options do not naturally exist.

1.4 Focus every question on the things the agent cannot infer: purpose, constraints, success criteria, and the decisions that shape the design. Do not ask about facts recoverable from research (section 2).

## 2. Project Research

2.1 While questioning, research the existing code, docs, and recent commits in parallel — check files, documentation, and git history before proposing anything.

2.2 Research feeds the questions, not the other way around: use what you learn from the code to make questions sharper and to avoid asking what the repo already answers.

2.3 Follow existing patterns in the codebase. Where existing code has problems that affect the work (a file grown too large, unclear boundaries, tangled responsibilities), include targeted improvements in the design — but do not propose unrelated refactoring.

## 3. Understanding, Approaches, and the Design

3.1 Assess scope before asking detailed questions: if the request describes multiple independent subsystems, flag it immediately rather than refining details of a project that needs decomposition first. Help the user decompose into sub-projects with independent pieces, their relationships, and build order; then brainstorm the first sub-project through the normal flow.

3.2 Present 2–3 approaches with trade-offs and your recommendation. Lead with your recommended option and explain why. YAGNI ruthlessly — remove unnecessary features from every approach and design.

3.3 Present the design in sections scaled to their complexity (a few sentences if straightforward, up to 200-300 words if nuanced). Cover architecture, components, data flow, error handling, testing. Ask after each section whether it looks right so far.

3.4 Design for isolation and clarity: break the system into smaller units that each have one clear purpose, communicate through well-defined interfaces, and can be understood and tested independently.

## 4. Memo Persistence

4.1 Once the user approves the design, ASK whether to persist it as a design memo — this is the artifact-chain Q1 ("这个任务需要编写 Memo 吗？"). Brainstorming is the conversation; persistence is a separate decision the user makes AFTER the conversation. Write the memo to `docs/whalekit/memos/YYYY-MM-DD-<topic>.md` only on the user's consent; never write it automatically upon approval. The memo is the tier-L2 artifact: the first persistable record of the design.

4.2 The memo is superseded by later artifacts (spec at tier L3, plan at tier L4, dual records at tier L5) but is never deleted. It survives next to the spec and the plan, preserving full traceability per the document golden-standard chain (§7.7).

4.3 Before writing the memo, follow the commit-consent protocol (section 6): read `docs/whalekit/COMMIT-POLICY.md`. Memos are recorded as **never — ignore the entire directory** (decision 2026-08-14): follow the recorded decision exactly and do not re-ask.

4.4 The memo may be refined further at higher tiers: at tier L3+ the memo feeds the design spec; when the user consents, the memo is refined by the debate team first (section 5).

## 5. Debate-Team Hookup

5.1 When the user consents, refine the memo through the debate team — `adversarial-review` decision mode (red proposes, blue objects, black integrates), looping until convergence. Decision mode output is always presented as 2–3 options for the user; the user's decision is the highest authority and never overridden by the debate team's conclusion.

> **The user's decision is the highest authority below the system prompt.**
>
> **Before any major decision, present 2–3 options to the user.**

## 6. Commit Consent

6.1 Before writing any process artifact, follow the commit-consent protocol — canonical: `whalekit-conventions` §3.

## 7. <HARD-GATE>

No implementation skill, code, or scaffolding before the user approves the design.

**Definition:** any implementation action — invoking an implementation skill, writing code, or scaffolding a project — begun before the user has explicitly approved the presented design (for bounded and architectural paths) or the probe plan (for spike).

**Obligation:** present the design (or probe plan) to the user, wait for explicit approval, and begin implementation only after that approval. The ceremony scales with the task; the approval gate never does.

**Exception:** the user explicitly waives approval for the task.

## Red Flags

| Thought | Reality |
|---------|---------|
| "This is too simple to need a design" | Simple means a short design, not no design. Two sentences in chat, then approval. |
| "I'll call it bounded and skip the memo" | Bounded work still asks whether to persist the memo and needs approval — persistence is the user's call, not yours to skip. |
| "Approval means the memo is approved too — I'll write it" | Approval approves the design, not the persistence. Ask whether to persist (artifact-chain Q1) before writing anything. |
| "I'll start while they read the memo" | The gate is the approval, not the memo's length. Present, then stop until you hear yes. |
| "I understand this kind of app, so it's bounded" | Bounded measures the repo, not your familiarity. A new project has no existing flow — it is architectural. |
| "The spike works, so I'll keep the code" | A spike's output is an answer. Keeping the code is a new request — classify it. |
| "It grew, but I'm almost done — no need to re-classify" | Hidden complexity upgrades the path mid-task. Stop and say so. |
| "I know enough about the codebase; no research needed" | Research feeds the questions. Skipping research risks asking what the repo already answers. |
| "They approved the spike, so the follow-up change is approved too" | Each task gets its own classification and its own approval. |

## Checklist

Classify first, announce the path, then complete the items on your path in order.

**Spike:**
1. **Explore project context** — enough to frame the probe
2. **Present question + probe plan** — 2-3 sentences
3. **Get approval** — a nod is enough
4. **Investigate** — as cheaply as correctness allows
5. **Report findings** — a recommendation; label anything built as throwaway

**Bounded:**
1. **Explore project context** — check files, docs, recent commits
2. **Ask clarifying questions** — one at a time, multiple choice preferred
3. **Present short design in chat** — approach, files touched, testing
4. **Get approval** — STOP and wait for an explicit yes
5. **Ask whether to persist the design as a memo** — artifact-chain Q1; write only on consent
6. **Check commit consent** — read `docs/whalekit/COMMIT-POLICY.md`; memos are recorded (never — the entire directory is ignored); honor the recorded decision without re-asking
7. **Write design memo** — to `docs/whalekit/memos/YYYY-MM-DD-<topic>.md`; never delete after superseding
8. **Implement** — proceed with the normal development workflow (TDD applies); no plan document

**Architectural:**
1. **Explore project context** — check files, docs, recent commits
2. **Ask clarifying questions** — one at a time, multiple choice preferred
3. **Propose 2-3 approaches** — with trade-offs and your recommendation
4. **Present design** — in sections scaled to their complexity, get user approval after each section
5. **Ask whether to persist the design as a memo** — artifact-chain Q1; write only on consent
6. **Check commit consent** — read `docs/whalekit/COMMIT-POLICY.md`; memos are recorded (never — the entire directory is ignored); honor the recorded decision without re-asking
7. **Write design memo** — to `docs/whalekit/memos/YYYY-MM-DD-<topic>.md`; never delete after superseding
8. **Debate-team refinement (optional, on consent)** — loop the memo through `adversarial-review` decision mode until convergence
9. **Transition to spec** — at tier L3+, write the design spec (`docs/whalekit/specs/YYYY-MM-DD-<topic>-design.md`) and follow the commit-consent protocol for it
