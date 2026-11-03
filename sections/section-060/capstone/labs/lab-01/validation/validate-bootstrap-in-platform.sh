#!/usr/bin/env bash
# Check: platform holds the namespace, ServiceAccount, Role and RoleBinding for gitops-agent, committed and applied
set -uo pipefail

REPO="$HOME/gitops-lab/cap-060"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

for k in Namespace ServiceAccount Role RoleBinding; do
  grep -rqE "^kind: $k" platform 2>/dev/null || { echo "FAIL: no $k manifest under platform"; fail=1; }
done
kubectl -n gitops-system get serviceaccount gitops-agent >/dev/null 2>&1 || { echo "FAIL: ServiceAccount gitops-agent is missing in the cluster"; fail=1; }
kubectl -n starfleet get rolebinding gitops-agent >/dev/null 2>&1 || { echo "FAIL: RoleBinding gitops-agent is missing in starfleet"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the bootstrap objects exist"
exit "$fail"
