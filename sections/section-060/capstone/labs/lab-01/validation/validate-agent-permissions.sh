#!/usr/bin/env bash
# Check: The agent may deliver and read pods in starfleet but may not delete pods, read secrets or change roles
set -uo pipefail

REPO="$HOME/gitops-lab/cap-060"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

ans="$(kubectl auth can-i patch deployments -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "yes" ] || { echo "FAIL: cannot patch deployments (answer: $ans, expected: yes)"; fail=1; }
ans="$(kubectl auth can-i create configmaps -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "yes" ] || { echo "FAIL: cannot create configmaps (answer: $ans, expected: yes)"; fail=1; }
ans="$(kubectl auth can-i get pods -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "yes" ] || { echo "FAIL: cannot read pods (answer: $ans, expected: yes)"; fail=1; }
ans="$(kubectl auth can-i delete pods -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "no" ] || { echo "FAIL: can delete pods (answer: $ans, expected: no)"; fail=1; }
ans="$(kubectl auth can-i get secrets -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "no" ] || { echo "FAIL: can read secrets (answer: $ans, expected: no)"; fail=1; }
ans="$(kubectl auth can-i create roles -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "no" ] || { echo "FAIL: can create roles (answer: $ans, expected: no)"; fail=1; }
ans="$(kubectl auth can-i create rolebindings -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "no" ] || { echo "FAIL: can create rolebindings (answer: $ans, expected: no)"; fail=1; }
ans="$(kubectl auth can-i patch deployments -n outpost --as=system:serviceaccount:gitops-system:gitops-agent 2>/dev/null)"
[ "$ans" = "no" ] || { echo "FAIL: can patch deployments in outpost (answer: $ans, expected: no)"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the permissions are exactly what the job needs"
exit "$fail"
