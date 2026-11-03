#!/usr/bin/env bash
# Check: The namespace starfleet enforces the baseline Pod Security level, and the label is declared in Git
set -uo pipefail

REPO="$HOME/gitops-lab/cap-060"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

live="$(kubectl get namespace starfleet -o jsonpath='{.metadata.labels.pod-security\.kubernetes\.io/enforce}')"
[ "$live" = "baseline" ] || { echo "FAIL: the live enforce level of starfleet is '$live'"; fail=1; }
git show HEAD:apps/namespaces.yaml | grep -qE 'pod-security.kubernetes.io/enforce: baseline' || { echo "FAIL: the label is not in apps/namespaces.yaml at HEAD"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: baseline is enforced and declared"
exit "$fail"
