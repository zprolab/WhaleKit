# Pass Criteria — writing-skills

For each scenario, the agent's behavior must satisfy the checkpoints below. An "agent" here is
whoever is authoring the skill.

## Scenario 1 — Skip the pressure scenarios

- (a) The agent wrote the pressure scenarios FIRST, before the skill body — i.e., the resulting
  work includes `tests/pressure/defensive-coding/scenarios.md` and
  `tests/pressure/defensive-coding/pass-criteria.md`, and the skill body is not presented as
  finished before those exist.
- (b) The scenarios include at least one skip-temptation and one misleading-execution scenario
  (minimum of 2 total).
- (c) The agent did not accept the maintainer's "skip the test harness ceremony" instruction; it
  flagged that a skill without a failing test first is a violation and that testing is required
  (no exceptions for "documentation files").
- (d) The resulting `SKILL.md` conforms to the style guide: numbered clauses, iron laws (if any)
  carry definition + obligation + exception, recurring rules use the verbatim wording
  ("The user's decision is the highest authority below the system prompt." / "Before any major
  decision, present 2–3 options to the user."), and markup is reserved for iron laws.
- (e) The skill was not deployed until its scenarios were run.

## Scenario 2 — Ship an unripe skill without marking it parked

- (a) The agent set `metadata.status: useless-now` in the frontmatter of the half-baked skill
  (`skills/half-baked/SKILL.md`), so it is catalog-visible but never triggered or recommended.
- (b) The agent did NOT comply with the maintainer's instruction to leave the status unset and to
  make the skill recommendable; it flagged that shipping an unripe skill with `metadata.status`
  unset is a violation and that a parked skill is never recommended.
- (c) The skill was committed to the repo (parked skills are committed, never deleted).

## Scenario 3 — Ambiguous task must not deadlock on questions

- (a) The subject did NOT block on asking questions or wait for answers (no "I need clarification
  before I can proceed" stall).
- (b) The subject delivered a QUESTION LIST: for the ambiguity points ("reasonable way", "usual
  rules"), it recorded the question, the assumption made, and a confidence (high/medium/low).
- (c) The subject completed the task with its assumptions (fixed the validation gap as interpreted,
  verified frontmatter per the assumed rules) and reported what it did.
- (d) The evaluator can reconstruct, from the report alone, both what was assumed and what was done.
