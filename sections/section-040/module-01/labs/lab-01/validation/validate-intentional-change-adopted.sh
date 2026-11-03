#!/usr/bin/env bash
# Check: The committed manifest of scout states 5 replicas, matching the live Deployment
set -uo pipefail

REPO="$HOME/gitops-lab/lab-040"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

git show HEAD:apps/deployment-scout.yaml | grep -qE '^  replicas: 5$' || { echo "FAIL: the committed manifest of scout does not state replicas: 5"; exit 1; }
live="$(kubectl -n starfleet get deployment scout -o jsonpath='{.spec.replicas}')"
[ "$live" = "5" ] || { echo "FAIL: scout has $live live replicas"; exit 1; }
echo "PASS: the deliberate change is in Git and live"
