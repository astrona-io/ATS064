#!/usr/bin/env bash
# Check: The cleaned file is committed in a new commit on top of the seed with a clean working tree
set -uo pipefail

REPO="$HOME/gitops-lab/lab-030"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -z "$(git status --porcelain)" ] || { echo "FAIL: the working tree has uncommitted changes"; exit 1; }
git merge-base --is-ancestor seed HEAD || { echo "FAIL: history was rewritten"; exit 1; }
[ "$(git rev-list --count seed..HEAD)" -ge 1 ] || { echo "FAIL: no new commit on top of the seed"; exit 1; }
git show HEAD:apps/service-scout.yaml | grep -qE 'resourceVersion' && { echo "FAIL: the committed file still has resourceVersion"; exit 1; }
echo "PASS: the cleaned file is committed on top of the history"
