#!/usr/bin/env bash
# Check: The ServiceAccount gitops-agent exists in gitops-system and is declared in a committed file under platform
set -uo pipefail

REPO="$HOME/gitops-lab/lab-060"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

grep -rlE '^kind: ServiceAccount' platform 2>/dev/null | xargs grep -lE 'name: gitops-agent' >/dev/null 2>&1 || { echo "FAIL: no ServiceAccount gitops-agent manifest under platform"; exit 1; }
kubectl -n gitops-system get serviceaccount gitops-agent >/dev/null 2>&1 || { echo "FAIL: the ServiceAccount gitops-agent does not exist in gitops-system"; exit 1; }
echo "PASS: the identity is declared and exists"
