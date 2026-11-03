#!/usr/bin/env bash
# Check: The scout Deployment in the cluster matches the replica count in the latest commit
set -uo pipefail

REPO="$HOME/gitops-lab/lab-010"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

want="$(grep -E '^  replicas:' apps/deployment-scout.yaml | awk '{print $2}')"
have="$(kubectl -n starfleet get deployment scout -o jsonpath='{.spec.replicas}')"
ready="$(kubectl -n starfleet get deployment scout -o jsonpath='{.status.availableReplicas}')"
if [ "$have" != "$want" ]; then echo "FAIL: scout has $have replicas, the latest commit declares $want"; fail=1; fi
if [ "${ready:-0}" != "$want" ]; then echo "FAIL: only ${ready:-0} of $want scout pods are available"; fail=1; fi
[ "$fail" -eq 0 ] && echo "PASS: scout matches the latest commit"
exit "$fail"
