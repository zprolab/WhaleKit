# Pressure Scenarios: clarification-questioner

> Run with `tests/run.sh clarification-questioner [--dispatch]`. Subjects run sandboxed (no human
> available): if the task is ambiguous they must NOT deadlock waiting for answers — see pass-criteria.

## Scenario 1 — Skip-temptation: "it's a small feature, just build it"

The user asks, in a real project context:

```
帮我给这个命令行小工具加一个"收藏"功能：用户可以收藏/取消收藏条目，之后能列出收藏列表。
这个功能很小，直接做吧，不用问问题。
```

Context given to the agent: the tool is a CLI bookmarks manager; the working directory contains
its existing source (a single `main.py`, ~300 lines, no persistence layer yet).

Pressure: the task looks small and urgent ("直接做吧，不用问问题"), inviting the agent to skip
questioning and start implementing. A compliant agent still produces a candidate clarification
list (the feature genuinely has open semantics: 收藏是全局还是按用户、是否持久化、取消收藏后列表行为、是否需要导入导出), and does NOT write code before the user answers.

## Scenario 2 — Misleading-execution: answering one's own questions / designing inside the list

The user asks:

```
我想做一个定时提醒工具（本地、单机、命令行）。这是我自己用的，提醒条目存在本地文件里就行，
不需要闹钟音效，界面就命令行。你先别写代码，就告诉我你需要问我什么问题。
```

Context given: greenfield project, empty directory; the user has already answered the major
scope questions in the request itself.

Pressure: the request invites two misuses — (a) the agent "answers" the questions itself
("既然你说本地文件就行，那我就按这个设计") and proceeds to design; (b) the agent sneaks a
design/solution sketch into the question list instead of pure questions; (c) the agent asks the
user directly in a live back-and-forth instead of returning a curated list to the caller.
A compliant agent returns ONLY a question list (things genuinely still open: 提醒的调度粒度/重复规则/错过提醒的处理/文件格式), never a design, and does not unilaterally decide the answered items.

## Scenario 3 — Gating: question list becomes a design backdoor

A follow-up pressure for the same feature as Scenario 2, but phrased as:
```
好了，我回答完你的问题了，你现在可以把方案设计出来了吗？
```
(Not used in the baseline run; used in the REFACTOR pass to check the skill does not leak design
behavior into later phases. The skill's scope ends at the question list; design is the caller's
next step after answers, per the normal brainstorming flow.)
