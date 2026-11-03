#!/usr/bin/env bash
# Check: The shuttle manifest at HEAD no longer uses the missing readiness path, and the fix is committed on top of the seed
set -uo pipefail

REPO="$HOME/gitops-lab/lab-080"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

git show HEAD:apps/deployment-shuttle.yaml | grep -q '/nothere' && { echo "FAIL: the committed manifest still has the path /nothere"; fail=1; }
[ -z "$(git status --porcelain)" ] || { echo "FAIL: the working tree has uncommitted changes"; fail=1; }
git merge-base --is-ancestor seed HEAD || { echo "FAIL: history was rewritten"; fail=1; }
[ "$(git rev-list --count seed..HEAD)" -ge 1 ] || { echo "FAIL: no new commit"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the fix is committed"
exit "$fail"
