#!/usr/bin/env bash
# Check: One pass of reconcile.sh returns a manually changed Deployment to the value in Git
set -uo pipefail

REPO="$HOME/gitops-lab/lab-010"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -x reconcile.sh ] || { echo "FAIL: reconcile.sh is missing or not executable"; exit 1; }
want="$(grep -E '^  replicas:' apps/deployment-probe.yaml | awk '{print $2}')"
kubectl -n starfleet scale deployment probe --replicas=3 >/dev/null
( cd /tmp && RECONCILE_ONCE=1 timeout 120 bash "$REPO/reconcile.sh" >/dev/null 2>&1 )
have="$(kubectl -n starfleet get deployment probe -o jsonpath='{.spec.replicas}')"
if [ "$have" != "$want" ]; then echo "FAIL: after one pass probe has $have replicas, Git declares $want"; exit 1; fi
echo "PASS: one pass restored probe to $want replica(s)"
