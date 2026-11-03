#!/usr/bin/env bash
# Check: report.txt names the failing object, the failure reason and the wrong tag, and is committed
set -uo pipefail

REPO="$HOME/gitops-lab/lab-050"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

f=report.txt
[ -f "$f" ] || { echo "FAIL: $f does not exist"; exit 1; }
git ls-files --error-unmatch "$f" >/dev/null 2>&1 || { echo "FAIL: $f is not committed"; exit 1; }
grep -qi 'scout' "$f" || { echo "FAIL: $f does not name scout"; fail=1; }
grep -qE 'ImagePullBackOff|ErrImagePull' "$f" || { echo "FAIL: $f does not name the failure reason"; fail=1; }
grep -qF '6.15.O' "$f" || { echo "FAIL: $f does not name the wrong tag 6.15.O"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the report names the object, the reason and the tag"
exit "$fail"
