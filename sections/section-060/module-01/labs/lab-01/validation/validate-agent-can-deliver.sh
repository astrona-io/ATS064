#!/usr/bin/env bash
# Check: The agent identity may patch deployments and create services and configmaps in starfleet
set -uo pipefail

REPO="$HOME/gitops-lab/lab-060"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

ans="$(kubectl auth can-i patch deployments -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "yes" ] || { echo "FAIL: cannot patch deployments in starfleet (answer: $ans, expected: yes)"; fail=1; }
ans="$(kubectl auth can-i create services -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "yes" ] || { echo "FAIL: cannot create services in starfleet (answer: $ans, expected: yes)"; fail=1; }
ans="$(kubectl auth can-i create configmaps -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "yes" ] || { echo "FAIL: cannot create configmaps in starfleet (answer: $ans, expected: yes)"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the agent can deliver in starfleet"
exit "$fail"
