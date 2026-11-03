#!/usr/bin/env bash
# Check: reconcile.sh is executable, valid and committed
set -uo pipefail

REPO="$HOME/gitops-lab/cap-010"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -x reconcile.sh ] || { echo "FAIL: reconcile.sh is missing or not executable"; exit 1; }
bash -n reconcile.sh || { echo "FAIL: syntax error in reconcile.sh"; exit 1; }
git ls-files --error-unmatch reconcile.sh >/dev/null 2>&1 || { echo "FAIL: reconcile.sh is not committed"; exit 1; }
echo "PASS: reconcile.sh is committed"
