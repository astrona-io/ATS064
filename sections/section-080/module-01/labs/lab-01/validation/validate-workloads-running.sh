#!/usr/bin/env bash
# Check: scout and probe are available
set -uo pipefail

REPO="$HOME/gitops-lab/lab-080"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

for name in scout probe; do
  avail="$(kubectl -n starfleet get deployment "$name" -o jsonpath='{.status.availableReplicas}' 2>/dev/null)"
  if [ -z "$avail" ] || [ "$avail" -lt 1 ]; then
    echo "FAIL: deployment $name has no available replica"
    fail=1
  fi
done
[ "$fail" -eq 0 ] && echo "PASS: scout and probe are available"
exit "$fail"
