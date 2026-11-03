#!/usr/bin/env bash
# Check: scout, probe and shuttle are available
set -uo pipefail

REPO="$HOME/gitops-lab/cap-060"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

for name in scout probe shuttle; do
  avail="$(kubectl -n starfleet get deployment "$name" -o jsonpath='{.status.availableReplicas}' 2>/dev/null)"
  if [ -z "$avail" ] || [ "$avail" -lt 1 ]; then
    echo "FAIL: deployment $name has no available replica"
    fail=1
  fi
done
[ "$fail" -eq 0 ] && echo "PASS: scout, probe and shuttle are available"
exit "$fail"
