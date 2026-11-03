#!/usr/bin/env bash
# Check: drift-report.md names both drifted objects and fields and is committed
set -uo pipefail

REPO="$HOME/gitops-lab/lab-040"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

f=drift-report.md
[ -f "$f" ] || { echo "FAIL: $f does not exist"; exit 1; }
git ls-files --error-unmatch "$f" >/dev/null 2>&1 || { echo "FAIL: $f is not committed"; exit 1; }
for w in scout probe replicas memory 256Mi 128Mi; do
  grep -qi "$w" "$f" || { echo "FAIL: $f does not mention $w"; fail=1; }
done
[ "$fail" -eq 0 ] && echo "PASS: the drift report names the drifted objects, fields and values"
exit "$fail"
