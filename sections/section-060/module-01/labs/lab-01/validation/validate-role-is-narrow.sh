#!/usr/bin/env bash
# Check: A Role gitops-agent exists in starfleet without wildcards and covers deployments, services and configmaps
set -uo pipefail

REPO="$HOME/gitops-lab/lab-060"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

r="$(kubectl -n starfleet get role gitops-agent -o json 2>/dev/null)" || { echo "FAIL: no Role gitops-agent in starfleet"; exit 1; }
wild="$(echo "$r" | jq '[.rules[] | select((.verbs|index("*")) or (.resources|index("*")) or (.apiGroups|index("*")))] | length')"
[ "$wild" -eq 0 ] || { echo "FAIL: the Role uses a wildcard"; fail=1; }
for res in deployments services configmaps; do
  echo "$r" | jq -e --arg x "$res" '[.rules[] | select(.resources|index($x))] | length > 0' >/dev/null || { echo "FAIL: the Role does not cover $res"; fail=1; }
done
[ "$fail" -eq 0 ] && echo "PASS: the Role is explicit and covers the needed kinds"
exit "$fail"
