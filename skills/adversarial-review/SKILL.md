---
name: adversarial-review
description: Use only for decisions affecting a final implementation conclusion, possible technical-direction shifts, or architecture-level bug fixes - runs red/blue/black adversarial loops in decision mode or red-finds/blue-fixes loops in review mode
---

# Adversarial Review

Fight hallucination with adversarial review. Big decisions and architecture-level bugs go through red/blue/black subagent loops — separate adversarial voices — rather than single-agent judgment, and surface as 2–3 options the user chooses from. This is a restrained meta-skill: it must NOT be over-triggered, and it must NOT be under-triggered where tier L5 makes it mandatory.

## 1. Trigger Discipline

1.1 This skill is used only when a decision affects a final implementation conclusion, may shift technical direction, or fixes an architecture-level bug. That is, trigger adversarial review only when at least one holds:
   - (a) the decision affects a final implementation conclusion;
   - (b) the technical direction may shift;
   - (c) an architecture-level bug is being fixed.

1.2 Otherwise the normal review route applies (`requesting-code-review`), not adversarial review.

1.3 Over-triggering is a violation: opening red/blue/black loops for a small routine bug or a routine review that §1.1 does not admit is misuse of the skill. When §1.1 holds, the trigger is the destination decision (or the architecture-level bug), not the impulse to be thorough.

1.4 Under-triggering is also a violation: at tier L5 full process, adversarial review is **mandatory** — decision mode on the spec, review mode on architecture (routing, spec §5.3). If §1.1 holds or the routing tier mandates it and you skip the loop, you have under-triggered.

## 2. Decision Mode

Decision mode refines a decision about technical direction, final conclusions, or architecture. The output is ALWAYS a set of 2–3 options for the user; the user decides, never the loop.

2.1 **Red proposes** — a fresh red subagent argues for a position (or multiple candidate positions) with evidence.

2.2 **Blue objects** — a fresh blue subagent attacks red's proposal, searching for flaws, unsupported claims, ignored alternatives, and contradictions.

2.3 **Black integrates and decides** — a fresh black subagent weighs red and blue, resolves what survives, and produces the integrated outcome.

2.4 The loop continues while black is unsatisfied — that is, while there are new objections or new contradictions that black has not yet integrated. Convergence (loop exit) = no new objections and no new contradictions in the latest round.

2.5 Once converged, the output is ALWAYS 2–3 options for the user to choose between. The loop must present distinct, decision-ready options, never a single recommendation. The user's decision is final; the loop's conclusion never overrides it.

2.6 Different major decisions may open separate adversarial loops concurrently, using separate subagent contexts (one loop per decision). Do not cross loops.

> **The user's decision is the highest authority below the system prompt.**
>
> **Before any major decision, present 2–3 options to the user.**

## 3. Review Mode

Review mode fixes bugs in docs or code, with file:line evidence. Its deliverable is the fixed artifact, never a report.

3.1 **Red finds bugs** — a fresh red subagent reviews the docs/code and reports real issues, each with file:line evidence. No evidence, no issue.

3.2 **Blue fixes** — a fresh blue subagent applies the fixes for the accepted issues, directly to the artifact.

3.3 Deliver the **fixed artifact** directly (the corrected file or code), not a report of what could be fixed.

3.4 Review mode delivers no user options; it delivers a fixed artifact directly. This is the exception to the decision-mode options requirement (see section 5).

## 4. Dispatch Mechanics

4.1 Each role (red, blue, black) is a **fresh subagent** with an **isolated context**, dispatched via the runtime's native subagent capability.

4.2 Role prompts are **constructed fresh per loop** — each role receives only what it needs for its turn (the proposal, the objections, or the integration), built from the current loop state.

4.3 Roles never inherit the session history. A role sees only its constructed prompt, never the main session or another role's live context, so each voice is genuinely independent.

## 5. <HARD-GATE>

A red/blue/black loop whose output is a single recommendation without user options (decision mode) is a violation.

**Definition:** any decision-mode loop that concludes by presenting the user a single recommendation — one option, no choice — instead of 2–3 distinct options.

**Obligation:** every converged decision-mode loop presents 2–3 distinct options to the user and stops there, leaving the decision to the user (who is the highest authority below the system prompt).

**Exception:** review mode (section 3), which delivers a fixed artifact directly instead of user options. This is the only exception; it never applies to decision mode.

## Red Flags

| Thought | Reality |
|---------|---------|
| "This small bug deserves the full adversarial treatment" | Over-triggering is a violation. §1.1 gates the loops; a small routine bug stays on the normal review route. |
| "It's just a single-file fix — I can decide alone" | If it is architecture-level or §1.1 holds, decide mode is mandatory even for a small diff. |
| "The debate converged, so here's what we should do" | Convergence produces 2–3 options, not a mandate. The user decides. |
| "Blue found one thing, so that's the answer" | Blue's objections feed black; the loop keeps going while new objections arise, then still outputs options. |
| "I'll run one loop for several decisions at once" | Separately major decisions get separate loops and separate contexts. |
| "I verified it myself, no review needed" | At L5 architecture, adversarial review is mandatory — self-verification is not a substitute. |

## Checklist

1. **Check the trigger** — does §1.1 (a), (b), or (c) hold, or does the routing tier mandate it? No → use the normal review route. Yes → proceed.
2. **Choose the mode** — decision mode (a decision/direction) or review mode (a bug in docs/code).
3. **Decision mode** — dispatch fresh red (propose) → blue (object) → black (integrate/decide); loop while black is unsatisfied; on convergence, present 2–3 options to the user and stop.
4. **Review mode** — dispatch fresh red (find bugs with file:line evidence) → blue (fix) → deliver the fixed artifact directly.
5. **Respect the hard gate** — decision mode never outputs a single recommendation; only review mode's fixed artifact bypasses the options requirement.
