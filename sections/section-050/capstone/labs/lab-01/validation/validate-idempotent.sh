#!/usr/bin/env bash
# Check: A second kubectl apply of the whole repository reports every object as unchanged
set -uo pipefail

REPO="$HOME/gitops-lab/cap-050"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

out="$(kubectl apply -R -f apps 2>&1)" || { echo "FAIL: kubectl apply -R -f apps reports an error"; echo "$out"; exit 1; }
echo "$out" | grep -vq 'unchanged' && { echo "FAIL: a repeated apply still changes objects:"; echo "$out" | grep -v unchanged; exit 1; }
echo "PASS: the repeated apply changes nothing"
