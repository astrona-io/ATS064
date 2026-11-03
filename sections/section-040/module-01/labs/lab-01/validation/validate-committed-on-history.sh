#!/usr/bin/env bash
# Check: The changes are committed on top of the seed with a clean working tree
set -uo pipefail

REPO="$HOME/gitops-lab/lab-040"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -z "$(git status --porcelain)" ] || { echo "FAIL: the working tree has uncommitted changes"; exit 1; }
git merge-base --is-ancestor seed HEAD || { echo "FAIL: history was rewritten"; exit 1; }
[ "$(git rev-list --count seed..HEAD)" -ge 1 ] || { echo "FAIL: no new commit"; exit 1; }
echo "PASS: committed on top of the history"
