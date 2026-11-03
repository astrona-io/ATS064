#!/usr/bin/env bash
# Check: The agent identity may not read secrets, delete namespaces or change deployments in outpost
set -uo pipefail

REPO="$HOME/gitops-lab/lab-060"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

ans="$(kubectl auth can-i get secrets -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "no" ] || { echo "FAIL: can read secrets in starfleet (answer: $ans, expected: no)"; fail=1; }
ans="$(kubectl auth can-i delete namespaces  --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "no" ] || { echo "FAIL: can delete namespaces (answer: $ans, expected: no)"; fail=1; }
ans="$(kubectl auth can-i patch deployments -n outpost --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "no" ] || { echo "FAIL: can patch deployments in outpost (answer: $ans, expected: no)"; fail=1; }
ans="$(kubectl auth can-i delete deployments -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "no" ] || { echo "FAIL: can delete deployments in starfleet (answer: $ans, expected: no)"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the agent is limited to what it needs"
exit "$fail"
