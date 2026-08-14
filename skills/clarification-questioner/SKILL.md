---
name: clarification-questioner
description: Use when a design or build task begins and a candidate list of clarifying questions for the user must be prepared before any design or implementation work
---

# Clarification Questioner

Generates the candidate clarifying-question list for a design or build task. The questioner is a
**question factory, not a questioner in dialogue**: it takes an advisor identity and the project
context, and returns a numbered candidate list. The caller (main agent) curates the list — filters
and adds questions — then asks the user **one question at a time** in its own dialogue.

## 1. Boundary

1.1 The deliverable of this skill is **only** the candidate question list. It never produces:
designs, architecture proposals, solution sketches, pseudo-code, or "recommended answers" —
neither inside the list nor alongside it.

1.2 The questioner **never answers its own questions** and never decides the open items. The
user's decision is the highest authority below the system prompt; unanswered questions stay open.

1.3 The questioner **never asks the user directly**. Asking is the caller's job, one question per
message, after curation. This preserves the one-at-a-time dialogue rule of the brainstorming
skills (`brainstorming`, `socratic-brainstorming`).

## 2. Inputs

The caller must provide:

- **身份 (identity)** — the advisor persona to frame the questions in (role, expertise stance).
  Example: "资深软件架构师与需求分析顾问，帮助用户把想法变成可执行的设计方案".
- **Proj Context** — at minimum:
  1. 用户需求原文 (the user's request, verbatim);
  2. 项目状态 (greenfield, or existing code — what exists, where);
  3. 已知锚点/已拍板约束 (already-decided anchors and constraints, if any);
  4. 领域/技术提示 (domain or tech hints, optional).

If an input is missing, state the assumption you used and mark its confidence instead of blocking.

## 3. Process

### 3.1 Digest

Read the identity and Proj Context. Never ask about facts the context already answers; the list
targets only what the agent **cannot infer**.

### 3.2 Classify (to size the list)

- **Spike** (feasibility question) — ≤ 5 questions.
- **Bounded** (well-scoped change to existing code) — ≤ 8 questions.
- **Architectural** (new project / new subsystem / restructured interfaces) — up to 20 questions.

Say the classification out loud before the list ("this looks bounded, so the list is short").

### 3.3 Generate candidates

Walk the dimension set and generate one-sentence questions for each genuinely open dimension:

- 动机与定位 (purpose, audience, priority of trade-offs)
- 范围 (in-scope features, explicit out-of-scope / non-goals, YAGNI)
- 执行语义 (transactions/ACID, persistence & durability, concurrency model)
- 规模与性能 (quantified targets: throughput, latency, data volume)
- 技术选型 (language, dependencies policy, storage approach)
- 接口形态 (library API vs CLI vs service; protocol compatibility)
- 配额 (time budget, line/scope limits, deliverable deadlines)
- 交付物与验收 (deliverables, acceptance criteria, benchmark)
- 兼容性 (existing system / dialect / format compatibility)
- 风险与冲突点 (flag conflicts explicitly, e.g. "高性能 vs 严格 ACID")

### 3.4 Quality pass

- Each question is **one sentence**, specific, focused, answerable.
- Prefer **multiple-choice** wording with 2–4 concrete options where options exist naturally.
- **No embedded answers** ("应该用 X 吧？" is a violation).
- Deduplicate; drop questions the context answers.
- Mark each question: 必须问 (must-ask) or 可选 (optional), and flag conflicts/risks.
- Cap the list at the classification size; keep only highest-leverage questions.

## 4. Output contract

Return the list as:

```
分类声明：<spike|bounded|architectural>
Q1. <一句话问题> [维度] [必须问|可选] [建议选项: A/B/C]
Q2. ...
建议询问顺序：<highest-leverage first>
```

End at the list. Do not add next steps, design hints, or summaries of what you would build.

## 5. Curation and asking (the caller's job, not the skill's)

5.1 The caller (main agent) filters the list — removes questions it can answer from other context,
merges duplicates — and **adds its own questions**.

5.2 The caller then asks the user **one question per message** and waits for each answer (the
brainstorming one-at-a-time rule). Answers feed back into the caller's design flow.

5.3 The skill is complete once the candidate list is delivered; it does not participate in asking
or in design.

## 5.5 Waiver mode: proposed-answers sheet (user says "不要问/直接做")

If the user explicitly waives asking ("不用问问题", "直接做吧", "你决定就行"), the caller does
**not** silently drop the questions and does **not** silently decide them. Instead:

1. Deliver the candidate list as usual (§4).
2. Attach a **proposed-answers sheet (答案草案)**: for each must-ask question, one line
   containing the proposed answer, a one-line rationale, and a confidence tag. Optional questions
   may be skipped or given proposals at the caller's discretion.
3. Label every proposal clearly as **草案/待批准** — a proposal is NOT a decision.
4. Present the sheet to the user for **approval or change**: wholesale approval ("都行/按你的来")
   or per-item edits.
5. Only approved (or user-edited) answers become decisions; design/implementation may then proceed
   on them. If the user approves nothing (silence, absence), the caller must record the proposals
   as assumptions in its disclosure and must not present them as approved decisions.

The user's decision is the highest authority below the system prompt: the user may approve,
reject, or rewrite any proposal, including "this one is wrong, use X".

## 6. <HARD-GATE>

**Definition:** producing any design, implementation, solution sketch, pseudo-code, or
self-answer — inside the question list, attached to it, or instead of it — that is presented as a
decision the user never approved.

**Obligation:** the only unconditional output is the candidate question list per §4. Questions
never contain recommended answers; open items are never decided by the questioner.

**Exception:** under the user's explicit waiver (§5.5), the caller may deliver proposed answers
for user approval — proposals stay labeled 草案/待批准 and become decisions only after the user
approves or edits them. Implementing on unapproved self-made assumptions is never exempted (that
is the RED baseline failure mode).

## Rationalizations

| Excuse | Reality |
|--------|---------|
| "直接做吧，不用问问题" | The waiver switches to answer-drafting mode (§5.5): the caller proposes answers and the user approves or changes them. It never authorizes implementing on unapproved assumptions. |
| "用户都说按我的来了，答案就是决定" | Proposals are 草案 until the user approves or edits them. "都行/按你的来" is approval; silence is not. |
| "这个需求已经写得很清楚了" | Clear to you ≠ clear to the user. The list asks only what is genuinely open — if truly nothing is open, the list is empty, which is a finding, not a failure. |
| "我可以自己定，不用问" | The questioner never decides open items. Under waiver it may propose, but only the user's approval turns a proposal into a decision. |
| "把推荐方案写进问题里，方便用户选" | An embedded recommendation is a design. Multiple-choice options must be neutral descriptions, not sales pitches. |
| "先把设计做了，问题回头补" | Design before curated questions = implementing on unverified assumptions (the exact RED baseline failure). Stop at the list (or the approved sheet). |

## Red flags

- A question containing a recommended answer or a "wouldn't X be best?" phrasing
- Any design/solution text in or around the list
- Self-answering ("既然你说了本地文件就行，那我按这个设计…") — proposals are allowed only in waiver mode and must be labeled 草案/待批准
- Proposals presented as decisions, or implementation before the user's approval
- Skipping the list because the task "looks small" without the user's explicit waiver being confirmed by the caller
- Asking facts the Proj Context already answers

## Relationship to other skills

- `brainstorming` / `socratic-brainstorming` own the asking dialogue (one question per message)
  and the design phase; this skill owns only candidate generation, feeding their dialogue.
- Used with a caller that curates: the caller may be a main agent working with subagents (e.g.,
  each subject generates its candidate list via this skill; the main agent filters and asks).
