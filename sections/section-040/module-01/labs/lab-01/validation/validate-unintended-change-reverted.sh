#!/usr/bin/env bash
# Check: The memory limit of probe is back to 128Mi in the cluster and unchanged in Git
set -uo pipefail

REPO="$HOME/gitops-lab/lab-040"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

live="$(kubectl -n starfleet get deployment probe -o jsonpath='{.spec.template.spec.containers[0].resources.limits.memory}')"
[ "$live" = "128Mi" ] || { echo "FAIL: the live memory limit of probe is $live"; fail=1; }
git show HEAD:apps/deployment-probe.yaml | grep -qE 'memory: 128Mi' || { echo "FAIL: the committed manifest of probe lost the 128Mi limit"; fail=1; }
git show HEAD:apps/deployment-probe.yaml | grep -qE 'memory: 256Mi' && { echo "FAIL: 256Mi was committed for probe"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the unintended change was reverted"
exit "$fail"
