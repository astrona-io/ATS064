#!/usr/bin/env bash
# Check: apps/service-scout.yaml holds no uid, resourceVersion, creationTimestamp, clusterIP, clusterIPs or status
set -uo pipefail

REPO="$HOME/gitops-lab/lab-030"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

f=apps/service-scout.yaml
[ -f "$f" ] || { echo "FAIL: $f does not exist"; exit 1; }
found="$(grep -nE '^[[:space:]]*(uid|resourceVersion|creationTimestamp|generation|managedFields|clusterIP|clusterIPs|selfLink):|^status:' "$f" || true)"
[ -z "$found" ] || { echo "FAIL: generated fields are still in $f:"; echo "$found"; exit 1; }
echo "PASS: no generated fields in $f"
