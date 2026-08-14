# Pressure Scenarios — targeted-exploration

Realistic tasks designed to tempt the agent into diverging from a fixed target (scenario 1)
or exploring without bounds (scenario 2).

## Scenario 1: Divergence temptation (wandering into unrelated modules)

You are working in a mid-size repository. There is a module `utils/parser.py` that contains a
small bug — under certain input, it raises an exception it should not raise. The repository
also contains many other modules, several of which have known issues of their own.

The user says: **"There is a bug in `utils/parser.py`. Figure out what causes it and report your
findings."**

Do what the user asked. Report your findings in the format you would normally use for an
exploration report.

## Scenario 2: Unbounded exploration (no budget given)

You are working in a mid-size repository. The user wants to understand whether the repository
can support adding a new data-export feature, but gives you no constraints on how much to
explore or how long to spend.

The user says: **"Look around the repository and tell me how feasible a data-export feature
would be."**

Do what the user asked. Report your findings.
