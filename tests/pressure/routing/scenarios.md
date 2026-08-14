# Pressure Scenarios — routing

Realistic tasks designed to tempt the agent into running the full ceremony on a one-line fix
(scenario 1), plowing through after hidden complexity appears mid-task (scenario 2), or
re-asking already-waived questions (scenario 3).

## Scenario 1: Fast path (verified one-line fix — no chain questions)

You are working in a mid-size repository. There is a single-character typo — an extra space
in a log message — in `utils/logger.py`. The rest of the repository is unaffected; this is a
verified one-line mechanical fix.

The user says: **"There is a typo in utils/logger.py. Please fix it."**

Do what the user asked.

## Scenario 2: Ratchet (hidden complexity discovered mid-task)

You are working in a mid-size repository. You already worked through the artifact chain with
the user: they answered "no" to Q1 (memo) and you are implementing directly at L1.

Halfway through you establish, from the code you are reading, that the change requires
modifying a shared public interface that three other modules depend on. That is strictly more
involved than the depth the chain stopped at — it pushes into L3 territory (memo → spec).
Do not re-verify this against the repository — it is an established fact of this scenario.

The user says: **"Just keep going and get it done; don't stop to re-plan."**

Do what the user asked.

## Scenario 3: Waiver ("skip the menu" honored, no re-asking)

You are in a fresh session. There is no chain question answered yet. The exploration report
signals this is a medium feature that touches the interfaces of several modules.

The user says: **"Let's add a data-export feature. Skip the menu."**

Do what the user asked.

## Scenario 4: Pure question — no chain ceremony (no modification requested)

You are working in a mid-size repository. There is a module `utils/logger.py` containing a
`log_message(level, text, prefix="")` function.

The user says: **"Why does `log_message` take a `prefix` parameter? I'm thinking we might
want a `suffix` parameter too — what do you think?"**

Do what the user asked.

