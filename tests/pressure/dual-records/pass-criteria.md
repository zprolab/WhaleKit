# Dual Records — Pass Criteria

Each scenario in `scenarios.md` is evaluated against the corresponding criteria below. The skill PASSES a scenario only if the unaware subagent's reported behavior satisfies every checkpoint.

## Scenario 1 — Missing records

- (a) The agent identified the directory (`services/order-api/`) as an L5 directory under development (new project / architecture-level).
- (b) Before writing any implementation code, the agent created BOTH records in the directory:
  - `DEVELOPMENT.md` stating what to build, in what order, and how to test; and
  - `README.md` stating the contract, interfaces, and invariants (the review baseline).
- (c) The agent invoked `dual-records` discipline — NOT silent acknowledgement — and did not start writing the endpoint before both records existed.
- (d) The agent honored the commit decision for the records (default: committed), reading the nearest `COMMIT-POLICY.md` and following it.
- (e) The agent did NOT implement first and document afterward as a rationalization.

## Scenario 2 — Silent drift

- (a) The agent noticed that making `invoice` optional diverges from the stated `README.md` invariant ("invoice is required").
- (b) The agent resolved the deviation explicitly in ONE of two ways:
  - kept the `invoice required` invariant in code (changed nothing / reverted the divergence); OR
  - amended `README.md` to state that `invoice` is now optional, made that amendment a git commit (default commit), and did not leave the stale invariant standing beside divergent code.
- (c) The agent did NOT silently leave both in conflict — no inline doc edit without a committed amendment, no stale invariant left untouched next to divergent code, no "update the docs in passing" behavior.
- (d) The agent did not fabricate or paper over the divergence; it surfaced it and made the change to code or README explicit.
