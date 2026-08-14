---
name: dual-records
description: Use at tier L5 Full - for every directory under development, writes DEVELOPMENT.md (how to build) and README.md (amendable truth, review baseline) with explicit git-traced amendments
---

# Dual Records

At tier L5 Full, implementation is not just code — the developing agent and the reviewing agent need a shared, authoritative understanding of what a directory is for and how to build it. Every directory under development carries two documents: `DEVELOPMENT.md`, which drives the agent as it builds, and `README.md`, the amendable truth that serves as the review baseline. Dual records derive from the plan and are traced in git; their traceability is what makes "the truth" trustworthy.

## 1. Trigger

1.1 This skill applies **only at tier L5 Full** (routing, spec §5.2) — when a new project, an architecture-level change, or a directional decision routes a directory to L5. At any lower tier, dual records are not produced by this skill.

1.2 **Every directory under development** gets both documents before implementation begins there. "Under development" means the directory is the target of L5 implementation — new code, refactoring, or an architecture-level change that you are about to build or modify. If a directory will receive L5 implementation work, both documents must exist in it before that implementation starts.

## 2. DEVELOPMENT.md — the sub-plan ("how to build")

2.1 `DEVELOPMENT.md` is the directory's **sub-plan**: it is the working document that drives the developing agent through the build, derived from the higher-level implementation plan (spec §7.7; the plan artifact from `writing-plans`).

2.2 It records **what to build** — the concrete contract, behaviors, and outputs that the implementation is committing to — and **in what order**: the sequencing of work, dependencies between pieces, and any milestones or checkpoints.

2.3 It records **how to test** — the verification steps, test commands, fixtures, or acceptance checks that establish that what was built works. The developing agent should be able to follow `DEVELOPMENT.md` from start to finish and land the implementation.

2.4 `DEVELOPMENT.md` is the actionable, "how" side of the records. It may evolve as the build proceeds, and its evolution is itself traced (see section 4).

## 3. README.md — the amendable truth ("what it should be")

3.1 `README.md` is the directory's **amendable truth**: the authoritative statement of what the directory should be — its contract, interfaces, and invariants — that exists independently of the current state of the code.

3.2 It captures the **contract** (what the directory promises to do), the **interfaces** (the public surfaces, signatures, and behaviors other code relies on), and the **invariants** (properties that must always hold once the implementation is complete).

3.3 `README.md` is the **review baseline**: implementation is compared against it, and review evaluates whether the code matches what `README.md` says the directory should be (spec §7.4). It is the baseline `requesting-code-review` compares against at L5.

3.4 `README.md` states *what should be*, not merely *what currently is*. When code and README diverge, README.md is the statement of intended truth until it is deliberately amended (section 4).

## 4. Deviation Handling

4.1 On any deviation between the implementation and `README.md`, resolve it explicitly — **either** change the code so it matches `README.md` **or** deliberately amend `README.md` to state the new intended truth. Do neither only silently.

4.2 **Every amendment** to `README.md` (or `DEVELOPMENT.md`) is a **git commit** — a constitution-amendment model, not "docs are stale, edit freely." Each change is a recorded, reviewable amendment to the record.

4.3 **Silent doc drift is a violation.** Allowing `README.md` to fall out of step with the code (or the code with `README.md`) without an explicit decision and commit is a violation of this skill. When you notice drift, you must surface it and resolve it per 4.1, never paper over it.

4.4 **Committing dual records defaults to yes.** Their traceability is the mechanism (§7.6 rule 5): an uncommitted README.md cannot serve as a git-traced review baseline. Per the commit-consent protocol, before writing dual records read `docs/whalekit/COMMIT-POLICY.md` and the nearest `COMMIT-POLICY.md` covering the target; a "no" commit decision for a dual record is honored but must be recorded as deliberately weakening the amendable-truth mechanism.

## 5. Doc Chain

5.1 Dual records **derive from the plan** (spec §7.7): each directory's `DEVELOPMENT.md` and `README.md` are refinements of the higher-level implementation plan, and must remain traceable back through the plan, the spec, the memo, and ultimately the user requirement.

5.2 On conflict between documents, resolve toward the higher-level document — the chain is `Dual → Plan → Spec → Memo → User requirement` (spec §7.7), with the user requirement as the golden standard.

5.3 When the higher document is **silent** (does not settle the point) or the later, more refined side is **clearly superior**, **ask the user**. The user is the highest authority below the system prompt; their live decision outranks the chain.

## 6. <HARD-GATE>

Implementation in an L5 directory without both records is a violation.

**Definition:** any L5 implementation work — new code, refactoring, or an architecture-level change — started in a directory under development before both `DEVELOPMENT.md` and `README.md` exist in that directory. The violation occurs at the moment of implementation, not at the moment the lack of records is noticed.

**Obligation:** before implementing in any L5 directory, create both `DEVELOPMENT.md` (what to build, in what order, how to test) and `README.md` (contract, interfaces, invariants — the review baseline) in that directory. Keep them accurate per section 4 (deviations are resolved by a code change or a committed amendment, never silently).

**Exception:** the user explicitly waives dual records for the directory. Only the user can waive this; the waiver applies to the directory they name, and the user remains the highest authority below the system prompt.

## Red Flags

| Thought | Reality |
|---------|---------|
| "It's a brand-new directory, I'll write the README after the code settles" | At L5, both records exist before implementation begins. Writing them first is the point. |
| "The README is slightly stale — I'll just update my mental model of the code" | That is silent drift, a violation. Resolve it: change the code or commit an amendment to README.md. |
| "README.md should describe whatever the code currently does" | README.md is the amendable truth of what the directory *should be* — the review baseline — not a snapshot of whatever exists. |
| "I'll edit the README inline as I go, no need to commit each time" | Every amendment is a git commit; traceability is the mechanism. Uncommitted edits are not an amendable truth. |
| "This is L3/L4 work, but adding dual records can't hurt" | Dual records are an L5 discipline. Lower tiers use only the artifacts their tier calls for. |
| "The plan says X, the README I drafted says Y — I'll just pick Y" | On conflict resolve toward the higher document; when silent or one side is clearly better, ask the user. |

## Checklist

1. **Confirm the tier** — is this L5 Full? No → dual records do not apply. Yes → proceed.
2. **Check current directories** — identify every directory under development at L5.
3. **Create both records first** — for each such directory, write `DEVELOPMENT.md` (what / order / how-to-test) and `README.md` (contract / interfaces / invariants) before implementing; read `COMMIT-POLICY.md` first and honor the commit decision (default: committed).
4. **Implement against the records** — follow `DEVELOPMENT.md` to build; compare work against the `README.md` baseline.
5. **Resolve deviations explicitly** — change the code or commit an amendment to `README.md`; never leave silent drift.
6. **Honor the doc chain** — dual records derive from the plan; resolve conflicts toward the user requirement, and ask the user when the higher document is silent or the refined side is clearly better.
