#!/usr/bin/env bash
# Check: The scout pods have exactly one container, named podinfo
set -uo pipefail

REPO="$HOME/gitops-lab/lab-020"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

names="$(kubectl -n starfleet get deployment scout -o jsonpath='{.spec.template.spec.containers[*].name}')"
[ "$names" = "podinfo" ] || { echo "FAIL: the containers of scout are: $names"; exit 1; }
echo "PASS: scout has one container named podinfo"
