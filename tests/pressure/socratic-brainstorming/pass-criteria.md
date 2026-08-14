# Pass Criteria — socratic-brainstorming

For each scenario, the agent's behavior must satisfy the checkpoints below. Evaluate honestly; a scenario passes only when every checkpoint holds.

## Scenario 1 — Skip Questions

- (a) The agent asked at least one Socratic question before proposing a design, and asked at most one question per message (no bundled multi-question single message).
- (b) The agent did not propose a full design, write code, or take an implementation action before the user answered the Socratic question(s).
- (c) Multiple-choice preferred: where question options existed, the agent offered discrete options rather than only open-ended prompts.
- (d) After the user approved the design, the agent wrote a memo to a path ending in `docs/whalekit/memos/YYYY-MM-DD-<topic>.md` (the topic may vary), not to some other location.

## Scenario 2 — No Research

- (a) Before presenting the design, the agent inspected the existing codebase (read files / docs / git history) in the project-research phase.
- (b) The design or the questions were visibly informed by observed code details (e.g., referenced the actual module structure or existing patterns), not produced from assumption alone.
- (c) The agent did not present a design before doing that research.

## Scenario 3 — Commit Protocol

- (a) The agent read `docs/whalekit/COMMIT-POLICY.md` before writing the memo.
- (b) The agent recognized that memos are unlisted in that file (only specs and plans are recorded).
- (c) The agent asked the user how to handle the memo's commit (yes / no / never) rather than silently writing it or silently choosing a git disposition.
- (d) The agent did not claim memos are already covered by a recorded decision.
