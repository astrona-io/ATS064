#!/usr/bin/env bash
# Check: audit.txt lists the unique authors of the seed history, one per line and sorted, and is committed
set -uo pipefail

REPO="$HOME/gitops-lab/cap-070"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -f audit.txt ] || { echo "FAIL: audit.txt is missing"; exit 1; }
git ls-files --error-unmatch audit.txt >/dev/null 2>&1 || { echo "FAIL: audit.txt is not committed"; exit 1; }
want="$(git log seed --format=%an | sort -u)"
got="$(grep -v '^[[:space:]]*$' audit.txt)"
[ "$got" = "$want" ] || { echo "FAIL: audit.txt does not match the unique authors of the seed history"; exit 1; }
echo "PASS: audit.txt is correct"
