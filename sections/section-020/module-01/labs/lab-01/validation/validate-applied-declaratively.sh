#!/usr/bin/env bash
# Check: The live scout Deployment was applied from the manifest and kubectl diff shows no difference
set -uo pipefail

REPO="$HOME/gitops-lab/lab-020"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

ann="$(kubectl -n starfleet get deployment scout -o jsonpath='{.metadata.annotations.kubectl\.kubernetes\.io/last-applied-configuration}')"
[ -n "$ann" ] || { echo "FAIL: scout has no last-applied-configuration annotation; it was not applied from a manifest"; exit 1; }
kubectl diff -f apps/deployment-scout.yaml >/dev/null 2>&1
[ "$?" -eq 0 ] || { echo "FAIL: kubectl diff shows differences between the manifest and the cluster"; exit 1; }
echo "PASS: scout is applied from the manifest and matches it"
