#!/usr/bin/env bash
# Check: scout, probe and shuttle match their manifests in replicas and memory limit
set -uo pipefail

REPO="$HOME/gitops-lab/cap-040"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

for n in scout probe shuttle; do
  want="$(grep -E '^  replicas:' apps/deployment-$n.yaml | awk '{print $2}')"
  have="$(kubectl -n starfleet get deployment $n -o jsonpath='{.spec.replicas}')"
  [ "$want" = "$have" ] || { echo "FAIL: $n has $have replicas and Git states $want"; fail=1; }
  kubectl diff -f apps/deployment-$n.yaml >/dev/null 2>&1
  [ "$?" -eq 0 ] || { echo "FAIL: kubectl diff shows differences for $n"; fail=1; }
done
[ "$fail" -eq 0 ] && echo "PASS: starfleet matches Git"
exit "$fail"
