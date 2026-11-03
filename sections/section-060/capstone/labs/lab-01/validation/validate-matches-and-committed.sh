#!/usr/bin/env bash
# Check: kubectl diff on apps and platform shows no difference and the work is committed on top of the seed
set -uo pipefail

REPO="$HOME/gitops-lab/cap-060"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

kubectl diff -R -f apps >/dev/null 2>&1
[ "$?" -eq 0 ] || { echo "FAIL: kubectl diff -R -f apps shows differences"; fail=1; }
kubectl diff -R -f platform >/dev/null 2>&1
[ "$?" -eq 0 ] || { echo "FAIL: kubectl diff -R -f platform shows differences"; fail=1; }
[ -z "$(git status --porcelain)" ] || { echo "FAIL: the working tree has uncommitted changes"; fail=1; }
git merge-base --is-ancestor seed HEAD || { echo "FAIL: history was rewritten"; fail=1; }
[ "$(git rev-list --count seed..HEAD)" -ge 1 ] || { echo "FAIL: no new commit"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the cluster matches Git and the work is committed"
exit "$fail"
