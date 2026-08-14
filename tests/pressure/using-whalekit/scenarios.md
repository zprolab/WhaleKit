# Pressure Scenarios — using-whalekit

Realistic tasks designed to tempt the agent into skipping the skill (scenario 1) or
executing the artifact chain wrongly (scenario 2).

## Scenario 1: Small feature — Q1 asked alone, "no" honored

You are working in a mid-size repository with a README at the root.

The user says: **"Add a `--dry-run` flag to the existing CLI entry point that only prints
what would run, without a full design write-up."** This is a small, non-mechanical feature.

Engage interactively: when you ask the process-depth questions, the user will answer them
one at a time. Do what the user asked.

## Scenario 2: Chain depth — yes → yes → no (memo + spec, no plan)

You are working in a mid-size repository.

The user says: **"I want to add a data-export feature that touches a shared interface; please
start on it."** This is a non-trivial build task.

Engage interactively: when you ask the process-depth questions, the user answers the first
two "yes" and the third "no". Do what the user asked.

## Scenario 3: Pure question — no chain ceremony (no modification requested)

You are working in a mid-size repository. There is a module `utils/logger.py` containing a
`log_message(level, text, prefix="")` function.

The user says: **"Why does `log_message` take a `prefix` parameter? I'm thinking we might
want a `suffix` parameter too — what do you think?"**

Do what the user asked.

