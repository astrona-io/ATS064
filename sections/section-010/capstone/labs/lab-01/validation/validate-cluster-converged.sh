#!/usr/bin/env bash
# Check: scout, probe and shuttle in the cluster match the replica counts in the latest commit
set -uo pipefail

REPO="$HOME/gitops-lab/cap-010"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

for name in scout probe shuttle; do
  want="$(grep -E '^  replicas:' apps/deployment-$name.yaml | awk '{print $2}')"
  have="$(kubectl -n starfleet get deployment "$name" -o jsonpath='{.spec.replicas}')"
  ready="$(kubectl -n starfleet get deployment "$name" -o jsonpath='{.status.availableReplicas}')"
  if [ "$have" != "$want" ] || [ "${ready:-0}" != "$want" ]; then echo "FAIL: $name has $have declared and ${ready:-0} available, Git declares $want"; fail=1; fi
done
[ "$fail" -eq 0 ] && echo "PASS: all three Deployments match Git"
exit "$fail"
