#!/usr/bin/env bash
# Check: The file passes a server-side dry run and kubectl diff shows no difference with the live Service
set -uo pipefail

REPO="$HOME/gitops-lab/lab-030"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

kubectl apply --dry-run=server -f apps/service-scout.yaml >/dev/null 2>&1 || { echo "FAIL: the API server rejects apps/service-scout.yaml"; exit 1; }
kubectl diff -f apps/service-scout.yaml >/dev/null 2>&1
[ "$?" -eq 0 ] || { echo "FAIL: the manifest differs from the live Service"; exit 1; }
echo "PASS: the manifest is accepted and matches the cluster"
