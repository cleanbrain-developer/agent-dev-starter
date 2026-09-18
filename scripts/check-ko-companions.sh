#!/usr/bin/env bash
# Checks that every Markdown document has a Korean .ko.md companion (ADR-0004/ADR-0005),
# and flags a companion whose file is older than its English original as *possibly* stale
# (ADR-0007). This is a heuristic, not a proof: it does not survive a fresh `git clone`
# (which resets mtimes) and cannot tell a meaning change from a formatting-only touch.
# Not wired into CI; run by hand.
set -euo pipefail

cd "$(dirname "$0")/.."

missing=0
stale=0

while IFS= read -r -d '' f; do
  ko="${f%.md}.ko.md"
  if [ ! -f "$ko" ]; then
    echo "MISSING companion: $ko"
    missing=$((missing + 1))
  elif [ "$f" -nt "$ko" ]; then
    echo "POSSIBLY STALE (English newer than its .ko.md): $f"
    stale=$((stale + 1))
  fi
done < <(find . \
  \( -path '*/node_modules' -o -path '*/.git' -o -path '*/build' -o -path '*/dist' -o -path '*/out' \) -prune \
  -o -type f -name '*.md' ! -name '*.ko.md' -print0)

echo "$missing missing companion(s), $stale possibly-stale companion(s)."
[ "$missing" -eq 0 ]
