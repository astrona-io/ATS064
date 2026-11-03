#!/usr/bin/env bash
# Check: Every manifest in apps is valid and the ConfigMap outpost-notes exists with retries "3"
set -uo pipefail

REPO="$HOME/gitops-lab/cap-050"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

kubectl apply --dry-run=client -R -f apps >/dev/null 2>&1 || { echo "FAIL: at least one manifest in apps is not valid"; exit 1; }
r="$(kubectl -n outpost get configmap outpost-notes -o jsonpath='{.data.retries}' 2>/dev/null)"
[ "$r" = "3" ] || { echo "FAIL: ConfigMap outpost-notes has retries=\"$r\""; exit 1; }
echo "PASS: manifests are valid and applied"
