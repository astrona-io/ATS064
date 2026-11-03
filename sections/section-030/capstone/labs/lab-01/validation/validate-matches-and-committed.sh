#!/usr/bin/env bash
# Check: kubectl diff on apps shows no difference and the work is committed on top of the seed
set -uo pipefail

REPO="$HOME/gitops-lab/cap-030"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

kubectl diff -R -f apps >/dev/null 2>&1
[ "$?" -eq 0 ] || { echo "FAIL: kubectl diff -R -f apps shows differences"; exit 1; }
[ -z "$(git status --porcelain)" ] || { echo "FAIL: uncommitted changes"; exit 1; }
git merge-base --is-ancestor seed HEAD || { echo "FAIL: history was rewritten"; exit 1; }
[ "$(git rev-list --count seed..HEAD)" -ge 1 ] || { echo "FAIL: no new commit"; exit 1; }
echo "PASS: committed, and the cluster matches Git"
