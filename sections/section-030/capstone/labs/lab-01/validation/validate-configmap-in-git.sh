#!/usr/bin/env bash
# Check: The ConfigMap scout-settings is declared in Git with its live data
set -uo pipefail

REPO="$HOME/gitops-lab/cap-030"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

grep -rqE '^kind: ConfigMap' apps && grep -rqE 'name: scout-settings' apps || { echo "FAIL: no manifest in apps declares the ConfigMap scout-settings"; exit 1; }
kubectl apply --dry-run=client -R -f apps -o name 2>/dev/null | grep -qx 'configmap/scout-settings' || { echo "FAIL: apps does not produce configmap/scout-settings"; exit 1; }
ll="$(kubectl -n starfleet get configmap scout-settings -o jsonpath='{.data.LOG_LEVEL}')"
rg="$(kubectl -n starfleet get configmap scout-settings -o jsonpath='{.data.REGION}')"
[ "$ll" = "info" ] && [ "$rg" = "outpost-1" ] || { echo "FAIL: the live data changed (LOG_LEVEL=$ll REGION=$rg)"; exit 1; }
git ls-files --error-unmatch $(grep -rlE 'name: scout-settings' apps) >/dev/null 2>&1 || { echo "FAIL: the ConfigMap manifest is not committed"; exit 1; }
echo "PASS: scout-settings is described in Git and the live data is unchanged"
