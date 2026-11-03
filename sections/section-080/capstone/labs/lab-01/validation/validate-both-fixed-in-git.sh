#!/usr/bin/env bash
# Check: The committed manifests of shuttle and drifter no longer use the missing image tag or the missing readiness path
set -uo pipefail

REPO="$HOME/gitops-lab/cap-080"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

git show HEAD:apps/deployment-shuttle.yaml | grep -q 'podinfo:6.99.0' && { echo "FAIL: shuttle still uses the missing image tag"; fail=1; }
git show HEAD:apps/deployment-drifter.yaml | grep -q '/nothere' && { echo "FAIL: drifter still uses the path /nothere"; fail=1; }
[ -z "$(git status --porcelain)" ] || { echo "FAIL: the working tree has uncommitted changes"; fail=1; }
git merge-base --is-ancestor seed HEAD || { echo "FAIL: history was rewritten"; fail=1; }
[ "$(git rev-list --count seed..HEAD)" -ge 1 ] || { echo "FAIL: no new commit"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: both fixes are committed"
exit "$fail"
