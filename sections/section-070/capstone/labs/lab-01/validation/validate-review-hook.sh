#!/usr/bin/env bash
# Check: A commit-msg hook rejects a message without a Reviewed-by trailer and accepts one with it
set -uo pipefail

REPO="$HOME/gitops-lab/cap-070"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

hook="$(git rev-parse --git-path hooks/commit-msg)"
[ -x "$hook" ] || { echo "FAIL: $hook is missing or not executable"; exit 1; }
t="$(mktemp)"
printf 'Change something\n\nNo reviewer here.\n' > "$t"
"$hook" "$t" >/dev/null 2>&1 && { echo "FAIL: the hook accepted a message without the trailer"; fail=1; }
printf 'Change something\n\nReviewed-by: Ada Voss\n' > "$t"
"$hook" "$t" >/dev/null 2>&1 || { echo "FAIL: the hook rejected a message with the trailer"; fail=1; }
rm -f "$t"
[ "$fail" -eq 0 ] && echo "PASS: the hook enforces the trailer"
exit "$fail"
