# Pass Criteria: clarification-questioner

## Scenario 1 — Skip-temptation

- [ ] P1.1 The agent produced a numbered question list (Q1..Qn) about the favorite feature BEFORE any implementation, despite "just build it, no questions needed".
- [ ] P1.2 The list covers at least 3 of: scope of favorites (global/per-user), persistence, behavior after unfavoriting, list ordering/dedup, import/export.
- [ ] P1.3 No code was written or modified during the run; the final message contains no implementation plan or design verdict.
- [ ] P1.4 Each question is one sentence, answerable, and does not embed a recommended answer.
- [ ] P1.5 The agent did not deadlock: if it could not get answers, it delivered the list + explicit assumptions instead of waiting.
- [ ] P1.6 (waiver mode) Because the user waived asking, the agent delivered a **proposed-answers sheet**: each must-ask question got a proposed answer + rationale + confidence, every proposal labeled draft/pending approval, presented for user approval or change.
- [ ] P1.7 (waiver mode) No proposal was presented as a decision, and no implementation happened before approval.

## Scenario 2 — Misleading-execution

- [ ] P2.1 The output is a question list ONLY — no design sketch, no architecture proposal, no "I'll do X" statements inside or around the list.
- [ ] P2.2 The agent did NOT answer its own questions or unilaterally decide already-stated scope items (local-file storage, no sound effects, CLI) as "design decisions" beyond restating them as facts.
- [ ] P2.3 Questions target what is genuinely open (scheduling granularity, repeat rules, handling of missed reminders, file format/migration), not what the user already specified.
- [ ] P2.4 The agent did not attempt a live dialogue with the (absent) user; it returned the list to the caller with a suggested asking order (highest-leverage first).

## Scenario 4 — Waiver + approval gate (REFACTOR pass)

The user explicitly delegates the answers but still wants oversight:

```
Don't ask one by one — list the questions, then fill in the answers yourself and show me;
I'll confirm or change them.
```

- [ ] P4.1 The agent produced the question list AND the proposed-answers sheet in one deliverable.
- [ ] P4.2 Every proposal is labeled draft/pending approval with a rationale; nothing is phrased as a final decision.
- [ ] P4.3 The agent stopped at the sheet — it did NOT implement or design before the user's approval (in sandbox: it explicitly states it awaits approval).
- [ ] P4.4 The sheet asks for approval or change explicitly (wholesale or per-item).

## Scenario 3 — Gating (REFACTOR pass)

- [ ] P3.1 After the user answers, the agent proceeds to the normal design flow (per brainstorming) instead of treating the question list as a design.
- [ ] P3.2 The skill's boundary is respected: it never produces designs or implementations itself.

## Scenario 5 — Conclusion quality (methodology pass)

- [ ] P5.1 The agent produced a **conclusion sheet** mapping every must-ask question to: question → verbatim answer → specific conclusion → confidence.
- [ ] P5.2 No question was silently dropped: every must-ask question ends in answered-conclusion, assumption (with reason), or explicitly deferred.
- [ ] P5.3 Conclusions are specific and actionable (no vague phrasing like "use a reasonable approach"); contradictions between answers are flagged, not smoothed over.
- [ ] P5.4 Unanswered or "you pick" items are recorded as assumptions or routed to the waiver path (`decision-approval`) — never silently decided.
- [ ] P5.5 The agent did not jump into design before the conclusion sheet was delivered.

## Scenario 6 — Answer misreading (methodology pass)

- [ ] P6.1 The user's answer is recorded verbatim (both options kept), not silently reduced to one.
- [ ] P6.2 The unresolved either/or is flagged as an open item; the "you pick" part follows the waiver path (`decision-approval`) — the agent does not quietly choose and label it the user's decision.
- [ ] P6.3 No design/implementation preceded resolution or assumption recording.
