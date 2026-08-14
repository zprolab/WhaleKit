---
name: decision-approval
description: Use when the user waives a decision (你定就行/都行/随便/不用问我) and open decisions must be resolved through a draft sheet the user approves or edits before they take effect
---

# Decision Approval (决策草案批准)

Standardizes what happens when the user delegates decisions: **delegation converts the question
into a draft; approval converts the draft into a decision.** The user's decision is the highest
authority below the system prompt. A waiver delegates the answering, never the approval.
(Canonical global rules — gold standard, options rule, iron-law template — follow
`whalekit-conventions`; this skill is their waiver-mode operator.)

## 1. Trigger and threshold

1.1 **Trigger**: the user waives choosing on one or more open decisions ("你定就行", "都行",
"随便", "不用问我", "你全权决定", "直接做吧").

1.2 **Threshold**: only real-impact or genuinely ambiguous decisions get draft rows. Trivial
decisions (naming, style, directory layout, formatting) are folded into a single "默认采用项目
现有约定" line. **Approval fatigue is a failure mode**: a sheet beyond 5–7 rows makes the user
rubber-stamp and the gate loses its meaning.

1.3 If only one decision is open, fold it into the current message (one-line proposal + ask)
instead of a sheet.

## 2. Inputs

- The open decisions (options, trade-offs, and your recommendation if any)
- The user's waiver statement (verbatim, so the mode is justified)
- What proceeds after approval (design, implementation, commit, routing, ...)

## 3. Process

3.1 Collect the open decisions from the current gate (routing tier, design approval, commit
plan, execution handoff, ...).

3.2 For each decision, draft one row: **建议** (recommended option) + **一句话理由** + **备选**
(1–2 alternatives with a one-line cost each) + **置信度**. Options are neutral descriptions,
never sales pitches ("明显更好的方案是…" is a violation).

3.3 Cap the sheet at 5–7 rows; merge related decisions; mark 必须定 vs 可延后.

3.4 Label the sheet **草案/待批准**. Present it for wholesale approval ("都行/按你的来") or
per-item edits.

3.5 **Stop.** No design, implementation, or commit proceeds on unapproved items.

## 4. Full delegation (exception)

4.1 If the user explicitly waives review as well ("完全你定，不用给我看", "做完告诉我结果就行"),
proceed without a sheet — BUT record every decision as an **assumption** (decision + rationale +
confidence) in the disclosure/report. Silent, untraceable decisions remain violations.

4.2 The user can veto or revise any recorded assumption later.

## 5. <HARD-GATE>

**Definition:** treating any draft as a decision before user approval; implementing or proceeding
on unapproved drafts; silently deciding open items instead of drafting when the user waived;
or presenting a sheet without stopping for approval.

**Obligation:** drafts stay labeled 草案/待批准 until the user approves or edits them; unapproved
items never drive implementation; **silence is not approval** — in the absence of the user,
deliver the sheet and stop, recording unapproved items as assumptions.

**Exception:** full delegation per §4 — the user explicitly waived review; decisions are then
recorded as assumptions with rationale and confidence, and remain vetoable.

## Rationalizations

| Excuse | Reality |
|--------|---------|
| "用户说都行，意思就是让我随便做" | "都行" delegates the answer, not the approval. Draft → approve/change → implement. |
| "这些小事也要问，太烦了" | Threshold rule: trivial items fold into one default line; only real-impact items get rows. |
| "先做，做完一起说" | Implementing on unapproved drafts is the RED baseline failure. |
| "用户不在，我不能卡住" | Deliver the sheet and stop; silence is recorded as assumptions, never as approval. |
| "我的推荐就是结论" | A recommendation is a proposal until the user confirms it. |
| "不用给我看 = 我随便记一下就行" | Full delegation still requires an assumption log — auditable and vetoable. |
| "这是技术细节，用户不会在意" | The user may not care — but the waiver was about answering, not about oversight. |

## Red flags

- Sheet rows without 草案/待批准 labeling
- Implementation or commit before approval
- More than 7 rows, or trivial decisions occupying rows (approval fatigue)
- Sales-pitch option phrasing ("明显更好", "当然是")
- Under full delegation: decisions made and implemented with no assumption record

## Relationship to other skills

Referenced by skills whose gates hit a waiver:

- `routing` — tier choice ("你定吧" → tier draft sheet)
- `adversarial-review` — decision mode output ("你选" → options become a draft sheet)
- `socratic-brainstorming` — design approval ("不用给我看" → design decision sheet)
- `writing-plans` — execution handoff choice ("都行" → handoff draft sheet)
- `commit` — commit plan consent ("你看着提交" → commit plan draft sheet)
- `using-whalekit` — artifact chain depth ("随便" → chain draft sheet)

Complements `clarification-questioner`: that skill drafts **answers to questions**; this skill
drafts **decisions**. Same approval-gate principle.
