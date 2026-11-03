#!/usr/bin/env bash
# Check: The history was not rewritten: the seed and the bad commit are still on main
set -uo pipefail

REPO="$HOME/gitops-lab/lab-070"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

git merge-base --is-ancestor seed main || { echo "FAIL: the seed commit is no longer in main"; fail=1; }
[ "$(git rev-list --count seed)" -eq 4 ] || { echo "FAIL: the seed history does not have four commits"; fail=1; }
git log main --format=%H -S EXPERIMENTAL_MODE | grep -q . || { echo "FAIL: the bad commit is gone from main"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the history is intact"
exit "$fail"
