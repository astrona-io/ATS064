#!/usr/bin/env bash
# Check: The manifests are committed on top of the seed with a clean working tree
set -uo pipefail

REPO="$HOME/gitops-lab/lab-060"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -z "$(git status --porcelain)" ] || { echo "FAIL: the working tree has uncommitted changes"; exit 1; }
git merge-base --is-ancestor seed HEAD || { echo "FAIL: history was rewritten"; exit 1; }
[ "$(git rev-list --count seed..HEAD)" -ge 1 ] || { echo "FAIL: no new commit"; exit 1; }
kubectl diff -R -f platform >/dev/null 2>&1
[ "$?" -eq 0 ] || { echo "FAIL: the manifests under platform differ from the cluster"; exit 1; }
echo "PASS: committed, and the cluster matches platform"
