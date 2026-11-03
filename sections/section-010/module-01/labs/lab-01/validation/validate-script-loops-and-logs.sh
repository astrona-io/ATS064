#!/usr/bin/env bash
# Check: reconcile.sh stops after one pass with RECONCILE_ONCE, loops otherwise and prints the Git revision
set -uo pipefail

REPO="$HOME/gitops-lab/lab-010"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -f reconcile.sh ] || { echo "FAIL: reconcile.sh is missing"; exit 1; }
grep -qE 'while|until' reconcile.sh || { echo "FAIL: no loop found in reconcile.sh"; exit 1; }
grep -q 'INTERVAL' reconcile.sh || { echo "FAIL: reconcile.sh does not use INTERVAL"; exit 1; }
sha="$(git rev-parse --short HEAD)"
out="$( cd /tmp && RECONCILE_ONCE=1 timeout 120 bash "$REPO/reconcile.sh" 2>&1 )"
echo "$out" | grep -q "$sha" || { echo "FAIL: the output of one pass does not contain the revision $sha"; exit 1; }
count="$( cd /tmp && INTERVAL=1 timeout 10 bash "$REPO/reconcile.sh" 2>&1 | grep -c "$sha" )"
if [ "$count" -lt 2 ]; then echo "FAIL: the loop ran $count pass(es) in 10 seconds with INTERVAL=1"; exit 1; fi
echo "PASS: the script loops with INTERVAL and prints the revision"
