#!/usr/bin/env bash
# Check: kubectl diff on apps shows no difference
set -uo pipefail

REPO="$HOME/gitops-lab/lab-040"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

kubectl diff -R -f apps >/dev/null 2>&1
[ "$?" -eq 0 ] || { echo "FAIL: kubectl diff -R -f apps still shows differences"; exit 1; }
echo "PASS: the cluster matches Git"
