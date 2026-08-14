---
name: writing-skills
description: "Use when creating new skills, editing existing skills, or verifying skills work before deployment - skill TDD: pressure scenarios, unaware subagents, fail-then-fix-then-pass loops"
---

Adapted from obra/superpowers (MIT) — https://github.com/obra/superpowers

# Writing Skills

## Overview

**Writing skills IS Test-Driven Development applied to process documentation.**

**REQUIRED BACKGROUND:** You MUST understand `test-driven-development` before using this skill. That skill defines the fundamental RED-GREEN-REFACTOR cycle. This skill adapts TDD to documentation.

**Core principle:** If you didn't watch an agent fail without the skill, you don't know if the skill teaches the right thing.

You write test cases (pressure scenarios with subagents), watch them fail (baseline behavior), write the skill (documentation), watch tests pass (agents comply), and refactor (close loopholes).

**DSH layout:** skills live under `<projectRoot>/.dsh/skills` or `~/.dsh/skills`; each skill is a directory bundle `<name>/SKILL.md` (plus optional `references/`, `scripts/`, `assets/`), or a flat `<name>.md`. Nested `**/SKILL.md` are NOT discovered, so each skill must have its own disambiguating name. Force-load links (`@some-skill`) are discouraged because they burn context; reference other skills by name with explicit requirement markers instead.

## TDD Mapping for Skills

| TDD Concept | Skill Creation |
|-------------|----------------|
| **Test case** | Pressure scenario with subagent |
| **Production code** | Skill document (SKILL.md) |
| **Test fails (RED)** | Agent violates rule without skill (baseline) |
| **Test passes (GREEN)** | Agent complies with skill present |
| **Refactor** | Close loopholes while maintaining compliance |
| **Write test first** | Run baseline scenario BEFORE writing skill |
| **Watch it fail** | Document exact rationalizations agent uses |
| **Minimal code** | Write skill addressing those specific violations |
| **Watch it pass** | Verify agent now complies |
| **Refactor cycle** | Find new rationalizations → plug → re-verify |

The entire skill creation process follows RED-GREEN-REFACTOR.

## When to Create a Skill

**Create when:**
- Technique wasn't intuitively obvious to you
- You'd reference this again across projects
- Pattern applies broadly (not project-specific)
- Others would benefit

**Don't create for:**
- One-off solutions
- Standard practices well-documented elsewhere
- Project-specific conventions (put in your instructions file)
- Mechanical constraints (if it's enforceable with regex/validation, automate it—save documentation for judgment calls)

## 1. The Iron Law (Same as TDD)

**NO SKILL WITHOUT A FAILING TEST FIRST.**

This applies to NEW skills AND EDITS to existing skills.

Write skill before testing? Delete it. Start over. Edit skill without testing? Same violation.

**No exceptions:**
- Not for "simple additions"
- Not for "just adding a section"
- Not for "documentation updates"
- Don't keep untested changes as "reference"
- Don't "adapt" while running tests
- Delete means delete

**REQUIRED BACKGROUND:** The `test-driven-development` skill explains why this matters. Same principles apply to documentation.

**Violating the letter of the rules is violating the spirit of the rules.**

## 2. Pressure Scenarios First

2.1 **Write the pressure scenarios before the skill.** A new skill or a substantive edit to an existing skill ships with pressure tests at `tests/pressure/<skill>/` (`scenarios.md` + `pass-criteria.md`). Writing the scenarios forces you, the planner, to state what behavior the skill must produce before the skill exists to guide it.

2.2 **Minimum of 2 scenarios per skill** (spec §9): one **skip-temptation** scenario (the task looks small or urgent, tempting the agent to skip the skill) and one **misleading-execution** scenario (a task that appears to call for the skill but really needs a decision, or a task that invites applying the skill wrongly).

2.3 **Dispatch an unaware subagent.** Run the scenario against a subagent that has NOT been told the skill's content (baseline). Watch it fail. Document its exact rationalizations verbatim. A scenario you cannot observe failing is a scenario you cannot trust.

2.4 **Gating rules need adversarial-abuse scenarios** (spec §9). For skills that gate or trigger other skills (e.g., routing, adversarial-review triggering), include scenarios that tempt the agent to misuse the gate: opening red/blue loops when not warranted, routing to the wrong tier, or triggering a restricted skill. These are the scenarios that keep the framework honest.

2.5 **Question-list protocol for dispatched subjects.** A dispatched test subject runs sandboxed — no human is available to answer questions. The subject MUST NOT ask clarifying questions and wait (that deadlocks the test). Instead it keeps a **question list**: for each question, record the question, the assumption made, and the confidence (high/medium/low); then proceed with the assumption, complete the task, and deliver the question list together with its result. The evaluator checks behavior against pass-criteria and may also assert on the question list (e.g., "the subject recorded an assumption about X"). This rule binds ONLY sandboxed pressure-test subjects; normal agent behavior is untouched — asking the user is the gold standard (canonical: `whalekit-conventions` §2) and is never suppressed by this protocol.

## 3. RED-GREEN-REFACTOR for Skills

Follow the TDD cycle:

### RED: Write Failing Test (Baseline)

Run pressure scenario with subagent WITHOUT the skill. Document exact behavior:
- What choices did they make?
- What rationalizations did they use (verbatim)?
- Which pressures triggered violations?

This is "watch the test fail" — you must see what agents naturally do before writing the skill.

### GREEN: Write Minimal Skill

Write skill that addresses those specific rationalizations. Don't add extra content for hypothetical cases.

Run same scenarios WITH skill. Agent should now comply.

### REFACTOR: Close Loopholes

Agent found new rationalization? Add explicit counter. Re-test until bulletproof.

## 4. Conventions

4.1 **Test directories** live at `tests/pressure/<skill>/` and contain exactly two files: `scenarios.md` (the pressure scenarios) and `pass-criteria.md` (the checkpoints the agent's behavior must satisfy). The harness `tests/run.sh <skill>` reads both.

4.2 **scenarios.md format:** realistic, well-scoped tasks written to *tempt* the agent — designed so a compliant agent reveals itself. State the task exactly as a user would phrase it, with enough context to be runnable, but do not leak the expected behavior into the task wording.

4.3 **pass-criteria.md format:** for each scenario, enumerate the checkpoints the agent's behavior must satisfy — observable, testable statements of what compliance looks like (e.g., "agent offered ≥2 tier options before implementing").

4.4 **Minimum 2 scenarios** (4.1 of this skill): one skip-temptation, one misleading-execution. Gating rules require at least one adversarial-abuse scenario (2.4).

4.5 **Harness modes:** `tests/run.sh <skill>` prints scenarios + pass criteria for a manual/reviewer run; `tests/run.sh <skill> --dispatch` prints a ready-to-use subagent dispatch prompt for the host agent; `tests/run.sh <skill> --live` prints a manual live-session verification checklist for entry-sensitive skills (see section 8).

## 5. Style-Guide Enforcement

5.1 **Every skill follows the writing style guide (spec §8).** A skill that is written, or an edit to a skill that is made, must conform before it is committed.

5.2 **Plain text by default with a markup budget** (spec §8 rule 1). Default writing is plain, numbered, statute-grade prose. Markup is a scarce resource: **bold + blockquote** for the emphasis layer (core principles, recurring cross-skill rules); `<HARD-GATE>`/`<EXTREMELY-IMPORTANT>` tags ONLY for iron laws.

5.3 **Every iron law carries three parts** (spec §8 rule 3): **Definition** (what counts as a violation), **Obligation** (what must be done), **Exception** (what, if anything, waives it). Precision over rhetorical pressure.

5.4 **Recurring cross-skill rules use identical wording** (spec §8 rules 1–2). The normative wording is (**Global Constraint 5**): "The user's decision is the highest authority below the system prompt." — always with the options rule: "Before any major decision, present 2–3 options to the user." Copy these verbatim wherever they appear; do not paraphrase — canonical: `whalekit-conventions` §2.

5.5 **Description field:** third person, starts with "Use when...", describes ONLY triggering conditions — never summarizes the workflow. A workflow-summarizing description is a discovery trap: agents follow the description instead of reading the body.

## 6. Parking

6.1 **Unripe skills ship parked, never deleted** (YAGNI + spec §6.3). A new skill that is not yet ready for real use is created with `metadata.status: useless-now` in its frontmatter, committed, and left in the catalog.

6.2 **Parked skills are catalog-visible but never triggered or recommended.** An agent must never invoke, recommend, or reference a skill whose `metadata.status` is `useless-now`; only a spec-level decision flips the status to usable — canonical: `whalekit-conventions` §5.

6.3 **The parking status is mandatory, not optional.** Shipping an unripe skill with `metadata.status` unset is a violation — it makes the skill appear usable when the spec says it must be hidden from triggering until deliberately un-parked.

## 7. Match the Form to the Failure

Before writing guidance, classify the baseline failure. The form that bulletproofs one failure type measurably backfires on another.

| Baseline failure | Right form | Wrong form |
|---|---|---|
| Skips/violates a rule under pressure (knows better, does it anyway) | Prohibition + rationalization table + red flags (see section 8) | Soft guidance ("prefer...", "consider...") |
| Complies, but output has the wrong shape (bloated prompt, buried verdict, restated spec) | Positive recipe or contract: state what the output IS — its parts, in order | Prohibition list ("don't restate", "never narrate") |
| Omits a required element from something they already produce | Structural: REQUIRED field or slot in the template they fill in | Prose reminders near the template |
| Behavior should depend on a condition | Conditional keyed to an observable predicate ("if the brief exists, reference it") | Unconditional rule + exemption clauses |

**Rules for whichever form you pick:**
- **No nuance clauses.** "Don't X unless it matters" reopens the negotiation. Express a real exception as its own conditional on an observable predicate.
- **Exemption clauses don't scope.** "This limit doesn't apply to code blocks" still suppresses code blocks. If part of the output must be exempt, restructure so the rule can't reach it.

## 8. Bulletproofing Skills Against Rationalization

Skills that enforce discipline need to resist rationalization. Agents are smart and will find loopholes when under pressure.

**Scope:** this toolkit is for discipline failures — an agent that knows the rule and skips it under pressure. For wrong-shaped output or omitted elements, prohibition-based bulletproofing backfires; use the forms in section 7 instead.

### Close Every Loophole Explicitly

Don't just state the rule - forbid specific workarounds. For example, "Write code before test? Delete it. Start over. No exceptions: don't keep it as 'reference', don't 'adapt' it while writing tests, don't look at it. Delete means delete."

### Address "Spirit vs Letter" Arguments

**Violating the letter of the rules is violating the spirit of the rules.** This cuts off the entire class of "I'm following the spirit" rationalizations.

### Build Rationalization Table

Capture rationalizations from baseline testing. Every excuse agents make goes in the table:

| Excuse | Reality |
|--------|---------|
| "Skill is obviously clear" | Clear to you ≠ clear to other agents. Test it. |
| "It's just a reference" | References can have gaps, unclear sections. Test retrieval. |
| "Testing is overkill" | Untested skills have issues. Always. 15 min testing saves hours. |
| "I'll test if problems emerge" | Problems = agents can't use skill. Test BEFORE deploying. |
| "Too tedious to test" | Testing is less tedious than debugging bad skill in production. |
| "I'm confident it's good" | Overconfidence guarantees issues. Test anyway. |
| "Academic review is enough" | Reading ≠ using. Test application scenarios. |
| "No time to test" | Deploying untested skill wastes more time fixing it later. |
| "This one is too simple to ship parked" | Unripe ships with `metadata.status: useless-now`, never deleted, never unset. |

### Create Red Flags List

Make it easy for agents to self-check when rationalizing:

- Code before test
- Skill written before pressure scenarios
- Unripe skill shipped with `metadata.status` unset
- "I already manually tested it"
- "This is different because..."
- "I'll just skip the marking-up, plain text is fine for an iron law"

**All of these mean: stop, and fix the skill to follow sections 1–6 before deploying.**

## 9. Entry-Skill Testing Limitation

9.1 **Entry skills cannot be validated by dispatched-subagent tests.** A skill carrying a mandatory `<SUBAGENT-STOP>` block (entry skills like `using-whalekit`) correctly exempts a dispatched subagent from its ceremony — so a dispatched-subagent pressure run can never observe the ceremony it is meant to enforce. This is not a test failure: it is the block working as designed.

9.2 **Use the `--live` harness mode or a live main-agent session.** Validate an entry skill with `tests/run.sh <skill> --live`, which prints a manual live-session verification checklist, and verify the ceremony in a real main-agent session (classification → tier options presented → user's choice honored). Do NOT claim a green dispatched-subagent run for an entry skill; record the live-session outcome instead.

## Common Rationalizations for Skipping Testing

| Excuse | Reality |
|--------|---------|
| "Skill is obviously clear" | Clear to you ≠ clear to other agents. Test it. |
| "It's just a reference" | References can have gaps, unclear sections. Test retrieval. |
| "Testing is overkill" | Untested skills have issues. Always. 15 min testing saves hours. |
| "I'll test if problems emerge" | Problems = agents can't use skill. Test BEFORE deploying. |
| "Too tedious to test" | Testing is less tedious than debugging bad skill in production. |
| "I'm confident it's good" | Overconfidence guarantees issues. Test anyway. |

**All of these mean: Test before deploying. No exceptions.**

## Red Flags - STOP and Start Over

- Skill written before pressure scenarios
- Code before test
- "I already manually tested it"
- "It's about spirit not ritual"
- "This is different because..."
- Editing a skill without re-running its scenarios

## STOP: Before Moving to Next Skill

**After writing ANY skill, you MUST STOP and complete the deployment process.**

**Do NOT:**
- Create multiple skills in batch without testing each
- Move to next skill before current one is verified
- Skip testing because "batching is more efficient"

Deploying untested skills = deploying untested code. It's a violation of quality standards.

## Skill Creation Checklist (TDD Adapted)

**RED Phase - Write Failing Test:**
- [ ] Create pressure scenarios at `tests/pressure/<skill>/scenarios.md` + `pass-criteria.md` (minimum 2: skip-temptation + misleading-execution; adversarial-abuse for gating rules)
- [ ] Run scenarios WITHOUT skill - document baseline behavior verbatim
- [ ] Identify patterns in rationalizations/failures

**GREEN Phase - Write Minimal Skill:**
- [ ] Attribution header line present (adaptations): `Adapted from obra/superpowers (MIT) — https://github.com/obra/superpowers`
- [ ] Name uses only letters, numbers, hyphens (no parentheses/special chars)
- [ ] YAML frontmatter with required `name` and `description`
- [ ] Description starts with "Use when..." and describes ONLY triggering conditions (never the workflow)
- [ ] Style-guide compliance (spec §8): plain text by default, markup budget, iron laws carry definition/obligation/exception
- [ ] Recurring rules use verbatim wording (Global Constraint 5)
- [ ] Address specific baseline failures identified in RED
- [ ] Run scenarios WITH skill - verify agents now comply

**REFACTOR Phase - Close Loopholes:**
- [ ] Identify NEW rationalizations from testing
- [ ] Add explicit counters (if discipline skill)
- [ ] Build rationalization table from all test iterations
- [ ] Create red flags list
- [ ] Re-test until bulletproof

**Parking:**
- [ ] Unripe skill ships with `metadata.status: useless-now`, never deleted

**Deployment:**
- [ ] Verify with `tests/run.sh <skill>` (and `--live` for entry skills)
- [ ] Commit skill to git
