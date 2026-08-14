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
message, after curation. This preserves the one-at-a-time dialogue rule of
`socratic-brainstorming` (§1.2), whose question-quality rules (multiple-choice preference, ask
only what cannot be inferred) this skill follows by reference, not by restatement.

## 2. Inputs

The caller must provide:

- **Identity** — the advisor persona to frame the questions in (role, expertise stance).
  Example: "a senior software architect and requirements consultant who turns ideas into
  executable design plans".
- **Proj Context** — at minimum:
  1. the user's request, verbatim;
  2. project state (greenfield, or existing code — what exists, where);
  3. already-decided anchors and constraints, if any;
  4. domain or tech hints, optional.

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

- Purpose & positioning (purpose, audience, priority of trade-offs)
- Scope (in-scope features, explicit out-of-scope / non-goals, YAGNI)
- Execution semantics (transactions/ACID, persistence & durability, concurrency model)
- Scale & performance (quantified targets: throughput, latency, data volume)
- Tech selection (language, dependencies policy, storage approach)
- Interface shape (library API vs CLI vs service; protocol compatibility)
- Quota (time budget, line/scope limits, deliverable deadlines)
- Deliverables & acceptance (deliverables, acceptance criteria, benchmark)
- Compatibility (existing system / dialect / format compatibility)
- Risks & conflict points (flag conflicts explicitly, e.g. "high performance vs strict ACID")

### 3.4 Quality pass

Follow the question-quality rules of `socratic-brainstorming` §1 by reference (multiple-choice
preferred, ask only what cannot be inferred). Additional output-contract rules:

- Each question is **one sentence**, specific, focused, answerable.
- **No embedded answers** ("wouldn't X be best?" is a violation).
- Deduplicate; drop questions the context answers.
- Mark each question: **must-ask** or **optional**, and flag conflicts/risks.
- Cap the list at the classification size; keep only highest-leverage questions.

## 4. Output contract

Return the list as:

```
Classification: <spike|bounded|architectural>
Q1. <one-sentence question> [dimension] [must-ask|optional] [suggested options: A/B/C]
Q2. ...
Suggested asking order: <highest-leverage first>
```

End at the list. Do not add next steps, design hints, or summaries of what you would build.

## 5. Curation and asking (the caller's job, not the skill's)

5.1 The caller (main agent) filters the list — removes questions it can answer from other context,
merges duplicates — and **adds its own questions**.

5.2 The caller then asks the user **one question per message** and waits for each answer (the
brainstorming one-at-a-time rule). Answers feed back into the caller's design flow.

5.3 The skill is complete once the candidate list is delivered; it does not participate in asking
or in design.

## 5.5 Waiver mode: proposed-answers sheet (user says "don't ask, just do it")

If the user explicitly waives asking ("no need to ask questions", "just do it", "you decide"),
the caller does **not** silently drop the questions and does **not** silently decide them. The
**sheet mechanics follow `decision-approval` by reference** (draft rows labeled
"draft / pending approval", approval or per-item edits, silence is not approval, full delegation
records assumptions). The answer-specific part here is only the mapping:

1. Deliver the candidate list as usual (§4).
2. Attach a **proposed-answers sheet**: for each must-ask question, one line containing the
   proposed answer, a one-line rationale, and a confidence tag. Optional questions may be skipped
   or given proposals at the caller's discretion.
3. Present the sheet for **approval or change** (wholesale or per-item), per `decision-approval`.

The user's decision is the highest authority below the system prompt: the user may approve,
reject, or rewrite any proposal, including "this one is wrong, use X".

## 6. <HARD-GATE>

**Definition:** producing any design, implementation, solution sketch, pseudo-code, or
self-answer — inside the question list, attached to it, or instead of it — that is presented as a
decision the user never approved.

**Obligation:** the only unconditional output is the candidate question list per §4. Questions
never contain recommended answers; open items are never decided by the questioner.

**Exception:** under the user's explicit waiver (§5.5), the caller may deliver proposed answers
for user approval — proposals stay labeled "draft / pending approval" and become decisions only
after the user approves or edits them. Implementing on unapproved self-made assumptions is never
exempted (that is the RED baseline failure mode).

## Rationalizations

| Excuse | Reality |
|--------|---------|
| "Just do it, no need to ask questions" | The waiver switches to answer-drafting mode (§5.5): the caller proposes answers and the user approves or changes them. It never authorizes implementing on unapproved assumptions. |
| "The user said go with my answers, so they are decided" | Proposals stay drafts until the user approves or edits them. "Whatever you think" is approval; silence is not. |
| "The requirement is already crystal clear" | Clear to you ≠ clear to the user. The list asks only what is genuinely open — if truly nothing is open, the list is empty, which is a finding, not a failure. |
| "I can decide on my own, no need to ask" | The questioner never decides open items. Under waiver it may propose, but only the user's approval turns a proposal into a decision. |
| "Embedding my recommendation in the question helps the user choose" | An embedded recommendation is a design. Multiple-choice options must be neutral descriptions, not sales pitches. |
| "Let me design first and ask questions later" | Design before curated questions = implementing on unverified assumptions (the exact RED baseline failure). Stop at the list (or the approved sheet). |

## Red flags

- A question containing a recommended answer or a "wouldn't X be best?" phrasing
- Any design/solution text in or around the list
- Self-answering ("since you said local files are fine, I'll design it that way…") — proposals are
  allowed only in waiver mode and must be labeled "draft / pending approval"
- Proposals presented as decisions, or implementation before the user's approval
- Skipping the list because the task "looks small" without the user's explicit waiver being confirmed by the caller
- Asking facts the Proj Context already answers

## Relationship to other skills

- Canonical global rules (user gold standard, options rule, iron-law template) follow
  `whalekit-conventions`; this skill operates inside them.
- `socratic-brainstorming` owns the asking dialogue (one question per message) and the design
  phase; this skill owns only candidate generation, feeding its dialogue (by reference to its
  §1 question-quality rules).
- Used with a caller that curates: the caller may be a main agent working with subagents (e.g.,
  each subject generates its candidate list via this skill; the main agent filters and asks).
- Waiver-mode sheet mechanics follow `decision-approval` by reference (§5.5).
