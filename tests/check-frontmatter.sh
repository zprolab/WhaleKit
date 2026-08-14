#!/usr/bin/env bash
# WhaleKit frontmatter integrity check.
# Verifies for every skills/*/SKILL.md:
#   1. Physical line 1 is exactly "---" (DSH discovery requirement)
#   2. Frontmatter closes with "---"
#   3. name: present and kebab-case
#   4. description: value is quoted, or unquoted without ": " (YAML plain-scalar rule)
set -euo pipefail
cd "$(dirname "$0")/.."
fail=0
count=0
for f in skills/*/SKILL.md; do
  count=$((count+1))
  if [ "$(head -1 "$f")" != "---" ]; then echo "FAIL(line1-not-frontmatter): $f"; fail=1; continue; fi
  close=$(awk 'NR>1 && /^---$/{print NR; exit}' "$f")
  if [ -z "$close" ]; then echo "FAIL(no-closing-frontmatter): $f"; fail=1; continue; fi
  name=$(awk -F': ' '/^name:/{print $2; exit}' "$f")
  if [ -z "$name" ] || ! printf '%s' "$name" | grep -qE '^[a-z0-9]+(-[a-z0-9]+)*$'; then
    echo "FAIL(name-not-kebab): $f"; fail=1
  fi
  desc=$(awk '/^description:/{print; exit}' "$f")
  if [ -z "$desc" ]; then echo "FAIL(no-description): $f"; fail=1; fi
  if printf '%s' "$desc" | grep -qE '^description: [^"].*: '; then
    echo "FAIL(description-unquoted-colon): $f"; fail=1
  fi
done
if [ $fail -eq 0 ]; then echo "ALL FRONTMATTER OK ($count skills)"; exit 0; fi
echo "FRONTMATTER CHECK FAILED"; exit 1
