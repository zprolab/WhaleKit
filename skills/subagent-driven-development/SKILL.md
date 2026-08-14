---
name: subagent-driven-development
description: Use when executing implementation plans with independent tasks in the current session
---

Adapted from obra/superpowers (MIT) — https://github.com/obra/superpowers

# Subagent-Driven Development

Execute a plan by dispatching a fresh implementer subagent per task, a task review (spec compliance + code quality) after each, and a broad whole-branch review at the end.

**Why subagents:** You delegate tasks to specialized agents with isolated context. By precisely crafting their instructions and context, you ensure they stay focused and succeed at their task. They should never inherit your session's context or history — you construct exactly what they need. This also preserves your own context for coordination work.

**Core principle:** Fresh subagent per task + task review (spec + quality) + broad final review = high quality, fast iteration

## Gating by Routing Tier

1.1 This skill applies when the task's routing tier admits it (see `routing`, spec §5.3) — it is gated to **L4 and L5**. At tiers below L4, a plan is not being executed at this process depth, so subagent-driven development is not automatically invoked; the tier-chosen process governs instead.

1.2 At L5 Full, the review baselines and the review route expand to the L5 disciplines of `dual-records` and `adversarial-review` (clauses 3.4 and 3.5 below). At L4, task and final reviews compare against the plan (and spec) only.

1.3 The one-way ratchet of `routing` still applies mid-task: if hidden complexity surfaces that the admitted tier does not cover, stop and upgrade the tier (re-present tier options, wait for the user's choice) rather than continuing at a too-low depth.

## Narration

Between tool calls, narrate at most one short line — the ledger and the tool results carry the record.

## Continuous Execution

Do not pause to check in with your human partner between tasks. Execute all tasks from the plan without stopping. The only reasons to stop are the four named below, or all tasks complete. "Should I continue?" prompts and progress summaries waste their time — they asked you to execute the plan, so execute it.

## Rulings, Not Stalls

A running plan does not wait on a human. Conflicts, ambiguities, plan defects, a cap you would have asked to exceed — decide them. The spec is the binding authority, the plan is its argument, and your judgment settles what neither answers. Record every decision in the ledger as `Ruling: <what you decided> — <why> — <what it costs if wrong>`, and keep going. A wrong ruling costs rework your human partner can see and undo; a session parked on a question costs their whole day and buys nothing.

Four things stop you, and only these: an irreversible or destructive operation; a security-sensitive action; a side effect outside this worktree that norms say you ask about first (a merge, a push to a shared branch, a publish); and a plan so broken that every path forward is a guess. For those, stop and ask.

## Doc Chain

On any conflict between documents during execution, resolve toward the higher-level document — the chain is `Dual → Plan → Spec → Memo → User requirement` (spec §7.7), with the user requirement as the golden standard. The plan derives from the spec; conflicts between a task and the plan's Global Constraints or the spec resolve toward the spec and ultimately the user requirement. When the higher document is **silent** or the later, more refined side is **clearly superior**, **ask the user** rather than deciding alone. The user's live decision outranks the chain.

## Setup

Ensure the work happens in an isolated workspace: use `whalekit:using-git-worktrees` to create one or verify the existing one. Never start implementation on a main/master branch without your human partner's explicit consent.

Conversation memory does not survive compaction. In real sessions, controllers that lost their place have re-dispatched entire completed task sequences — the single most expensive failure observed. Track progress in a ledger file, not only in todos.

- Each plan owns a workspace (`<repo-root>/.whalekit/sdd/<plan-basename>/`), home to every artifact for THIS plan: ledger, briefs, reports, review packages. Another plan's directory is never yours to read or write.
- Check for this plan's ledger at `<workspace>/progress.md`. If its first line names your plan file, tasks with a `Task <N>: complete` line are DONE — do not re-dispatch them; resume at the first task without one. A task whose last line is a fix round is mid-loop: resume the loop at the next round.
- Create the ledger with its identity as the first line: `# SDD ledger — plan: <plan file path>`.
- The ledger is your recovery map: the commits it names exist in git even when your context no longer remembers creating them. After compaction, trust the ledger and `git log` over your own recollection.
- `git clean -fdx` will destroy the workspace (it's git-ignored scratch); if that happens, recover from `git log`.

Read the plan once, note its context and Global Constraints, and create a todo per task. If the plan names a Spec, read that too: the spec is the authority the plan argues from, and conflicts inside the plan resolve against it. A plan with no reachable spec gets a ledger note saying so — rulings made without one are provisional.

Before dispatching Task 1, scan the plan once for conflicts, writing down what you checked as you check it:

- tasks that contradict each other or the plan's Global Constraints
- anything the plan explicitly mandates that the review rubric treats as a defect (a test that asserts nothing, verbatim duplication of a logic block)

The scan's output is a table, not a verdict. One row for every pair of tasks that share a file or an interface: the two tasks, what one produces against what the other consumes, and what you found. One row for every task: whether its own text agrees with itself — the tests it specifies against the code it specifies, the files it creates against the files it later touches. "The scan is clean" without those rows is not a scan you ran. Write the table to the ledger. Rule on everything you find before execution begins and record each ruling. The review loop remains the net for conflicts that only emerge from implementation.

## Model Selection

Use the least powerful model that can handle each role to conserve cost and increase speed.

**Mechanical implementation tasks** (isolated functions, clear specs, 1-2 files): use a fast, cheap model.

**Integration and judgment tasks** (multi-file coordination, pattern matching, debugging): use a standard model.

**Architecture and design tasks** and the **final whole-branch review**: use the most capable available model.

**Review tasks:** choose the model with the same judgment, scaled to the diff's size, complexity, and risk.

**Fix-loop escalation (rounds 4-5):** use a model at least one tier above the implementer that got stuck.

**Always specify the model explicitly when dispatching a subagent.** An omitted model inherits your session's model — often the most capable and most expensive — which silently defeats this section.

## The Task Loop

**Batch small same-shape work.** When the plan lists several tasks that are each a small, independent edit of the same kind, compose ONE dispatch brief listing every file and its change, send the whole batch to a single subagent, and review its diff as one unit. Reserve one-dispatch-per-task for work that needs its own judgment, its own tests, or its own review surface.

Everything you paste into a dispatch prompt — and everything a subagent prints back — stays resident in your context for the rest of the session and is re-read on every later turn. Hand artifacts over as files.

Much like `routing`'s one-way ratchet, a dispatched implementer never dispatches subagents (the no-subagents contract), and you never dispatch multiple implementation subagents in parallel (conflicts).

### 1. Dispatch the implementer

Record BASE (`git rev-parse HEAD`) before dispatching — the review package and fix-round diffs need it.

- **Task brief:** extract the task's full text to a uniquely named file and print the path. Compose the dispatch so the brief stays the single source of requirements. Your dispatch should contain: (1) one line on where this task fits in the project; (2) the brief path, introduced as "read this first — it is your requirements, with the exact values to use verbatim"; (3) interfaces and decisions from earlier tasks that the brief cannot know; (4) your resolution of any ambiguity you noticed in the brief; (5) the report-file path and report contract. Exact values (numbers, magic strings, signatures, test cases) appear only in the brief. Never make a subagent read the whole plan file.
- **Report file:** name the implementer's report file after the brief (brief `…/task-N-brief.md` → report `…/task-N-report.md`) and put it in the dispatch prompt. The implementer writes the full report there and returns only status, commits, a one-line test summary, and concerns.
- A dispatch prompt describes one task, not the session's history. Do not paste accumulated prior-task summaries into later dispatches. A fresh subagent needs its task, the interfaces it touches, and the global constraints. Nothing else.
- The dispatch carries the no-subagents contract: the implementer never dispatches subagents — not helpers, and never a reviewer. Review arrives from you, after the report.
- If an earlier task parked a finding in the area this task touches, carry a pointer to that ledger entry in the dispatch.
- Record the implementer's agent identity from the dispatch result — fix-loop rounds 1-3 resume this agent.
- Never dispatch multiple implementation subagents in parallel (conflicts).

### 2. Handle the report

Implementer subagents report one of four statuses. Handle each appropriately:

**DONE:** Generate the review package (from BASE to the current HEAD), then dispatch the task reviewer with the printed path.

**DONE_WITH_CONCERNS:** Read the concerns before proceeding. If they're about correctness or scope, address them before review. If they're observations (e.g., "this file is getting large"), note them and proceed.

**NEEDS_CONTEXT:** Provide the missing context and re-dispatch.

**BLOCKED:** Assess the blocker:
1. If it's a context problem, provide more context and re-dispatch with the same model
2. If the task requires more reasoning, re-dispatch with a more capable model
3. If the task is too large, break it into smaller pieces
4. If the plan itself is wrong, rule on the correction, ledger it, and re-dispatch with the ruling carried in the dispatch

**Never** ignore an escalation or force the same model to retry without changes. If the implementer said it's stuck, something needs to change.

If the implementer asks questions — before starting or mid-task — answer clearly and completely, provide additional context if needed, and don't rush it into implementation.

### 3. Review the task

Per-task reviews are task-scoped gates. The broad review happens once, at the final whole-branch review. Never skip the task review, and never accept a report missing either verdict — spec compliance AND task quality are both required. Implementer self-review never replaces the task review; both are needed.

3.1 Hand the reviewer its diff as a file: capture the commit list, stat summary, and full diff with context for the range into one uniquely named file, and pass the reviewer the file path. The output never enters your own context, and the reviewer sees the commit list, stat summary, and full diff with context in one Read call. Use the BASE you recorded before dispatching the implementer — never `HEAD~1`, which silently truncates multi-commit tasks. Never dispatch a task reviewer without a diff file.

3.2 **Reviewer inputs:** the task reviewer gets the same brief file, the report file, and the review package, plus the global constraints that bind the task. Copy the binding requirements verbatim from the plan's Global Constraints or the spec: exact values, exact formats, and the stated relationships between components. Do not add open-ended directives like "check all uses", do not ask a reviewer to re-run tests the implementer already ran on the same code, and do not pre-judge findings for the reviewer — never instruct a reviewer to ignore or not flag a specific issue.

3.3 The task reviewer may report "⚠️ Cannot verify from diff" items — requirements that live in unchanged code or span tasks. These do not block the rest of the review, but you must resolve each one yourself before marking the task complete: you hold the plan and cross-task context the reviewer lacks. If you confirm an item is a real gap, treat it as a failed spec review — it enters the fix loop with the other findings.

3.4 **Baseline (L5):** At tier L5 Full, the task review compares the implementation against the `dual-records` README.md — the amendable truth and the review baseline for the directory — in addition to the plan and spec. If the implementation deviates from the README.md contract or invariants, apply the deviation handling of `dual-records`: either change the code so it matches README.md, or deliberately amend README.md via a committed amendment. Silent doc drift is a violation.

3.5 **Review route (L5 architecture):** A review that surfaces an **architecture-level bug** — a decision affecting a final implementation conclusion, a possible technical-direction shift, or an architecture-level bug fix — escalates to `adversarial-review` **review mode** (spec §7.3): a fresh red finds bugs with file:line evidence, a fresh blue applies the fixes, and the fixed artifact is delivered. **Over-triggering is a violation**: a routine implementation review that §7.3 does not admit stays on the normal task-review route above. Escalate only for genuine architecture-level or direction-affecting reviews.

3.6 **Baseline and route at other tiers:** Below L5, task and final reviews compare against the plan (and spec) only; the dual-records README baseline does not apply, and no adversarial escalation is triggered by the routing tier alone.

### 4. The fix loop

The loop triggers when the review reports spec ❌, any Critical or Important finding, or a ⚠️ item you confirmed as a real gap.

Before the loop starts, two routes leave it immediately:

- Record Minor findings in the progress ledger as you go (`Task <N>: minor (deferred): <one-liner>`), and point the final whole-branch review at that list so it can triage which must be fixed before merge. A roll-up nobody reads is a silent discard. Minor findings never enter the loop.
- A finding labeled plan-mandated — or any finding that conflicts with what the plan's text requires — is yours to rule on: weigh the finding against the plan text, decide with the spec as the binding authority, and ledger the ruling before you act on it. Do not dismiss the finding because the plan mandates it, and do not dispatch a fix that contradicts the plan without a recorded ruling.

Everything else enters the loop. A fix round is one fix dispatch plus one scoped re-review. Five rounds maximum per task:

**Rounds 1-3 — resume the original implementer.** Send it the open findings verbatim. Its context is intact: it knows the task, the code, and its own choices. If your harness cannot send another message to a live subagent, dispatch a fresh implementer carrying the brief path, the report-file path, and the findings — the report file is the persistent memory either way.

**Rounds 4-5 — dispatch a fresh implementer on a more capable model**, with the brief path, the report-file path, the open findings, and this framing: "A prior implementer attempted this task [N] times; you own it now. Read the report file for what was tried." A loop that survives three resumes usually means the implementer cannot see its own problem — fresh eyes and a capability bump in one move.

**Every round, either way:** the implementer fixes, re-runs the tests covering the amended code, appends its fix report to the same report file, and returns the short contract. Before re-dispatching the reviewer, confirm the fix report contains the covering tests, the command run, and the output; dispatch the re-review once all three are present. Name the covering test files in the fix message — a one-line fix does not need the whole suite.

**The re-review is scoped.** The re-reviewer verdicts each finding ADDRESSED or NOT ADDRESSED and flags new breakage in the fix diff only. New Critical/Important breakage in the fix diff joins the open findings list. Out-of-scope observations go to the ledger as deferred minors — they never extend the loop.

**After each round,** append to the ledger:
`Task <N>: fix round <R>/5 (<X> addressed, <Y> open — <finding one-liners>; commits <a7>..<b7>)`

Never fix findings yourself in the controller session — your context stays clean for coordination, and controller fixes skip review.

**The breaker.** When round 5's re-review still leaves findings open, stop dispatching. Adjudicate each open finding yourself — you hold the plan and the cross-task context the reviewer lacks:

- **The reviewer is wrong, or the point is contestable:** park it — `Task <N>: parked — <finding> — Ruling: <why the code stands>`. The final review sees both sides.
- **Real, but nothing downstream builds on it:** park it the same way, with a ruling that says it's real and deferred.
- **Real and load-bearing** — a later task builds on it, or it reveals a plan defect: rule on the smallest change that unblocks the dependent work, ledger it as `Task <N>: Ruling: <finding> — <what you decided and why>`, and carry it into the next task's dispatch. Parking a structural failure silently lets every dependent task build on it. Stop only when the defect leaves every path forward a guess.

Adjudicate only at the cap. Adjudicating earlier to end a loop is pre-judging with a different name. Every adjudication is a ledger entry — a silent discard is forbidden.

### 5. Complete the task

When the review comes back clean — or every open finding is parked with a ruling at the cap — append the completion line to the ledger in the same message as your other bookkeeping:

- `Task <N>: complete (commits <base7>..<head7>, review clean)`
- `Task <N>: complete (commits <base7>..<head7>, <K> parked)` after a tripped breaker

Then mark the todo complete and move on. Never move to the next task while the review has open Critical/Important issues that are neither fixed nor parked-with-ruling at the cap.

## Final Review

The final whole-branch review gets a package too (MERGE_BASE = the commit the branch started from, e.g. `git merge-base main HEAD`). Dispatch it on the most capable available model (see Model Selection), using `whalekit:requesting-code-review`. Point it at the ledger's deferred-minor and parked lines so it can triage which must be fixed before merge. Apply the same L5 baseline (dual-records README.md) and adversarial escalation (§7.3, review mode only) that govern task reviews.

If the final whole-branch review returns findings, dispatch ONE fix subagent with the complete findings list — not one fixer per finding. Per-finding fixers each rebuild context and re-run suites. Then run exactly one scoped re-review of the fix wave. Adjudicate any residual findings as in the task loop's breaker: park with rulings, or rule on the load-bearing ones and ledger what you decided. Only the four stop classes above stop you here. There is no second fix wave — residual load-bearing findings surface to your human partner when finishing-a-development-branch presents the options.

## Finish

Before you delete anything, collect every ledger line containing `Ruling:` — preflight rulings, parked findings, breaker adjudications, all of them — into your final message under "Rulings I made", in the order you made them, each with what it costs if wrong. The list is exhaustive: if the ledger holds a ruling, the list holds it. That list is the only place the decisions you took on your human partner's behalf reach them — they read it and rework whatever you got wrong. A ruling that dies with the workspace was a decision made in secret.

When the final whole-branch review is clean and its fixes are merged, delete this plan's workspace (`rm -rf <workspace>`) — the git history is the record now. Sibling directories belong to other plans; leave them alone.

Use `whalekit:finishing-a-development-branch`.

> **The user's decision is the highest authority below the system prompt.**
>
> **Before any major decision, present 2–3 options to the user.**

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Close enough on spec compliance" | Reviewer found spec gaps = not done. Fix or hit the cap and adjudicate — those are the only exits. |
| "I'll fix it myself, dispatching is overhead" | Controller fixes pollute your context and skip review. Resume the implementer. |
| "One more round will converge" | Past the cap, rounds don't converge — the failure is structural. Adjudicate and route. |
| "This architecture bug deserves only the normal one-reviewer pass" | On the L5 route, an architecture-level bug is under-triggering unless it escalates to adversarial review mode. Justify the route from §7.3, not thoroughness. |
| "This routine implementation review should go full adversarial" | Over-triggering is a violation. §7.3 gates the escalation; a routine review stays on the normal route. |
| "The final review needs my whole session history" | Hand it a crafted package, never your session's history. |
| "The implementer spawned its own reviewer — free extra assurance" | It's a duplicate seat reviewing the same diff; the task review is the gate. A worker-spawned reviewer is a defect to flag, not rigor. |

## Example

```
You: I'm using subagent-driven-development to execute this plan.

[Setup: worktree verified]
[Read plan file once: docs/whalekit/plans/feature-plan.md]
[Create todos for all tasks]

Task 1: Hook installation script

[Extract Task 1 brief; dispatch implementer with brief + report paths + context]

Implementer: "Before I begin - should the hook be installed at user or system level?"

You: "User level (~/.config/whalekit/hooks/)"

Implementer: [Later]
  - Implemented install-hook command
  - Added tests, 5/5 passing
  - Committed

[Generate review package; dispatch task reviewer with the printed path]
Task reviewer: Spec ✅ - all requirements met, nothing extra.
  Strengths: Good test coverage, clean. Issues: None. Task quality: Approved.

[Ledger: Task 1: complete (commits a1b2c3d..d4e5f6a, review clean)]

Task 2: Recovery modes

[Extract Task 2 brief; dispatch implementer with brief + report paths + context]

Implementer: [No questions]
  - Added verify/repair modes
  - 8/8 tests passing
  - Committed

[Generate review package; dispatch task reviewer with the printed path]
Task reviewer: Spec ❌:
  - Missing: Progress reporting (spec says "report every 100 items")
  Issues (Important): Magic number (100)

[Fix round 1: resume the implementer with both findings]
Implementer: Added progress reporting, extracted PROGRESS_INTERVAL constant.
  Re-ran test/recovery.test.js — 10/10 passing. Fix report appended.

[Generate re-review package; dispatch scoped re-review]
Re-reviewer: Missing progress reporting — ADDRESSED (src/recovery.js:41).
  Magic number — ADDRESSED (src/recovery.js:7). New breakage: none.
  Verdict: all findings addressed.

[Ledger: Task 2: fix round 1/5 (2 addressed, 0 open; commits d4e5f6a..b7c8d9e)]
[Ledger: Task 2: complete (commits d4e5f6a..b7c8d9e, review clean)]

...

[After all tasks]
[Generate final review package; dispatch final reviewer, most capable model]
Final reviewer: All requirements met. Deferred minors triaged: none block merge.

[Delete this plan's workspace — the record now lives in git]

Done! Using whalekit:finishing-a-development-branch.
```
