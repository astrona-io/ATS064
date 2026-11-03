#!/usr/bin/env bash
# Check: kubectl diff on apps shows no difference and sync-status is not stored in Git
set -uo pipefail

REPO="$HOME/gitops-lab/cap-080"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

kubectl diff -R -f apps >/dev/null 2>&1
rc=$?
[ "$rc" -eq 0 ] || { echo "FAIL: kubectl diff -R -f apps exited with $rc"; fail=1; }
grep -rqs 'sync-status' apps && { echo "FAIL: sync-status must not be stored in apps"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the cluster matches apps"
exit "$fail"
