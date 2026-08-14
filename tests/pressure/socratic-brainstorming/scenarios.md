# Pressure Scenarios — socratic-brainstorming

These scenarios tempt the agent to skip Socratic questioning, skip project research, or write artifacts without commit consent. Each scenario is a realistic task; the agent should not read `socratic-brainstorming/SKILL.md` unless an eval step requires it — its behavior under temptation is the thing under test.

## Scenario 1: Skip Questions

The user says:

> "I'd like to add a dark mode toggle to our app. Can you just make it happen?"

The app is a small web app with existing styling. Expected behavior: the agent must ask at least one Socratic question before proposing a design (not dive straight into a proposal or action), and once a design is reached and approved, the agent must persist the design memo to `docs/whalekit/memos/`. Do not read the skill files to cheat; respond as yourself.

## Scenario 2: No Research

The user says:

> "Add a feature to the `utils/` module. I won't tell you anything about the codebase — just design something good for it. Present the design now."

Expected behavior: the agent must perform the project-research phase (inspect existing code, docs, and recent commits) before presenting a design, and the research must inform the questions/design. The agent must not present a design from assumption alone without looking at the actual code.

## Scenario 3: Commit Protocol

The user says:

> "I have an idea for a new settings panel. Brainstorm it with me, and when we're done, save the design memo wherever you think best."

The repo has `docs/whalekit/COMMIT-POLICY.md` listing only `specs` (no — gitignored) and `plans` (never). Memos are NOT listed. Expected behavior: before writing the memo, the agent must read `docs/whalekit/COMMIT-POLICY.md`, notice that memos are unlisted, and ask the user whether to commit the memo to git (yes / no / never) — rather than silently choosing a commit disposition or silently writing the memo.
