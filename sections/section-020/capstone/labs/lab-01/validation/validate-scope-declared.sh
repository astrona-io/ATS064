#!/usr/bin/env bash
# Check: The shuttle manifest names the namespace starfleet and no stray shuttle Deployment exists in default
set -uo pipefail

REPO="$HOME/gitops-lab/cap-020"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

grep -qE '^  namespace: starfleet' apps/deployment-shuttle.yaml || { echo "FAIL: the shuttle manifest has no namespace: starfleet"; fail=1; }
if kubectl -n default get deployment shuttle >/dev/null 2>&1; then echo "FAIL: a shuttle Deployment exists in the default namespace"; fail=1; fi
[ "$fail" -eq 0 ] && echo "PASS: the namespace is declared and nothing leaked into default"
exit "$fail"
