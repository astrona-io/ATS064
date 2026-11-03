#!/usr/bin/env bash
# Check: The cluster matches the files of release-1 and shuttle has no EXPERIMENTAL_MODE variable
set -uo pipefail

REPO="$HOME/gitops-lab/lab-070"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

WORK="$(mktemp -d)"
git archive release-1 apps | tar -x -C "$WORK" || { echo "FAIL: cannot export release-1"; exit 1; }
kubectl diff -R -f "$WORK/apps" >/dev/null 2>&1
rc=$?
rm -rf "$WORK"
[ "$rc" -eq 0 ] || { echo "FAIL: the cluster differs from release-1 (kubectl diff exit $rc)"; fail=1; }
n="$(kubectl -n starfleet get deployment shuttle -o json | jq '[.spec.template.spec.containers[].env[]? | select(.name=="EXPERIMENTAL_MODE")] | length')"
[ "$n" -eq 0 ] || { echo "FAIL: shuttle still has EXPERIMENTAL_MODE"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the cluster is at the release revision"
exit "$fail"
