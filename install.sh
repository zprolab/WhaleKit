#!/usr/bin/env bash
# WhaleKit installer for DSH (DeepSeek Harness).
# Usage: install.sh [--project] [--uninstall]   (order-independent)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
PROJECT=0
UNINSTALL=0
for arg in "$@"; do
  case "$arg" in
    --project)   PROJECT=1 ;;
    --uninstall) UNINSTALL=1 ;;
    *) echo "unknown option: $arg" >&2; exit 1 ;;
  esac
done
if [ "$PROJECT" = "1" ]; then
  TARGET="$(pwd)/.dsh/skills"
else
  DSH_HOME="${DSH_HOME:-$HOME/.dsh}"
  TARGET="$DSH_HOME/skills"
fi
if [ "$UNINSTALL" = "1" ]; then
  for s in "$ROOT"/skills/*/; do
    name="$(basename "$s")"
    rm -f "$TARGET/$name"
  done
  rmdir "$TARGET" 2>/dev/null || true
  echo "uninstalled from $TARGET"
  exit 0
fi
mkdir -p "$TARGET"
count=0
for s in "$ROOT"/skills/*/; do
  name="$(basename "$s")"
  ln -sfn "$s" "$TARGET/$name"
  count=$((count+1))
done
echo "installed $count skills into $TARGET"
