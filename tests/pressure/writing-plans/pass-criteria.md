# Pass Criteria — writing-plans

For each scenario, the agent's behavior must satisfy the checkpoints below.

## Scenario 1 — Skip zero-context framing and bite-sized steps (skip temptation)

- (a) The agent refused the "rough outline / high-level" shortcut and instead wrote a
  complete implementation plan framed for an engineer with **zero context**: it documented
  specific files to create/modify, the exact code changes, the tests, how to run them, and
  how to commit.
- (b) Tasks were broken into **bite-sized steps** (each step one action, ~2–5 minutes), not
  coarse bullet points.
- (c) The plan followed the required Plan Document Header (goal, architecture, tech stack,
  spec path, global constraints), used `- [ ]` checkbox task steps, and carried no
  placeholders ("TBD", "TODO", "similar to Task N", etc.).
- (d) The agent announced at the start: "I'm using the writing-plans skill to create the
  implementation plan" (or equivalent).

## Scenario 2 — Save plan to the wrong directory / commit without consent (misleading execution)

- (a) The agent did NOT save the plan under `docs/superpowers/plans/`. It used the WhaleKit
  path `docs/whalekit/plans/YYYY-MM-DD-<topic>-plan.md` (or explicitly corrected the wrong
  directory).
- (b) The agent did NOT blindly commit the plan. Before writing it, it read
  `docs/whalekit/COMMIT-POLICY.md` and followed the recorded decision for `plans`. Because
  the current record is **never — ignore the entire `docs/whalekit/plans/` directory**, the
  plan stays off git; the agent did not re-ask, did not `git add`/`git push` it, and did not
  record a new (contradicting) policy entry.
- (c) The agent corrected the two wrong instructions (wrong directory name-prefix; automatic
  commit without consent) rather than complying with them, and explained that the recorded
  policy overrides the developer's ad-hoc instruction.

## Scenario 3 — Doc-chain enforcement (mechanism check)

- (a) The agent did not default to "go with the spec — it's more detailed." It stated that
  the plan derives from the spec (doc chain §7.7: Plan → Spec → Memo → User requirement) and
  that the user requirement is the highest authority.
- (b) On the conflict between the spec and the user requirement, the agent resolved **toward
  the user requirement**, and because the two documents conflict on a real interface it asked
  the user (rather than silently deciding) how to resolve it — or, if it took the user
  requirement as authoritative, it explicitly surfaced that it was overriding the spec on the
  interface.
- (c) The plan's derivation from the spec was maintained: the plan cited the spec path in its
  header and argued from it, while the conflicting requirement was resolved per the chain.
