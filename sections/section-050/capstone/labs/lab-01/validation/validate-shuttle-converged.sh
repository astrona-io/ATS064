#!/usr/bin/env bash
# Check: shuttle runs the image 6.15.0 with every replica updated and available
set -uo pipefail

REPO="$HOME/gitops-lab/cap-050"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

git show HEAD:apps/deployment-shuttle.yaml | grep -qE 'image: ghcr.io/stefanprodan/podinfo:6\.15\.0$' || { echo "FAIL: HEAD does not state the image 6.15.0 for shuttle"; exit 1; }
want="$(kubectl -n starfleet get deployment shuttle -o jsonpath='{.spec.replicas}')"
upd="$(kubectl -n starfleet get deployment shuttle -o jsonpath='{.status.updatedReplicas}')"
avail="$(kubectl -n starfleet get deployment shuttle -o jsonpath='{.status.availableReplicas}')"
[ "${upd:-0}" = "$want" ] && [ "${avail:-0}" = "$want" ] || { echo "FAIL: shuttle has updated=$upd available=$avail of $want"; exit 1; }
echo "PASS: shuttle converged"
