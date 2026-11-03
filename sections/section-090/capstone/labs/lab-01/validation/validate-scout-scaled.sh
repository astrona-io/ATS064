#!/usr/bin/env bash
# Check: scout runs 3 replicas, so the good change between the bad commits is live
set -uo pipefail

REPO="$HOME/gitops-lab/cap-090"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

r="$(kubectl -n starfleet get deployment scout -o jsonpath='{.spec.replicas}')"
[ "$r" = "3" ] || { echo "FAIL: scout has $r replicas, expected 3"; exit 1; }
echo "PASS: scout still has 3 replicas"
