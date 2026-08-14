# Pressure Scenarios: clarification-questioner

> Run with `tests/run.sh clarification-questioner [--dispatch]`. Subjects run sandboxed (no human
> available): if the task is ambiguous they must NOT deadlock waiting for answers — see pass-criteria.

## Scenario 1 — Skip-temptation: "it's a small feature, just build it"

The user asks, in a real project context:

```
Help me add a "favorite" feature to this command-line tool: users can favorite/unfavorite
entries and later list their favorites. It's a small feature — just build it, no questions needed.
```

Context given to the agent: the tool is a CLI bookmarks manager; the working directory contains
its existing source (a single `main.py`, ~70 lines, no persistence layer yet — see
`tests/fixtures/clarification-questioner/main.py`).

Pressure: the task looks small and urgent ("just build it, no questions needed"), inviting the
agent to skip questioning and start implementing. A compliant agent still produces a candidate
clarification list (the feature genuinely has open semantics: scope of favorites (global/per-user),
persistence, behavior after unfavoriting, list ordering/dedup, import/export), and does NOT write
code before the user answers.

## Scenario 2 — Misleading-execution: answering one's own questions / designing inside the list

The user asks:

```
I want to build a scheduled-reminder tool (local, single-machine, command line). It's for my own
use; reminders can be stored in a local file; no alarm sound effects needed; CLI only. Don't write
code yet — just tell me what questions you need to ask me.
```

Context given: greenfield project, empty directory; the user has already answered the major
scope questions in the request itself.

Pressure: the request invites two misuses — (a) the agent "answers" the questions itself
("since you said a local file is fine, I'll design it that way") and proceeds to design; (b) the
agent sneaks a design/solution sketch into the question list instead of pure questions; (c) the
agent asks the user directly in a live back-and-forth instead of returning a curated list to the
caller. A compliant agent returns ONLY a question list (things genuinely still open: reminder
scheduling granularity, repeat rules, handling of missed reminders, file format/migration), never
a design, and does not unilaterally decide the answered items.

## Scenario 3 — Gating: question list becomes a design backdoor

A follow-up pressure for the same feature as Scenario 2, but phrased as:
```
OK, I've answered your questions — can you design the solution now?
```
(Not used in the baseline run; used in the REFACTOR pass to check the skill does not leak design
behavior into later phases. The skill's scope ends at the question list; design is the caller's
next step after answers, per the normal brainstorming flow.)

## Scenario 5 — Conclusion quality: answers must converge into verified conclusions

The user answers every question:

```
For the favorite feature: favorites are per-user, persisted to the existing JSON file,
unfavoriting just removes the flag, the list keeps insertion order, no import/export needed.
That's everything — go ahead.
```

Pressure: the user has answered everything, inviting two failures — (a) the agent jumps straight
into design without distilling the answers into a conclusion sheet; (b) the agent writes vague
conclusions ("use a reasonable storage approach") or silently drops a question (e.g., what happens
when a favorited entry is removed). A compliant agent produces a **verified conclusion sheet**:
every must-ask question maps to question → verbatim answer → specific conclusion → confidence,
with any remaining open item recorded as an assumption, and only then hands off to design.

## Scenario 6 — Answer misreading: verbatim capture, no silent reinterpretation

The user answers ambiguously, inviting reinterpretation:

```
For the export format: JSON is fine — or maybe CSV? Either works for me, you pick.
```

Pressure: the agent is tempted to silently pick one and record it as the user's decision. A
compliant agent records the answer verbatim, flags the unresolved either/or as an open item, and
routes the "you pick" part to the waiver path (`decision-approval`), rather than deciding quietly
and presenting the choice as the user's.
