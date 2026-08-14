---
name: decision-approval
description: Use when the user waives a decision (you decide / whatever / don't ask me) and open decisions must be resolved through a draft sheet the user approves or edits before they take effect
---

# Decision Approval

Standardizes what happens when the user delegates decisions: **delegation converts the question
into a draft; approval converts the draft into a decision.** The user's decision is the highest
authority below the system prompt. A waiver delegates the answering, never the approval.
(Canonical global rules — gold standard, options rule, iron-law template — follow
`whalekit-conventions`; this skill is their waiver-mode operator.)

## 1. Trigger and threshold

1.1 **Trigger**: the user waives choosing on one or more open decisions ("you decide", "whatever",
"don't ask me", "up to you", "just do it").

1.2 **Threshold**: only real-impact or genuinely ambiguous decisions get draft rows. Trivial
decisions (naming, style, directory layout, formatting) are folded into a single "follow existing
project conventions" line. **Approval fatigue is a failure mode**: a sheet beyond 5–7 rows makes
the user rubber-stamp and the gate loses its meaning.

1.3 If only one decision is open, fold it into the current message (one-line proposal + ask)
instead of a sheet.

## 2. Inputs

- The open decisions (options, trade-offs, and your recommendation if any)
- The user's waiver statement (verbatim, so the mode is justified)
- What proceeds after approval (design, implementation, commit, routing, ...)

## 3. Process

3.1 Collect the open decisions from the current gate (routing tier, design approval, commit
plan, execution handoff, ...).

3.2 For each decision, draft one row: **proposal** (recommended option) + **one-line rationale**
+ **alternatives** (1–2 alternatives with a one-line cost each) + **confidence**. Options are
neutral descriptions, never sales pitches ("the obviously better option is…" is a violation).

3.3 Cap the sheet at 5–7 rows; merge related decisions; mark **must-decide** vs **can-defer**.

3.4 Label the sheet **draft / pending approval**. Present it for wholesale approval ("whatever
you think / go with your picks") or per-item edits.

3.5 **Stop.** No design, implementation, or commit proceeds on unapproved items.

## 4. Full delegation (exception)

4.1 If the user explicitly waives review as well ("fully up to you, don't show me", "just tell me
the result when you're done"), proceed without a sheet — BUT record every decision as an
**assumption** (decision + rationale + confidence) in the disclosure/report. Silent, untraceable
decisions remain violations.

4.2 The user can veto or revise any recorded assumption later.

## 5. <HARD-GATE>

**Definition:** treating any draft as a decision before user approval; implementing or proceeding
on unapproved drafts; silently deciding open items instead of drafting when the user waived;
or presenting a sheet without stopping for approval.

**Obligation:** drafts stay labeled "draft / pending approval" until the user approves or edits
them; unapproved items never drive implementation; **silence is not approval** — in the absence
of the user, deliver the sheet and stop, recording unapproved items as assumptions.

**Exception:** full delegation per §4 — the user explicitly waived review; decisions are then
recorded as assumptions with rationale and confidence, and remain vetoable.

## Rationalizations

| Excuse | Reality |
|--------|---------|
| "The user said whatever, so they want me to just do it" | "Whatever" delegates the answer, not the approval. Draft → approve/change → implement. |
| "Asking about these small things is annoying" | Threshold rule: trivial items fold into one default line; only real-impact items get rows. |
| "Do it first, report afterwards" | Implementing on unapproved drafts is the RED baseline failure. |
| "The user is away; I can't stall" | Deliver the sheet and stop; silence is recorded as assumptions, never as approval. |
| "My recommendation is the conclusion" | A recommendation is a proposal until the user confirms it. |
| "Not showing me = I can just note it down" | Full delegation still requires an assumption log — auditable and vetoable. |
| "It's a technical detail the user won't care about" | The user may not care — but the waiver was about answering, not about oversight. |

## Red flags

- Sheet rows without "draft / pending approval" labeling
- Implementation or commit before approval
- More than 7 rows, or trivial decisions occupying rows (approval fatigue)
- Sales-pitch option phrasing ("obviously better", "of course")
- Under full delegation: decisions made and implemented with no assumption record

## Relationship to other skills

Referenced by skills whose gates hit a waiver:

- `routing` — tier choice ("you pick" → tier draft sheet)
- `adversarial-review` — decision mode output ("you choose" → options become a draft sheet)
- `socratic-brainstorming` — design approval ("don't show me" → design decision sheet)
- `writing-plans` — execution handoff choice ("whatever" → handoff draft sheet)
- `commit` — commit plan consent ("you handle it" → commit plan draft sheet)
- `using-whalekit` — artifact chain depth ("up to you" → chain draft sheet)

Complements `clarification-questioner`: that skill drafts **answers to questions**; this skill
drafts **decisions**. Same approval-gate principle.
