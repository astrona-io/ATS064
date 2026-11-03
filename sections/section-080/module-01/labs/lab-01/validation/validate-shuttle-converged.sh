#!/usr/bin/env bash
# Check: shuttle is converged: observedGeneration equals generation, every replica is updated and available, and Progressing is True
set -uo pipefail

REPO="$HOME/gitops-lab/lab-080"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

d="$(kubectl -n starfleet get deployment shuttle -o json)"
echo "$d" | jq -e '.status.observedGeneration == .metadata.generation' >/dev/null || { echo "FAIL: the status is not current for the spec"; fail=1; }
echo "$d" | jq -e '(.status.updatedReplicas // 0) == .spec.replicas and (.status.availableReplicas // 0) == .spec.replicas' >/dev/null || { echo "FAIL: not every replica is updated and available"; fail=1; }
echo "$d" | jq -e '[.status.conditions[] | select(.type=="Progressing" and .status=="True")] | length == 1' >/dev/null || { echo "FAIL: Progressing is not True"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: shuttle is converged"
exit "$fail"
