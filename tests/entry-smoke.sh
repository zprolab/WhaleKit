#!/usr/bin/env bash
# WhaleKit entry smoke test — automates FINAL-VALIDATION checkpoint 1.
# (a) installs the skills into a temp target, (b) asserts every SKILL.md
# frontmatter is parseable per DSH rules, (c) asserts the entry skill
# (using-whalekit) is present and discoverable in the installed catalog.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
fail=0

echo "== (a) install into temp target =="
(cd "$TMP" && "$ROOT/install.sh" --project >/dev/null)
installed=0
for s in "$TMP"/.dsh/skills/*/; do [ -d "$s" ] && installed=$((installed+1)); done
expected=$(find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')
if [ "$installed" -ne "$expected" ]; then
  echo "FAIL(install-count): got $installed skills, expected $expected"; fail=1
fi

echo "== (b) frontmatter parseable per DSH rules =="
"$ROOT/tests/check-frontmatter.sh" || fail=1

echo "== (c) entry skill discoverable in installed catalog =="
ENTRY="$TMP/.dsh/skills/using-whalekit/SKILL.md"
if [ ! -f "$ENTRY" ]; then echo "FAIL(entry-missing): $ENTRY"; fail=1; fi
if [ -f "$ENTRY" ]; then
  entry_name=$(awk -F': ' '/^name:/{print $2; exit}' "$ENTRY")
  if [ "$entry_name" != "using-whalekit" ]; then echo "FAIL(entry-name): '$entry_name'"; fail=1; fi
  desc=$(awk '/^description:/{print; exit}' "$ENTRY")
  if [ -z "$desc" ]; then echo "FAIL(entry-description-missing)"; fail=1; fi
  if printf '%s' "$desc" | grep -qE '^description: [^"].*: '; then
    echo "FAIL(entry-description-unquoted-colon)"; fail=1
  fi
fi

if [ $fail -eq 0 ]; then
  echo "ENTRY SMOKE OK (${installed}/${expected} skills installed; entry discoverable)"
  exit 0
fi
echo "ENTRY SMOKE FAILED"; exit 1
