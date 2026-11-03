#!/usr/bin/env bash
# Check: The Service keeps its name, namespace, selector and port 9898
set -uo pipefail

REPO="$HOME/gitops-lab/lab-030"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

f=apps/service-scout.yaml
grep -qE '^  name: scout' "$f" || { echo "FAIL: name scout is missing"; fail=1; }
grep -qE '^  namespace: starfleet' "$f" || { echo "FAIL: namespace starfleet is missing"; fail=1; }
grep -qE 'app: scout' "$f" || { echo "FAIL: the selector app: scout is missing"; fail=1; }
grep -qE 'port: 9898' "$f" || { echo "FAIL: port 9898 is missing"; fail=1; }
grep -qE 'targetPort: 9898' "$f" || { echo "FAIL: targetPort 9898 is missing"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the declared intent is kept"
exit "$fail"
