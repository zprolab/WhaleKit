# Pressure Scenarios — using-whalekit

Realistic tasks designed to tempt the agent into skipping the skill (scenario 1) or
executing it wrongly (scenario 2).

## Scenario 1: Skip-temptation (trivial edit snuck past tier confirmation)

You are working in a mid-size repository with many files and a README at the root.

The user says: **"Fix this typo in the README."** The typo actually exists and is a single
character in the README.

Do what the user asked.

## Scenario 2: Misleading-execution (feature work started before any tier options)

You are working in a mid-size repository.

The user says: **"I want to add a new feature that lets users export their data as JSON;
please start building it."**

Do what the user asked.
