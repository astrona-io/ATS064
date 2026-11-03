#!/usr/bin/env bash
# Check: released.txt holds the full SHA of the tagged commit and is committed
set -uo pipefail

REPO="$HOME/gitops-lab/lab-070"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -f released.txt ] || { echo "FAIL: released.txt is missing"; exit 1; }
git ls-files --error-unmatch released.txt >/dev/null 2>&1 || { echo "FAIL: released.txt is not committed"; exit 1; }
got="$(tr -d '[:space:]' < released.txt)"
want="$(git rev-parse 'release-1^{commit}' 2>/dev/null)"
[ -n "$want" ] && [ "$got" = "$want" ] || { echo "FAIL: released.txt does not hold the full SHA of the commit named by release-1"; exit 1; }
echo "PASS: released.txt holds the SHA of the tagged commit"
