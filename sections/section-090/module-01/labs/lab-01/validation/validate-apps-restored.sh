#!/usr/bin/env bash
# Check: The files under apps at HEAD equal the last good revision and the working tree is clean
set -uo pipefail

REPO="$HOME/gitops-lab/lab-090"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

git diff --quiet seed~1 HEAD -- apps || { echo "FAIL: apps at HEAD differ from the last good revision"; fail=1; }
[ -z "$(git status --porcelain)" ] || { echo "FAIL: the working tree has uncommitted changes"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: apps equal the last good revision"
exit "$fail"
