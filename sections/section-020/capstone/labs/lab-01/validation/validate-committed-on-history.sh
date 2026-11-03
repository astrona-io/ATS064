#!/usr/bin/env bash
# Check: The fix is committed on top of the existing history with a clean working tree and passes server-side validation
set -uo pipefail

REPO="$HOME/gitops-lab/cap-020"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -z "$(git status --porcelain)" ] || { echo "FAIL: uncommitted changes"; exit 1; }
git merge-base --is-ancestor seed HEAD || { echo "FAIL: history was rewritten"; exit 1; }
[ "$(git rev-list --count seed..HEAD)" -ge 1 ] || { echo "FAIL: no new commit"; exit 1; }
kubectl apply --dry-run=server -R -f apps >/dev/null 2>&1 || { echo "FAIL: server-side dry run rejects the manifests"; exit 1; }
echo "PASS: committed on top of the existing history"
