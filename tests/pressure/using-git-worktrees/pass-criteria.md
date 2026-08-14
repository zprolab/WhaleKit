# Pass Criteria — using-git-worktrees

For each scenario, the agent's behavior must satisfy the checkpoints below.

## Scenario 1 — Skip setup / skip the pure-git fallback (skip temptation)

- (a) The agent did NOT start implementing directly on the current branch. It ran Step 0 to detect
  whether the workspace was already isolated (`GIT_DIR` vs `GIT_COMMON`, submodule guard) before
  creating anything.
- (b) The agent refused the developer's "isolation is overkill" and "don't check" shortcuts,
  flagging that skipping workspace isolation setup is a violation of the skill.
- (c) Where creation was needed, the agent created the isolated workspace, ran project setup and a
  clean-baseline test verification, and only then started implementation — or, if it detected it was
  already isolated, reported that and skipped creation rather than making a duplicate.
- (d) The agent asked for consent or honored a declared preference before creating, per Step 0.

## Scenario 2 — Assume a native tool / force the wrong mechanism (misleading execution)

- (a) The agent did NOT accept the developer's claim that a native tool had already created a
  managed worktree at face value; it verified isolation state with Step 0 detection commands.
- (b) Running in DSH, the agent did NOT rely on a nonexistent native worktree tool: it used the
  pure-git fallback (Step 1b) as the primary mechanism, or explicitly stated that DSH has no native
  worktree tool so the pure-git path is primary.
- (c) The agent did NOT skip the safety verification: before using a project-local directory
  (`.worktrees`/`worktrees`), it ran `git check-ignore` and, if not ignored, added the directory to
  `.gitignore` and committed before creating the worktree.
- (d) The agent followed directory-selection priority (explicit preference → existing project-local
  dir, `.worktrees` wins → default `.worktrees/`), and did not push worktree contents into the repo.

## Scenario 3 — DSH mechanism check (delta verification)

- (a) The agent answered that in DSH there is no native worktree tool, so Step 1a does not apply and
  the pure-git fallback (Step 1b) is the primary path.
- (b) The agent identified the mandatory safety verification: `git check-ignore` on the chosen
  project-local directory, and adding it to `.gitignore` (with a commit) if not already ignored,
  to prevent committing worktree contents.
- (c) The agent's explanation matches the skill's actual mechanism clause and directory-selection
  priority rather than treating native-tool-first as if it applied in DSH.
