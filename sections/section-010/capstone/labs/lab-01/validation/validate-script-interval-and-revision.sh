#!/usr/bin/env bash
# Check: The loop runs several passes with INTERVAL=2, prints the revision and stops with RECONCILE_ONCE
set -uo pipefail

REPO="$HOME/gitops-lab/cap-010"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -f reconcile.sh ] || { echo "FAIL: reconcile.sh is missing"; exit 1; }
sha="$(git rev-parse --short HEAD)"
count="$( cd /tmp && INTERVAL=2 timeout 14 bash "$REPO/reconcile.sh" 2>&1 | grep -c "$sha" )"
if [ "$count" -lt 3 ]; then echo "FAIL: only $count pass(es) printed the revision $sha in 14 seconds with INTERVAL=2"; exit 1; fi
start="$(date +%s)"
( cd /tmp && RECONCILE_ONCE=1 timeout 60 bash "$REPO/reconcile.sh" >/dev/null 2>&1 )
[ "$(( $(date +%s) - start ))" -lt 50 ] || { echo "FAIL: RECONCILE_ONCE did not stop the script after one pass"; exit 1; }
echo "PASS: the interval, the revision log and RECONCILE_ONCE work"
