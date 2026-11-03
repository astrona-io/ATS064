#!/usr/bin/env bash
# Check: apps/deployment-scout.yaml exists, is committed and the working tree is clean
set -uo pipefail

REPO="$HOME/gitops-lab/lab-020"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -f apps/deployment-scout.yaml ] || { echo "FAIL: apps/deployment-scout.yaml does not exist"; exit 1; }
git ls-files --error-unmatch apps/deployment-scout.yaml >/dev/null 2>&1 || { echo "FAIL: the file is not committed"; exit 1; }
[ -z "$(git status --porcelain)" ] || { echo "FAIL: the working tree has uncommitted changes"; exit 1; }
echo "PASS: the declaration is committed"
