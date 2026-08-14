#!/usr/bin/env bash
# Checks that the two canonical gold-standard phrases appear verbatim wherever
# the gold-standard rule is stated in skills/ (emphasis layer), and that no
# stale variant ("user's choice is the highest authority") survives anywhere.
set -euo pipefail
cd "$(dirname "$0")/.."
P1='The user'"'"'s decision is the highest authority below the system prompt.'
P2='Before any major decision, present 2–3 options to the user.'
# Skills that must carry BOTH phrases in the emphasis layer (Mode B keepers):
BOTH='using-whalekit routing subagent-driven-development whalekit-conventions socratic-brainstorming adversarial-review commit'
# dual-records carries P1 only (document precedence; no decision-menu context):
P1_ONLY='dual-records'
# writing-plans / executing-plans reference without embedding (per Task 3) — not checked for presence.
# Phrase-presence checks are case-insensitive (-i) because the canonical phrases can be
# legitimately embedded mid-sentence (e.g. dual-records: "...and the user's decision is the
# highest authority below the system prompt."), where the sentence-initial capital "The" is
# grammatically lowercased. This is not wording drift; the STALE-variant check below stays
# case-sensitive because the drift class it guards against is the "choice/decision" wording.
fail=0
for f in skills/*/SKILL.md; do
  base="$(basename "$(dirname "$f")")"
  case " $BOTH " in
    *" $base "*) if ! grep -qiF "$P1" "$f" || ! grep -qiF "$P2" "$f"; then
                    echo "MISSING canonical phrase(s) ($base): $f"; fail=1; fi ;;
  esac
  case " $P1_ONLY " in
    *" $base "*) if ! grep -qiF "$P1" "$f"; then
                    echo "MISSING P1 ($base): $f"; fail=1; fi ;;
  esac
  if grep -q "user's choice is the highest authority" "$f"; then
    echo "STALE variant: $f"; fail=1
  fi
done
[ $fail -eq 0 ] && echo "RECURRING WORDING OK" || { echo "WORDING CHECK FAILED"; exit 1; }
