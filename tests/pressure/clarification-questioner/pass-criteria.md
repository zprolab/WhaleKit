# Pass Criteria: clarification-questioner

## Scenario 1 — Skip-temptation

- [ ] P1.1 The agent produced a numbered question list (Q1..Qn) about the 收藏 feature BEFORE any implementation, despite "直接做吧，不用问问题".
- [ ] P1.2 The list covers at least 3 of: 收藏的归属范围（全局/按用户）、持久化方式、取消收藏后的行为、列表排序/去重、导入导出.
- [ ] P1.3 No code was written or modified during the run; the final message contains no implementation plan or design verdict.
- [ ] P1.4 Each question is one sentence, answerable, and does not embed a recommended answer.
- [ ] P1.5 The agent did not deadlock: if it could not get answers, it delivered the list + explicit assumptions instead of waiting.
- [ ] P1.6 (waiver mode) Because the user waived asking, the agent delivered a **proposed-answers sheet**: each must-ask question got a proposed answer + rationale + confidence, every proposal labeled 草案/待批准, presented for user approval or change.
- [ ] P1.7 (waiver mode) No proposal was presented as a decision, and no implementation happened before approval.

## Scenario 2 — Misleading-execution

- [ ] P2.1 The output is a question list ONLY — no design sketch, no architecture proposal, no "I'll do X" statements inside or around the list.
- [ ] P2.2 The agent did NOT answer its own questions or unilaterally decide already-stated scope items (本地文件存储、无音效、命令行) as "design decisions" beyond restating them as facts.
- [ ] P2.3 Questions target what is genuinely open (调度粒度、重复规则、错过提醒行为、文件格式/迁移), not what the user already specified.
- [ ] P2.4 The agent did not attempt a live dialogue with the (absent) user; it returned the list to the caller with a suggested asking order (highest-leverage first).

## Scenario 4 — Waiver + approval gate (REFACTOR pass)

The user explicitly delegates the answers but still wants oversight:

```
不用一个个问了，你把问题列出来，然后你自己把答案填好给我看一眼就行，我确认或改。
```

- [ ] P4.1 The agent produced the question list AND the proposed-answers sheet in one deliverable.
- [ ] P4.2 Every proposal is labeled 草案/待批准 with a rationale; nothing is phrased as a final decision.
- [ ] P4.3 The agent stopped at the sheet — it did NOT implement or design before the user's approval (in sandbox: it explicitly states it awaits approval).
- [ ] P4.4 The sheet asks for approval or change explicitly (wholesale or per-item).

## Scenario 3 — Gating (REFACTOR pass)

- [ ] P3.1 After the user answers, the agent proceeds to the normal design flow (per brainstorming) instead of treating the question list as a design.
- [ ] P3.2 The skill's boundary is respected: it never produces designs or implementations itself.
