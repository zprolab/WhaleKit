# WhaleKit

WhaleKit is an agentic skills framework for **DeepSeek Harness (DSH)**. It is a collection of
composable, DSH-native `SKILL.md` skills plus an entry skill that ensures agents use them — built for
full autonomy from upstream roadmaps and hardened against hallucination with an adversarial review
mechanism.

Together with `install.sh`, it replaces binary skill invocation (Superpowers' weakness) with a
**five-tier routing ceremony**: process depth is chosen per task, from none at L1 up to full ceremony
at L5. Git is the traceability layer; every authoritative document is amendable but every amendment
is a commit.

## Quick Start

### 1. Install

From the repository root, run the installer:

```bash
./install.sh                 # install into ~/.dsh/skills (DSH_HOME overrides the root)
./install.sh --project       # install into <project>/.dsh/skills instead
./install.sh --uninstall     # remove every WhaleKit skill symlink (works with --project too)
```

- **Default**: symlinks all 18 skills into `$DSH_HOME/skills` (defaults to `~/.dsh/skills`).
- **`--project`**: symlinks into `<projectRoot>/.dsh/skills`, which DSH ranks above the home root.
- **`--uninstall`**: removes every WhaleKit symlink and the emptied target directory.
- Options are order-independent (`install.sh --uninstall --project` behaves identically).

DSH discovers skills from `<projectRoot>/.dsh/skills` (rank 100) before `~/.dsh/skills` (rank 400),
so a project-local install takes precedence over a global one.

### 2. First session

`using-whalekit` is the **entry skill**: it must be invoked at the start of any conversation. When you
begin a task, WhaleKit will classify it (trivial vs non-trivial), run `targeted-exploration` if needed,
recommend a routing tier, and present **2–3 tier options** for you to choose. The user's decision is the
highest authority below the system prompt — the agent never picks the tier alone.

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

| Tier | Process | Trigger signals (from exploration report) |
|---|---|---|
| **L1** Immediate implementation | No process | Purely mechanical change, minimal risk |
| **L2** Memo only | Memo persisted to disk | Small feature, single file |
| **L3** Memo → Spec | + specification | Medium feature, touches interfaces |
| **L4** Memo → Spec → Plan | + implementation plan | Large feature, multiple files/modules |
| **L5** Full | + dual records | New project, architecture-level, directional decisions |

**Iron rules of routing:**

1. **User is the gold standard.** Any tier recommendation must present 2–3 options; the user chooses.
   The agent never decides the tier alone.
2. **One-way ratchet.** Hidden complexity discovered mid-task upgrades the tier — stop, say so, step
   up. Nothing downgrades mid-task.
3. **Exploration before recommendation.** Tier recommendations for non-trivial tasks must be based on
   a targeted-exploration report, never on impression.

## Skill Inventory

18 skills (5 original + 12 adapted + 1 parked). Adapted skills retain their
`Adapted from obra/superpowers (MIT)` header; see individual `SKILL.md` headers for attribution.

| Skill | Source |
|---|---|
| `using-whalekit` | **original** — entry skill, routing startup |
| `targeted-exploration` | **original** — anti-divergence exploration feeding routing |
| `routing` | **original** — five tiers, gating, one-way ratchet |
| `adversarial-review` | **original** — red/blue/black meta-skill (decision + review modes) |
| `dual-records` | **original** — DEVELOPMENT.md + README.md (amendable truth) |
| `socratic-brainstorming` | adapted (heavy) — from obra/superpowers `brainstorming` |
| `test-driven-development` | adapted — from obra/superpowers |
| `systematic-debugging` | adapted — from obra/superpowers |
| `verification-before-completion` | adapted — from obra/superpowers |
| `requesting-code-review` | adapted — from obra/superpowers |
| `receiving-code-review` | adapted — from obra/superpowers |
| `using-git-worktrees` | adapted — from obra/superpowers |
| `finishing-a-development-branch` | adapted — from obra/superpowers |
| `writing-plans` | adapted — from obra/superpowers |
| `executing-plans` | adapted — from obra/superpowers |
| `subagent-driven-development` | adapted — from obra/superpowers |
| `writing-skills` | adapted — from obra/superpowers (skill TDD) |
| `dispatching-parallel-agents` | **parked** (`metadata.status: useless-now`) — catalog-visible, never triggered |

## Design Philosophy

- **User is the gold standard.** The user's decision is the highest authority below the system
  prompt. Every major decision presents 2–3 options; the agent never decides alone.
- **Ceremony scales with task.** Process depth is graduated (5 tiers) and chosen per task; small
  tasks get small process. The direct answer to Superpowers' binary-invocation problem.
- **Fight hallucination with adversarial review.** Big decisions and architecture-level bugs go
  through red/blue/black subagent loops (decision mode) and review-mode red-finds/blue-fixes loops,
  not single-agent judgment.
- **Amendable truth.** Review baselines (README.md in dual records) are authoritative but explicitly
  amendable, with every amendment traced in git.

All documents form a golden-standard chain — `Dual → Plan → Spec → Memo → User requirement` — where
the user requirement is the highest authority and live user decisions outrank the chain. Process
artifacts enter git **by consent**: every artifact write is preceded by a commit-policy check.

## Installation

A single `install.sh` symlinks the skills into the DSH root, with `--project` (project-local
`.dsh/skills`) and `--uninstall` modes. See [Quick Start](#quick-start).

## Testing

Skill TDD via pressure scenarios in `tests/pressure/<skill>/` — each skill has ≥2 scenarios (one
skip-temptation, one misleading-execution) plus `pass-criteria.md`. Run the harness:

```bash
tests/run.sh <skill>          # print the scenario prompt and pass criteria
tests/run.sh <skill> --dispatch  # print a ready-to-use subagent dispatch prompt
tests/run.sh <skill> --live      # print a manual live-session verification checklist
```

`--live` exists for entry-sensitive skills (whose ceremony a dispatched subagent is correctly
exempted from by a `<SUBAGENT-STOP>` block) and any skill requiring live user interaction.

## License

[MIT](LICENSE). Portions adapted from [obra/superpowers](https://github.com/obra/superpowers) (MIT);
see individual `SKILL.md` headers for attribution.
