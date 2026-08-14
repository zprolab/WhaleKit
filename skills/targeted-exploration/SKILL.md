---
name: targeted-exploration
description: Use when a non-trivial task needs understanding of a fixed target (module, file, question, or whole project) before process selection
---

# Targeted Exploration

## 1. Target Declaration

1.1 Before exploring, write an exploration brief and show it to the user in exactly this form, with these three lines, each prefixed literally with `Target:`, `Question:`, and `Budget:`:

```
Target: <module|file|question|whole project>
Question: <what must be learned>
Budget: <max steps>
```

1.2 The target must be an explicit point — a module, a file, a question, or the whole project — written down before any exploration begins. Substitute a concrete value for each placeholder; do not leave a placeholder unresolved.

1.3 An exploration begun without a declared `Target:` and `Budget:` is a violation of this skill.

## 2. Dispatch the Exploration Subagent

2.1 **Explore by delegation, never personally.** Dispatch one fresh exploration subagent to do the reading. Your own context stays clean for coordination and tier recommendation. A subagent dispatched without a self-contained brief is a violation.

2.2 The dispatch prompt must be self-contained — the exploration subagent has no access to your session history. It must carry all of the following:

  1. The brief verbatim — the three `Target:` / `Question:` / `Budget:` lines.
  2. The exploration scope and the hard step budget (the subagent stops at the budget even if its report feels incomplete).
  3. The report contract: the four required sections (§4) and the report file path.
  4. The stop condition: stop early when the evidence answers the `Question` with confidence.

2.3 Never paste your session history, prior exploration summaries, or unrelated conversation into the dispatch. The subagent needs its brief, the target location, and the report contract. Nothing else.

2.4 The exploration subagent never dispatches subagents (no-subagents contract) — it reads and reports, and any further delegation is a violation.

2.5 The exploration subagent is sandboxed: no human is available to answer its questions. It records each question, the assumption it made, and its confidence (high/medium/low), and delivers the question list with its report.

## 3. Collect and Use the Report

3.1 The exploration subagent writes its complete report to the report file path given in the dispatch (e.g. `/tmp/explore-report-<target>.md`) and returns that path plus a short status.

3.2 Read the report file yourself. Deliver the report to the user and use it for the tier recommendation — never on impression. A report missing any of the four required sections is not a valid targeted-exploration report; send it back for completion, do not accept it.

## 4. Report Format

Deliver the exploration report with exactly these four labeled sections, in this order, using the exact headings below. Every report must carry all four; a report missing any section is not a valid targeted-exploration report.

4.1 `Findings` — a numbered list of what was learned about the target.

4.2 `Evidence` — concrete `file:line` references supporting each finding. Cite only target-relevant evidence.

4.3 `Risks` — a numbered list of risks the exploration surfaced, each tagged with a severity: `[low]` / `[medium]` / `[high]`.

4.4 `Scope estimate` — files touched, interfaces affected, and a tier signal L1–L5 (spec §5.2).

## 5. Recurring Rule

> **Tier recommendations for non-trivial tasks must be based on a targeted-exploration report, never on impression.**

## 6. Common Rationalizations

| Excuse | Reality |
|---|---|
| "It's a small bug, I'll just read the file myself — dispatching is overhead" | Personal exploration pollutes your context and skips the isolation that makes the report trustworthy. Dispatch the subagent. |
| "I know this codebase, I can skip the exploration" | The recurring rule does not know your familiarity. Report or no recommendation. |
| "The subagent needs my history to understand the task" | It needs the brief, the target, and the report contract — a self-contained dispatch is enough. |
| "The user is in a hurry, I'll answer from the top of my head" | The gate holds under pressure: recommendation rests on the exploration report, never on impression. |
| "I explored a bit myself, that's basically the same" | Delegation is the mechanism. A report written from personal exploration is not a delegated exploration. |
