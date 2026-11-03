#!/usr/bin/env bash
# Check: No file in apps holds a generated or allocated field
set -uo pipefail

REPO="$HOME/gitops-lab/cap-030"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

found="$(grep -rnE '^[[:space:]]*(uid|resourceVersion|creationTimestamp|generation|managedFields|clusterIP|clusterIPs|selfLink):|^status:' apps || true)"
[ -z "$found" ] || { echo "FAIL: generated fields found:"; echo "$found"; exit 1; }
echo "PASS: no generated fields in apps"
