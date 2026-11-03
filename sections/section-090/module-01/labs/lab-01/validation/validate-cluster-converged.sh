#!/usr/bin/env bash
# Check: kubectl diff shows no difference and probe is converged with its image restored
set -uo pipefail

REPO="$HOME/gitops-lab/lab-090"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

kubectl diff -R -f apps >/dev/null 2>&1
rc=$?
[ "$rc" -eq 0 ] || { echo "FAIL: kubectl diff -R -f apps exited with $rc"; fail=1; }
d="$(kubectl -n starfleet get deployment probe -o json)"
echo "$d" | jq -e '.status.observedGeneration == .metadata.generation and (.status.updatedReplicas // 0) == .spec.replicas and (.status.availableReplicas // 0) == .spec.replicas' >/dev/null || { echo "FAIL: probe is not converged"; fail=1; }
echo "$d" | jq -e '.spec.template.spec.containers[0].image | contains("6.99.0") | not' >/dev/null || { echo "FAIL: probe still uses the missing image tag"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the cluster matches Git and probe is converged"
exit "$fail"
