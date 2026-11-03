#!/usr/bin/env bash
# Check: reconcile.sh is executable, has valid syntax and is committed with a clean working tree
set -uo pipefail

REPO="$HOME/gitops-lab/lab-010"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

if [ ! -x reconcile.sh ]; then echo "FAIL: reconcile.sh is missing or not executable"; exit 1; fi
bash -n reconcile.sh || { echo "FAIL: reconcile.sh has a syntax error"; exit 1; }
git ls-files --error-unmatch reconcile.sh >/dev/null 2>&1 || { echo "FAIL: reconcile.sh is not committed"; exit 1; }
if [ -n "$(git status --porcelain)" ]; then echo "FAIL: the working tree has uncommitted changes"; exit 1; fi
echo "PASS: reconcile.sh is committed"
