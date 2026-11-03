#!/usr/bin/env bash
# Check: The system-made ConfigMap kube-root-ca.crt is not committed
set -uo pipefail

REPO="$HOME/gitops-lab/cap-030"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

if grep -rqE 'kube-root-ca.crt' apps; then echo "FAIL: apps describes the system-made kube-root-ca.crt"; exit 1; fi
echo "PASS: system-made objects are left out"
