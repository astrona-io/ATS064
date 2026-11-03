#!/usr/bin/env bash
# Check: The Service shuttle is declared in Git with port 9898 and the selector app: shuttle
set -uo pipefail

REPO="$HOME/gitops-lab/cap-030"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

kubectl apply --dry-run=client -R -f apps -o name 2>/dev/null | grep -qx 'service/shuttle' || { echo "FAIL: apps does not produce service/shuttle"; exit 1; }
f="$(grep -rlE '^kind: Service' apps | xargs grep -lE 'name: shuttle' | head -1)"
[ -n "$f" ] || { echo "FAIL: no Service manifest for shuttle"; exit 1; }
grep -qE 'app: shuttle' "$f" || { echo "FAIL: the selector app: shuttle is missing in $f"; exit 1; }
grep -qE 'port: 9898' "$f" || { echo "FAIL: port 9898 is missing in $f"; exit 1; }
git ls-files --error-unmatch "$f" >/dev/null 2>&1 || { echo "FAIL: $f is not committed"; exit 1; }
echo "PASS: service shuttle is described in Git"
