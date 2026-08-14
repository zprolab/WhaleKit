---
name: clarification-questioner
description: Use when a design or build task begins and user requirements must be clarified into verified conclusions before any design or implementation work
---

# Clarification Questioner

A complete question-asking methodology: turns an ambiguous request into **verified conclusions**
the design can be built on. The questioner is a **question factory, not a lone interviewer**: it
prepares candidate questions from an advisor identity and the project context, the caller (main
agent) curates them, the dialogue asks **one question at a time**, and the answers **converge into
a conclusion sheet** whose clarity and quality are verified before design begins.

## 1. Boundary

1.1 The deliverables of this skill are **only** the candidate question list and the verified
conclusion sheet. It never produces designs, architecture proposals, solution sketches,
pseudo-code, or "recommended answers" — neither inside its outputs nor alongside them.

1.2 The questioner **never answers its own questions** and never decides open items. The user's
decision is the highest authority below the system prompt; unanswered questions stay open.

1.3 The questioner **never asks the user directly unless it is the dialogue owner**. Asking is
one question per message, after curation. When a caller (main agent) owns the dialogue, the skill
still supplies the convergence and verification templates so conclusions stay consistent.

1.4 Question-asking rules are tuned from `socratic-brainstorming` §1 by reference: classify and
announce (spike/bounded/architectural), one question per message, multiple-choice preferred, ask
only what cannot be inferred. This skill does not restate them; it adds the methodology stages
around them.

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

## 3. Methodology (7 stages)

### 3.1 Digest

Read the identity and Proj Context; classify the request (spike / bounded / architectural) and
announce the classification. Never ask about facts the context already answers; questions target
only what the agent **cannot infer**.

### 3.2 Generate candidates

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

Size the list by classification: spike ≤ 5, bounded ≤ 8, architectural ≤ 20. Quality pass: one
sentence per question, multiple-choice with 2–4 neutral options where options exist, **no embedded
answers**, deduplicate, mark **must-ask** vs **optional**, keep only highest-leverage questions.

### 3.3 Curate

The caller (main agent) filters the list — removes questions answerable from other context, merges
duplicates — and adds its own questions. The final list is what gets asked.

### 3.4 Ask (dialogue)

- Ask **one question per message**; never bundle. Wait for each answer.
- Prefer multiple-choice; record the chosen option verbatim.
- **Answer processing rules:**
  - Capture answers **verbatim**; never silently reinterpret ("JSON is fine — or maybe CSV? you
    pick" stays both options, not "user chose JSON").
  - If an answer is ambiguous, ask **one follow-up question** (still one at a time).
  - If the user waives or defers a decision ("you pick", "whatever"), route that item to
    `decision-approval` (waiver path) instead of deciding quietly.
  - If two answers contradict, flag the conflict to the user as a follow-up; do not smooth it over.
- When the user has answered everything (or explicitly stops), end the dialogue.

### 3.5 Converge

Produce a **conclusion sheet** — one row per must-ask question:

```
| Q | Verbatim answer | Conclusion (specific design implication) | Confidence | Status |
```

Status is one of: **answered** (conclusion derived from the verbatim answer), **assumption**
(no answer or "you pick" not yet approved — recorded with reason), **deferred** (explicitly
postponed). No question may silently disappear: every must-ask question must reach one of the
three statuses.

### 3.6 Verify (conclusion clarity & quality)

Check every conclusion against the clarity criteria:

1. **Specific** — no vague phrasing ("use a reasonable approach", "handle it appropriately");
   each conclusion states exactly what the design must do.
2. **Traceable** — maps to its question and the verbatim answer.
3. **Consistent** — no contradictions across conclusions; conflicts flagged, not hidden.
4. **Constraint-aligned** — does not contradict already-decided anchors/constraints.
5. **Actionable** — a designer can act on it without re-asking.

A conclusion that fails any criterion gets one more clarifying question (one at a time) or is
demoted to an assumption with the reason stated.

### 3.7 Record & handoff

Deliver the **verified conclusion sheet** to the caller as the design input. Remaining open items
and assumptions are recorded in the disclosure (per `decision-approval` where waivers occurred).
Design begins only after this handoff.

## 4. Output contracts

### 4.1 Candidate list

```
Classification: <spike|bounded|architectural>
Q1. <one-sentence question> [dimension] [must-ask|optional] [suggested options: A/B/C]
Q2. ...
Suggested asking order: <highest-leverage first>
```

### 4.2 Conclusion sheet

```
Conclusion sheet — <request summary>
| Q | Verbatim answer | Conclusion | Confidence | Status (answered/assumption/deferred) |
Open items: <assumptions with reasons; deferred questions; waiver items routed to decision-approval>
```

End at the outputs. Do not add design hints or summaries of what you would build.

## 5. Waiver mode: proposed-answers sheet (user says "don't ask, just do it")

If the user explicitly waives asking ("no need to ask questions", "just do it", "you decide"),
the caller does **not** silently drop the questions and does **not** silently decide them. The
**sheet mechanics follow `decision-approval` by reference** (draft rows labeled
"draft / pending approval", approval or per-item edits, silence is not approval, full delegation
records assumptions). The answer-specific part here is only the mapping:

1. Deliver the candidate list as usual (§4.1).
2. Attach a **proposed-answers sheet**: for each must-ask question, one line containing the
   proposed answer, a one-line rationale, and a confidence tag. Optional questions may be skipped
   or given proposals at the caller's discretion.
3. Present the sheet for **approval or change** (wholesale or per-item), per `decision-approval`.
4. Approved answers feed the conclusion sheet (§3.5–3.6) unchanged.

The user's decision is the highest authority below the system prompt: the user may approve,
reject, or rewrite any proposal, including "this one is wrong, use X".

## 6. <HARD-GATE>

**Definition:** producing any design, implementation, solution sketch, pseudo-code, or
self-answer — inside the question list, the conclusion sheet, attached to them, or instead of
them — that is presented as a decision the user never approved; or starting design without a
verified conclusion sheet (every must-ask question resolved or explicitly recorded as an
assumption/deferred item); or silently dropping a question at any stage.

**Obligation:** the only unconditional outputs are the candidate list and the verified conclusion
sheet per §4. Questions and conclusions never contain recommended answers or silent
reinterpretations; open items are never decided by the questioner; design begins only after the
conclusion sheet is delivered and verified.

**Exception:** under the user's explicit waiver (§5), the caller may deliver proposed answers for
user approval — proposals stay labeled "draft / pending approval" and become decisions only after
the user approves or edits them. Implementing on unapproved self-made assumptions is never
exempted (that is the RED baseline failure mode).

## Rationalizations

| Excuse | Reality |
|--------|---------|
| "Just do it, no need to ask questions" | The waiver switches to answer-drafting mode (§5): propose answers, get approval, then converge. It never authorizes implementing on unapproved assumptions. |
| "The user said go with my answers, so they are decided" | Proposals stay drafts until the user approves or edits them. "Whatever you think" is approval; silence is not. |
| "The requirement is already crystal clear" | Clear to you ≠ clear to the user. The list asks only what is genuinely open — if truly nothing is open, the list is empty, which is a finding, not a failure. |
| "The user answered everything, so I can start designing" | Not yet: answers must first converge into a verified conclusion sheet (§3.5–3.6). Design before that = building on unverified conclusions. |
| "I'll summarize the answers in my own words" | Summaries drift. Capture verbatim, then derive conclusions with traceability. |
| "JSON or CSV, either works — I'll record 'user chose JSON'" | The user said "you pick" for a reason. Record verbatim, flag the open item, route to the waiver path. |
| "I can decide on my own, no need to ask" | The questioner never decides open items. Under waiver it may propose, but only the user's approval turns a proposal into a decision. |
| "Embedding my recommendation in the question helps the user choose" | An embedded recommendation is a design. Multiple-choice options must be neutral descriptions, not sales pitches. |
| "Let me design first and ask questions later" | Design before curated questions = implementing on unverified assumptions (the exact RED baseline failure). Stop at the list (or the approved sheet). |

## Red flags

- A question containing a recommended answer or a "wouldn't X be best?" phrasing
- Any design/solution text in or around the list or conclusion sheet
- Self-answering ("since you said local files are fine, I'll design it that way…") — proposals are
  allowed only in waiver mode and must be labeled "draft / pending approval"
- Proposals presented as decisions, or implementation before the user's approval
- **A must-ask question missing from the conclusion sheet (silent drop)**
- **Vague conclusions ("use a reasonable approach") or reinterpreted answers**
- **Design starting without a verified conclusion sheet**
- Skipping the list because the task "looks small" without the user's explicit waiver being confirmed by the caller
- Asking facts the Proj Context already answers

## Relationship to other skills

- Canonical global rules (user gold standard, options rule, iron-law template) follow
  `whalekit-conventions`; this skill operates inside them.
- `socratic-brainstorming` owns the asking dialogue rules this skill tunes (§1.4) and the design
  phase; this skill owns the question-asking methodology that feeds its dialogue.
- `decision-approval` owns all waiver mechanics: proposed answers under "don't ask" (§5) and
  "you pick" items surfacing during the dialogue (§3.4).
- Used with a caller that curates: the caller may be a main agent working with subagents (e.g.,
  each subject generates its candidate list via this skill; the main agent filters, asks, and the
  skill supplies the convergence/verification templates).
