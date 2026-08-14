Adapted from obra/superpowers (MIT) — https://github.com/obra/superpowers

---
name: executing-plans
description: Use when you have a written implementation plan to execute in a separate session with review checkpoints
---

# Executing Plans

## Overview

Load plan, review critically, execute all tasks, report when complete.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

**Note:** Tell your human partner that executing-plans works much better with access to subagents. If subagents are available, this skill is often displaced by `whalekit:subagent-driven-development` at the tiers that admission allows; use the tier admission rule below to choose.

## Trigger (Tier-Gated)

Like every WhaleKit skill, executing-plans is not mandatorily invoked. Its admission and invocation are governed by the task's routing tier (see `whalekit:routing`, spec §5.3). At tier L4 and above the plan-execution path is admitted; at lower tiers a plan may not exist, so this skill is not automatically triggered. Do not assume a plan is being executed just because a task references one — check whether the routing tier admits plan execution and whether a written plan actually exists.

## Doc Chain

This skill executes a **plan**, which derives from the **spec** (see doc chain §7.7 of the spec). The plan is read alongside the higher documents that produced it. On any conflict between the plan (or its derived documents) and a user requirement, resolve **toward the user requirement**. If the higher document (spec/memo/user requirement) is silent or ambiguous, or if the more refined plan is clearly better, ask the user rather than deciding alone. The user's live decisions always outrank the chain.

## Commit Consent

Before writing any process artifact (e.g., an amended or new plan document), follow the commit-consent protocol (§7.6 of the spec): first read `docs/whalekit/COMMIT-POLICY.md` for the recorded decision covering that artifact type. Follow the recorded decision exactly; do not re-ask for a recorded type. If the policy note has no record for the artifact type, ask the user before writing — answers: **yes** / **no** (gitignore this file) / **never** (gitignore the entire directory) — and record the answer in the policy note (append-only) before applying it. Currently the recorded decisions in `docs/whalekit/COMMIT-POLICY.md` are: **specs — no (gitignored individually)** and **plans — never (ignore the entire directory)**; honor them as recorded.

## The Process

### Step 1: Load and Review Plan
1. Ensure an isolated workspace: use `whalekit:using-git-worktrees` to create one or verify the existing one
2. Read plan file
3. Review critically - identify any questions or concerns about the plan
4. If concerns: Raise them with your human partner before starting
5. If no concerns: Create todos for the plan items and proceed

### Step 2: Execute Tasks

For each task:
1. Mark as in_progress
2. Follow each step exactly (plan has bite-sized steps)
3. Run verifications as specified
4. Mark as completed

### Step 3: Complete Development

After all tasks complete and verified:
- Announce: "I'm using the finishing-a-development-branch skill to complete this work."
- **REQUIRED SUB-SKILL:** Use `whalekit:finishing-a-development-branch`
- Follow that skill to verify tests, present options, execute choice

## When to Stop and Ask for Help

**STOP executing immediately when:**
- Hit a blocker (missing dependency, test fails, instruction unclear)
- Plan has critical gaps preventing starting
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## When to Revisit Earlier Steps

**Return to Review (Step 1) when:**
- Partner updates the plan based on your feedback
- Fundamental approach needs rethinking

**Don't force through blockers** - stop and ask.

## Remember
- Review plan critically first
- Follow plan steps exactly
- Don't skip verifications
- Reference skills when plan says to
- Stop when blocked, don't guess
- Never start implementation on main/master branch without explicit user consent
