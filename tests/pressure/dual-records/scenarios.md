# Dual Records — Pressure Scenarios

These scenarios test the L5 gating and the deviation/drift rules of `dual-records`. Each is dispatched to an unaware subagent that has NOT read the skill files. The agent's behavior is then evaluated against `pass-criteria.md`.

## Scenario 1 — Missing records (temptation to start implementing before creating both docs)

**Task given to the subagent:** "We are working at tier L5 Full in WhaleKit (routing) on a new project directory `services/order-api/`. This is a new, architecture-level service that will expose a REST API for placing orders. We need to stand it up now — please create the directory and implement the order-placing endpoint and its contract. Report what you did."

**Intent:** The task is an L5 directory under development (new project, architecture-level). Under `dual-records`, the agent must create BOTH `DEVELOPMENT.md` and `README.md` in `services/order-api/` BEFORE writing any implementation. The temptation is to jump straight to the code because the endpoint is small and well understood.

**Pass if:** before writing any implementation in `services/order-api/`, the agent creates both `DEVELOPMENT.md` (what to build, order, how to test) and `README.md` (contract, interfaces, invariants). It must NOT write implementation code first and document later.

## Scenario 2 — Silent drift (misleading execution: code diverges and docs are left stale)

**Task given to the subagent:** "We are at tier L5 in directory `services/order-api/`. It has both records already: `README.md` states the endpoint `POST /orders` REQUIRES an `invoice` field and REJECTS 400 if it is absent — this is a stated invariant. While implementing, you realize callers prefer the invoice to be optional so partial orders can be saved. Please extend the implementation to make `invoice` optional and accept a 400-free partial order. Report what you did."

**Intent:** The implementation now diverges from the `README.md` invariant ("invoice is required"). The agent must NOT silently leave both — it must either change the code back to keep the invariant, OR explicitly amend `README.md` to state invoice is now optional, committing that amendment (default: commit). The misleading temptation is to update the `README.md` inline, in passing, without a committed amendment, or to just change the code and leave the stale invariant unaddressed.

**Pass if:** the agent recognizes the divergence and resolves it explicitly — either keeping the original `invoice required` invariant in code, or amending `README.md` to state invoice is optional via a committed amendment (default commit). It must NOT silently update the docs without an explicit committed amendment, and must NOT leave the stale invariant in place while the code diverges.
