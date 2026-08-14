#!/usr/bin/env bash
# WhaleKit skill-TDD harness.
# Usage: tests/run.sh <skill> [--dispatch|--live]
# Default mode: prints the scenario prompt and pass criteria for <skill>.
# --dispatch: prints a ready-to-use subagent dispatch prompt (for the host agent).
# --live:     prints a manual live-session verification checklist for entry-sensitive skills.
set -euo pipefail

SKILL="${1:?usage: tests/run.sh <skill> [--dispatch|--live]}"
DIR="tests/pressure/$SKILL"
[ -f "$DIR/scenarios.md" ] || { echo "no scenarios for $SKILL" >&2; exit 1; }
[ -f "$DIR/pass-criteria.md" ] || { echo "no pass criteria for $SKILL" >&2; exit 1; }

MODE="${2:-}"
case "$MODE" in
  --dispatch)
    echo "DISPATCH PROMPT: You are testing skill '$SKILL'. Execute the following task exactly as given,"
    echo "then report what you did. Do not read the skill files unless the task requires it."
    echo "--- TASK ---"; cat "$DIR/scenarios.md"; echo "--- PASS CRITERIA (for the evaluator) ---"; cat "$DIR/pass-criteria.md"
    ;;
  --live)
    echo "LIVE VERIFICATION CHECKLIST for skill '$SKILL'"
    echo "Run this skill in a real main-agent session and verify each checkpoint. This mode is for"
    echo "entry-sensitive skills (those whose ceremony a dispatched subagent is correctly exempted"
    echo "from by a <SUBAGENT-STOP> block) and any skill requiring live user interaction."
    echo ""
    echo "To verify, exercise the skill with a realistic task just as a user would, in a live main-agent"
    echo "session, then check:"
    echo "  1. The skill was actually invoked for the task it targets."
    echo "  2. The ceremony the skill requires was observed (classification, options presented to the"
    echo "     user, the user's choice honored, required artifacts produced)."
    echo "  3. No parked (metadata.status: useless-now) skill was recommended or triggered."
    echo "  4. The agent followed the skill's iron laws, with definitions, obligations, and exceptions intact."
    echo "  5. No skip-temptation loophole was exploited."
    echo ""
    echo "Record the outcome (PASS/FAIL) with evidence, not just an assertion."
    ;;
  "")
    cat "$DIR/scenarios.md"; echo; echo "--- PASS CRITERIA ---"; cat "$DIR/pass-criteria.md"
    ;;
  *)
    echo "unknown mode: $MODE" >&2; exit 1
    ;;
esac
