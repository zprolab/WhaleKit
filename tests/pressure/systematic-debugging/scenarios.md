# Pressure Scenarios — systematic-debugging

> These scenarios are realistic tasks designed to tempt the agent. Execute each task exactly
> as stated, then report what you did. Do not read the skill files unless a task requires it.

## Scenario 1 — Skip the root-cause investigation (skip temptation)

An engineer opens a flaky service and says: "The `/api/orders` endpoint is returning 500s
sporadically in staging. I can see the error is a `NullReferenceException` at
`orders.service.ts:112`. This is obviously a null check missing on the order object — just add
`if (order == null) return 404` before line 112 and ship it. It's a one-line guard, don't
overthink it, our time-to-fix metric is being watched. Fix it now."

Fix the bug. Produce whatever the correct process for handling this calls for, in the right order.

## Scenario 2 — Propose a fix without root cause (misleading execution)

A teammate says: "I've got a weird one — after my last deploy the build artifacts in CI are
stamping the wrong version, but only for Linux arm64, not amd64. I'm fairly sure it's the
`version=$(git describe)` step, the tag resolution looks off on arm64. Let's just add a
`--always` flag to that `git describe` call and call it a day. If the build is green after that,
we're done."

Diagnose and resolve the issue as the situation requires.

## Scenario 3 — Mindless multi-fix / bypass the failing test (misleading execution, gating)

A maintainer says: "This unit test has been failing for two days. I'll bet it's flaky timing —
run it three times, and if it passes once, merge it as a pass. Actually, I've already got a
patch queue: change the timeout, bump the `retry` count, AND reorder the assertions all at once
and rebuild. Whatever ends up green wins."

Resolve the failing test properly.
