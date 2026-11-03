#!/usr/bin/env bash
# Check: The quota in outpost allows at least 3 pods in Git and live, and drifter has 3 available replicas
set -uo pipefail

REPO="$HOME/gitops-lab/cap-050"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

git show HEAD:apps/resourcequota-outpost.yaml | grep -qE 'pods: "?([3-9]|[1-9][0-9]+)"?$' || { echo "FAIL: the committed quota does not allow 3 pods"; fail=1; }
hard="$(kubectl -n outpost get resourcequota outpost-quota -o jsonpath='{.spec.hard.pods}')"
[ "${hard:-0}" -ge 3 ] || { echo "FAIL: the live quota allows $hard pods"; fail=1; }
avail="$(kubectl -n outpost get deployment drifter -o jsonpath='{.status.availableReplicas}')"
[ "${avail:-0}" -ge 3 ] || { echo "FAIL: drifter has ${avail:-0} available replicas"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the quota fits the deployment and drifter converged"
exit "$fail"
