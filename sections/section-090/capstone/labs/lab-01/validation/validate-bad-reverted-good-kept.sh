#!/usr/bin/env bash
# Check: probe and shuttle manifests equal the first commit and scout equals the scaled version
set -uo pipefail

REPO="$HOME/gitops-lab/cap-090"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

c1="$(git rev-list --reverse seed | sed -n 1p)"
c3="$(git rev-list --reverse seed | sed -n 3p)"
git diff --quiet "$c1" HEAD -- apps/deployment-probe.yaml || { echo "FAIL: the probe manifest is not back to the first commit"; fail=1; }
git diff --quiet "$c1" HEAD -- apps/deployment-shuttle.yaml || { echo "FAIL: the shuttle manifest is not back to the first commit"; fail=1; }
git diff --quiet "$c3" HEAD -- apps/deployment-scout.yaml || { echo "FAIL: the scout manifest lost the scale-up"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the bad changes are gone and the good one is kept"
exit "$fail"
