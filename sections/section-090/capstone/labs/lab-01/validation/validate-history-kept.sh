#!/usr/bin/env bash
# Check: The history was not rewritten: the four seed commits are ancestors of HEAD and the tree is clean
set -uo pipefail

REPO="$HOME/gitops-lab/cap-090"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

git merge-base --is-ancestor seed HEAD || { echo "FAIL: history was rewritten"; fail=1; }
[ "$(git rev-list --count seed..HEAD)" -ge 2 ] || { echo "FAIL: fewer than two new commits"; fail=1; }
[ -z "$(git status --porcelain)" ] || { echo "FAIL: the working tree has uncommitted changes"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: history intact and clean"
exit "$fail"
