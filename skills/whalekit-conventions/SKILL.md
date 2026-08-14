---
name: whalekit-conventions
description: "Use immediately after using-whalekit at session start - the canonical global conventions binding all agents: plain language, user gold standard, commit consent, doc chain, parking, iron-law gates"
---

# WhaleKit Conventions

## 1. Plain Language (说人话)

1.1 **Definition** — the following count as a violation:
   1. Unexplained jargon.
   2. Coined or pseudo-technical compound terms (e.g. "行为半环" where "行为闭环" is meant).
   3. Acronyms without expansion.
   4. Sentences whose meaning requires insider knowledge of WhaleKit internals.

1.2 **Obligation** — write in everyday words first; gloss any technical term inline on first use (e.g. "the tier menu (the process-depth choice)"); prefer concrete nouns over abstract nominalizations; state the point before the mechanism; and when writing in the user's language, match their register.

1.3 **Worked example**:
   - ✗ "检查点 1 的行为半环仍需人工确认"
   - ✓ "入口技能的自动调用（检查点 1）仍需人工开一次新会话确认"

1.4 **Exception** — skill-internal normative text and file:line citations keep precise terms unglossed; code identifiers keep their names.

## 2. User Gold Standard

2.1 The user's decision is the highest authority below the system prompt.

> **The user's decision is the highest authority below the system prompt.**
>
> **Before any major decision, present 2–3 options to the user.**

2.2 Before any major decision, present 2–3 options to the user.

2.3 The agent never decides alone.

2.4 An explicit user decision overrides any agent recommendation, including adversarial-review conclusions.

## 3. Commit Consent

3.1 Read `COMMIT-POLICY.md` before writing any process artifact.

3.2 Follow recorded decisions without re-asking.

3.3 Ask (yes/no/never) for unlisted types before writing.

3.4 Record answers append-only.

3.5 Dual records default to committed.

## 4. Doc Chain

4.1 The chain is `Dual → Plan → Spec → Memo → User requirement`; the arrow points toward the golden standard.

4.2 Conflicts resolve toward the higher document (the one closer to the user requirement).

4.3 Ask the user when the higher document is silent or the refined side is clearly better.

4.4 The user's live decision outranks the chain.

## 5. Parking

5.1 Skills with `metadata.status: useless-now` are never triggered or recommended.

5.2 Only a spec-level decision flips the status.

5.3 Never cite a parked skill as an available tool.

## 6. Iron-Law Gates

6.1 The `<HARD-GATE>` pattern: every iron law carries **Definition** (what counts as a violation) + **Obligation** (what must be done) + **Exception** (what waives it).

6.2 The canonical gate statement: "A non-trivial task on which implementation work begins before the process-depth questions (Q1–Q4: memo, spec, plan, dual records) were asked and answered — absent an explicit 'skip the menu' waiver — is a violation."

6.3 Exception: the user explicitly says "skip the menu" for a specific task.

6.4 **Reusable iron-law template.** Every skill that imposes an iron law MUST structure it as the three-part template below — fill in the blanks, do not restructure:

> **Definition:** <what counts as a violation>
> **Obligation:** <what must be done before proceeding>
> **Exception:** <what waives it — by default, an explicit user decision>

A gate that omits any part is not an iron law; `writing-skills` enforces this template for every new or edited skill.

Where a skill differs from these conventions, conventions win.
