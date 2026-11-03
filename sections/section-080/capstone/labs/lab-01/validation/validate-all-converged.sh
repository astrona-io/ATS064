#!/usr/bin/env bash
# Check: Every Deployment in starfleet is converged: current status, all replicas updated and available, Progressing True
set -uo pipefail

REPO="$HOME/gitops-lab/cap-080"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

for name in $(kubectl -n starfleet get deployments -o jsonpath='{.items[*].metadata.name}'); do
  d="$(kubectl -n starfleet get deployment "$name" -o json)"
  echo "$d" | jq -e '.status.observedGeneration == .metadata.generation and (.status.updatedReplicas // 0) == .spec.replicas and (.status.availableReplicas // 0) == .spec.replicas and ([.status.conditions[] | select(.type=="Progressing" and .status=="True")] | length == 1)' >/dev/null || { echo "FAIL: $name is not converged"; fail=1; }
done
[ "$fail" -eq 0 ] && echo "PASS: every Deployment is converged"
exit "$fail"
