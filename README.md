# WhaleKit

WhaleKit is an agentic skills framework for **DeepSeek Harness (DSH)**. It is a collection of
composable, DSH-native `SKILL.md` skills plus an entry skill that ensures agents use them — built for
full autonomy from upstream roadmaps and hardened against hallucination with an adversarial review
mechanism. Full content is finalized in later stages; this document is the skeleton.

## Quick Start

Coming soon. Installation and first-session setup will be documented here.

## The Five Tiers

WhaleKit replaces binary skill invocation with a **graduated routing menu**. Process depth is chosen
per task, from none at L1 up to full ceremony at L5. Core flow:

```
Session start → using-whalekit (mandatory entry)
  → Task assessment: is exploration needed?
      ├─ Trivial task (one-line fix) → go straight to tier selection
      └─ Non-trivial task → targeted-exploration (target = task core or whole project)
           → Exploration report: findings + evidence + risks + scope estimate
  → Main agent applies routing: recommends a tier + presents 2–3 tier options
  → User decides (gold standard)
  → Skills gated by tier → execution
```

Tier depth: L1 (immediate implementation, no process) → L2 (design memo) → L3 (memo + spec)
→ L4 (memo + spec + implementation plan) → L5 (full, with dual records and architecture-level
adversarial review).

## Skill Inventory

| Skill | Source |
|---|---|
| `using-whalekit` | original — entry skill, routing startup |
| `targeted-exploration` | original |
| `routing` | original — 5 tiers + gating |
| `adversarial-review` | original — red/blue/black meta-skill |
| `dual-records` | original |
| `socratic-brainstorming` | adapted (heavy) — from Superpowers brainstorming |
| `test-driven-development` | adapted — from Superpowers |
| `systematic-debugging` | adapted — from Superpowers |
| `verification-before-completion` | adapted — from Superpowers |
| `requesting-code-review` | adapted — from Superpowers |
| `receiving-code-review` | adapted — from Superpowers |
| `using-git-worktrees` | adapted — from Superpowers |
| `finishing-a-development-branch` | adapted — from Superpowers |
| `writing-plans` | adapted — from Superpowers |
| `executing-plans` | adapted — from Superpowers |
| `subagent-driven-development` | adapted — from Superpowers |
| `writing-skills` | adapted — from Superpowers (skill TDD) |
| `dispatching-parallel-agents` | parked (`useless-now`) — catalog-visible, never triggered |

## Design Philosophy

- **User is the gold standard.** The user's decision is the highest authority below the system
  prompt. Every major decision presents 2–3 options; the agent never decides alone.
- **Ceremony scales with task.** Process depth is graduated (5 tiers) and chosen per task; small
  tasks get small process. The direct answer to Superpowers' binary-invocation problem.
- **Fight hallucination with adversarial review.** Big decisions and architecture-level bugs go
  through red/blue/black subagent loops, not single-agent judgment.
- **Amendable truth.** Review baselines (README.md in dual records) are authoritative but explicitly
  amendable, with every amendment traced in git.

## Installation

Coming soon. A single `install.sh` symlinks the skills into the DSH root
(`$DSH_HOME`/`~/.dsh/skills`, or `<project>/.dsh/skills` with `--project`; `--uninstall` removes).

## Testing

Skill TDD via pressure scenarios in `tests/pressure/<skill>/`. Usage will be documented here.

## License

MIT. Portions adapted from [obra/superpowers](https://github.com/obra/superpowers) (MIT); see
individual SKILL.md headers for attribution.
