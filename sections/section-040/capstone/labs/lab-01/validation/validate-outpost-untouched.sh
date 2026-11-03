#!/usr/bin/env bash
# Check: The drifter Deployment in outpost still has 5 replicas and no gitops-agent entry
set -uo pipefail

REPO="$HOME/gitops-lab/cap-040"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

live="$(kubectl -n outpost get deployment drifter -o jsonpath='{.spec.replicas}')"
[ "$live" = "5" ] || { echo "FAIL: drifter has $live replicas, it must stay at 5"; fail=1; }
c="$(kubectl -n outpost get deployment drifter --show-managed-fields -o json | jq '[.metadata.managedFields[] | select(.manager=="gitops-agent")] | length')"
[ "$c" -eq 0 ] || { echo "FAIL: gitops-agent touched drifter"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: drifter was left alone"
exit "$fail"
