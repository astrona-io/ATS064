#!/usr/bin/env bash
# Check: The ConfigMap shuttle-settings is declared in Git and exists in the cluster with the key MODE
set -uo pipefail

REPO="$HOME/gitops-lab/cap-020"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

ls apps | grep -qi 'configmap' || { echo "FAIL: no ConfigMap manifest in apps"; exit 1; }
grep -rqE 'name: shuttle-settings' apps || { echo "FAIL: no manifest declares shuttle-settings"; exit 1; }
mode="$(kubectl -n starfleet get configmap shuttle-settings -o jsonpath='{.data.MODE}' 2>/dev/null)"
[ -n "$mode" ] || { echo "FAIL: ConfigMap shuttle-settings has no key MODE in the cluster"; exit 1; }
echo "PASS: the dependency is declared and applied"
