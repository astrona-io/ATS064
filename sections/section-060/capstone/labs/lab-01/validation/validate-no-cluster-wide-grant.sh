#!/usr/bin/env bash
# Check: No ClusterRoleBinding or wildcard Role gives gitops-agent cluster-wide or wildcard access
set -uo pipefail

REPO="$HOME/gitops-lab/cap-060"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

n="$(kubectl get clusterrolebindings -o json | jq '[.items[] | select(.subjects[]? | select(.kind=="ServiceAccount" and .name=="gitops-agent"))] | length')"
[ "$n" -eq 0 ] || { echo "FAIL: a ClusterRoleBinding names gitops-agent"; fail=1; }
w="$(kubectl -n starfleet get role gitops-agent -o json 2>/dev/null | jq '[.rules[]? | select((.verbs|index("*")) or (.resources|index("*")) or (.apiGroups|index("*")))] | length')"
[ "${w:-0}" -eq 0 ] || { echo "FAIL: the Role uses a wildcard"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: no cluster-wide or wildcard grant"
exit "$fail"
