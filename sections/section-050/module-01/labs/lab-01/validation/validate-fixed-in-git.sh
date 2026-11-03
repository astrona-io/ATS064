#!/usr/bin/env bash
# Check: A new commit states the image ghcr.io/stefanprodan/podinfo:6.15.0 for scout
set -uo pipefail

REPO="$HOME/gitops-lab/lab-050"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

git show HEAD:apps/deployment-scout.yaml | grep -qE 'image: ghcr.io/stefanprodan/podinfo:6\.15\.0$' || { echo "FAIL: HEAD does not state the image 6.15.0 for scout"; exit 1; }
git merge-base --is-ancestor seed HEAD || { echo "FAIL: history was rewritten"; exit 1; }
[ "$(git rev-list --count seed..HEAD)" -ge 1 ] || { echo "FAIL: no new commit on top of the seed"; exit 1; }
echo "PASS: the fix is a new commit"
