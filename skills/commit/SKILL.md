---
name: commit
description: "Use when starting implementation work on a task, or when the user asks you to commit changes to the repository"
---

# Commit

## Overview

Two duties, one skill. Before implementation begins, ask the commit strategy. When the user asks to commit, read the changes and create logical commits one by one.

**Core principle:** commits are the user's call, not the agent's. The user's decision is the highest authority below the system prompt.

**Announce at start:** "I'm using the commit skill — first I need to ask the commit strategy for this task."

## 1. Gate: ask the commit strategy before implementing

1.1 Before starting implementation on a task, ask two questions, one at a time:

  1. Is a commit needed for this task? (yes / no)
  2. If yes: commit as you go (incremental, 做到哪提交到哪) or commit at the end (final, 最后一起提交)?

1.2 Before any major decision, present 2–3 options to the user. Wait for the answer; record it verbatim.

1.3 Honor the recorded answer:

  - **no commit** — never commit anything for this task, even at the end.
  - **incremental** — commit after each logical unit completes, during implementation.
  - **final** — commit everything at the end, still grouped by logic.

1.4 If the user already declared the commit strategy for this task or session, do not re-ask; use the declared strategy. If the user waives the strategy question ("你看着办/都行"), follow `decision-approval`: present a commit-plan draft sheet (proposed logical commit groups + messages, labeled 草案/待批准) and commit only after approval.

<HARD-GATE>
**Definition:** starting implementation on a task — touching any file for the task — before the commit strategy question was asked and answered, absent an explicit waiver.

**Obligation:** before implementing, ask whether a commit is needed and, if so, whether to commit incrementally or at the end; wait for and honor the answer.

**Exception:** the user already declared the strategy for this task or session, or explicitly waived the question for this task.
</HARD-GATE>

## 2. Manual commit procedure

Trigger: the user asks you to commit ("commit my changes", "提交一下", "commit this"). This procedure also runs at the end of a **final**-strategy task and after each logical unit in an **incremental**-strategy task.

### 2.1 Read the changes first

Run `git status` and `git diff` (staged and unstaged). Read every changed file before staging anything. Never commit code you have not read.

### 2.2 Group by logic

Identify the logical units in the working tree — feature / bugfix / refactor / docs / chore. One commit per unit. If a file mixes two units, split it by hunks with `git add -p`.

### 2.3 Commit one by one

For each unit: stage only that unit's files or hunks, then commit with a message that states what changed and why. Repeat until the working tree holds nothing left to commit.

Message rules: describe the change ("add multiply function", "fix subtract sign bug", "update README"). Never use generic labels: "update", "stuff", "wip", "changes", "misc".

### 2.4 Safety — never commit these

1. **Secrets.** `.env`, keys, tokens, credentials. Exclude them, or add them to `.gitignore` and commit the ignore rule separately with a clear message.
2. **Broken or half-finished work.** Never commit code that does not run or is incomplete without the user's explicit instruction.
3. **Anything without consent.** The user's strategy answer is the consent baseline; when in doubt, ask.

### 2.5 Process artifacts follow the global policy

Commit decisions for process artifacts (memos, specs, plans, validation) are recorded in `docs/whalekit/COMMIT-POLICY.md` — a global setting, read before writing any artifact. Unlisted artifact types require asking the user before writing. This skill's gate covers implementation commits; the policy covers process artifacts; both are honored, never bypassed.

## Quick Reference

| Situation | Action |
|---|---|
| Before implementing | Ask: commit needed? If yes: incremental or final? |
| User asks to commit | Read diff → group by logic → commit one by one |
| Secrets in working tree | Exclude; never commit |
| Broken work in tree | Ask before committing |
| Strategy = no commit | Never commit |
| Strategy = incremental | Commit after each logical unit |
| Strategy = final | Commit at the end, grouped by logic |
| Strategy already declared | Use it; do not re-ask |

## Common Rationalizations

| Excuse | Reality |
|---|---|
| "It's a one-line fix, committing it directly is fine" | The strategy is the user's call, not the fix's size. Ask first. |
| "`git add -A` and one commit is faster" | One commit per logical unit; a blob commit buries history. |
| "The user said commit everything" | Read first anyway; secrets and broken work are still never committed without explicit instruction. |
| "No one will notice one unlabeled commit" | History is the traceability layer; generic messages destroy it. |
| "Committing at the end is obviously fine" | "Obviously" is the user's to decide. Ask. |

## Red Flags

- Implementation started without the commit strategy question
- Commit created without reading the diff
- One commit for multiple logical units
- `.env` or secret-like content staged
- Broken or half-finished code committed
- Generic commit message ("update", "wip", "stuff")

**All of these mean: stop, and follow sections 1–2.**
