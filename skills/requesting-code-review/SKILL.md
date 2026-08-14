---
name: requesting-code-review
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements
---

Adapted from obra/superpowers (MIT) — https://github.com/obra/superpowers

# Requesting Code Review

Dispatch a code reviewer subagent to catch issues before they cascade. The reviewer gets precisely crafted context for evaluation — never your session's history.

**Core principle:** Review early, review often.

## When to Request Review

**Mandatory:**
- After each task in subagent-driven development
- After completing major feature
- Before merge to main

**Optional but valuable:**
- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing complex bug

## Choose the Review Route

1.1 First decide which review route applies. The **normal review** route is this skill: dispatch a code reviewer subagent to evaluate the work against a baseline and report issues.

1.2 The **adversarial-review** review mode is reserved for architecture-level bugs (spec §7.3) — where a decision affects a final implementation conclusion, may shift technical direction, or fixes an architecture-level bug. Use `adversarial-review`, not this skill, only when the trigger discipline of that skill admits it.

1.3 Otherwise the normal review route applies. **Over-triggering is a violation**: opening adversarial red/blue loops for a routine implementation review is misuse. When in doubt, use the normal review route.

## Review Baseline

2.1 At tier L5 Full, review compares the implementation against the `dual-records` README.md — the amendable truth and the review baseline for the directory. The reviewer evaluates whether the code meets the README.md contract and invariants.

2.2 Below L5, use the plan/requirements (or the spec) as the baseline for what the change should do. If no README.md baseline exists, review against the explicit task requirements.

## How to Request

**3. Get git SHAs:**
```bash
BASE_SHA=$(git rev-parse HEAD~1)  # or origin/main
HEAD_SHA=$(git rev-parse HEAD)
```

**4. Dispatch code reviewer subagent:**

Dispatch a `general-purpose` subagent, filling the template at [code-reviewer.md](code-reviewer.md)

**Placeholders:**
- `{DESCRIPTION}` - Brief summary of what you built
- `{PLAN_OR_REQUIREMENTS}` - What it should do (at L5, point at the dual-records README.md baseline)
- `{BASE_SHA}` - Starting commit
- `{HEAD_SHA}` - Ending commit

**5. Act on feedback:**
- Fix Critical issues immediately
- Fix Important issues before proceeding
- Note Minor issues for later
- Push back if reviewer is wrong (with reasoning)

## Example

```
[Just completed Task 2: Add verification function]

You: Let me request code review before proceeding.

BASE_SHA=$(git log --oneline | grep "Task 1" | head -1 | awk '{print $1}')
HEAD_SHA=$(git rev-parse HEAD)

[Dispatch code reviewer subagent]
  DESCRIPTION: Added verifyIndex() and repairIndex() with 4 issue types
  PLAN_OR_REQUIREMENTS: Task 2 from docs/whalekit/plans/deployment-plan.md
  BASE_SHA: a7981ec
  HEAD_SHA: 3df7661

[Subagent returns]:
  Strengths: Clean architecture, real tests
  Issues:
    Important: Missing progress indicators
    Minor: Magic number (100) for reporting interval
  Assessment: Ready to proceed

You: [Fix progress indicators]
[Continue to Task 3]
```

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "I'll just review the diff myself instead of dispatching a reviewer" | You're the coordinator — reviewing the diff inline burns the context window you need to keep driving the work. Dispatch a reviewer subagent: the diff and the evaluation live in its context, and only the findings come back to you. |
| "The reviewer needs my whole session history to understand the change" | Hand it precisely crafted context, never your session's history. That keeps the reviewer on the work product, not your thought process. |

## Red Flags

**Never:**
- Skip review because "it's simple"
- Ignore Critical issues
- Proceed with unfixed Important issues
- Argue with valid technical feedback

**Never:**
- Over-trigger adversarial review for a routine implementation review (over-triggering is a violation)
- Under-trigger adversarial review for an architecture-level bug where spec §7.3 makes it mandatory

**If reviewer wrong:**
- Push back with technical reasoning
- Show code/tests that prove it works
- Request clarification

See template at: [code-reviewer.md](code-reviewer.md)
