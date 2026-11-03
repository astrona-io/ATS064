#!/usr/bin/env bash
# Check: The ConfigMap visitor-log still exists with count 42
set -uo pipefail

REPO="$HOME/gitops-lab/cap-090"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

c="$(kubectl -n starfleet get configmap visitor-log -o jsonpath='{.data.count}' 2>/dev/null)"
[ "$c" = "42" ] || { echo "FAIL: visitor-log count is '$c', expected 42"; exit 1; }
echo "PASS: the runtime data survived the rollback"
