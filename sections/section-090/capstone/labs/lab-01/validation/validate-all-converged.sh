#!/usr/bin/env bash
# Check: kubectl diff shows no difference and every Deployment in starfleet is converged
set -uo pipefail

REPO="$HOME/gitops-lab/cap-090"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

kubectl diff -R -f apps >/dev/null 2>&1
rc=$?
[ "$rc" -eq 0 ] || { echo "FAIL: kubectl diff -R -f apps exited with $rc"; fail=1; }
for name in $(kubectl -n starfleet get deployments -o jsonpath='{.items[*].metadata.name}'); do
  d="$(kubectl -n starfleet get deployment "$name" -o json)"
  echo "$d" | jq -e '.status.observedGeneration == .metadata.generation and (.status.updatedReplicas // 0) == .spec.replicas and (.status.availableReplicas // 0) == .spec.replicas' >/dev/null || { echo "FAIL: $name is not converged"; fail=1; }
done
[ "$fail" -eq 0 ] && echo "PASS: the cluster matches Git and every Deployment is converged"
exit "$fail"
