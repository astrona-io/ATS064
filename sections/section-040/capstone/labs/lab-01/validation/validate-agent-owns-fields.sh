#!/usr/bin/env bash
# Check: The Deployments scout, probe and shuttle have a server-side apply entry for the manager gitops-agent
set -uo pipefail

REPO="$HOME/gitops-lab/cap-040"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

for n in scout probe shuttle; do
  c="$(kubectl -n starfleet get deployment $n --show-managed-fields -o json | jq '[.metadata.managedFields[] | select(.manager=="gitops-agent" and .operation=="Apply")] | length')"
  [ "$c" -ge 1 ] || { echo "FAIL: $n has no Apply entry for gitops-agent"; fail=1; }
done
[ "$fail" -eq 0 ] && echo "PASS: gitops-agent owns the declared fields"
exit "$fail"
