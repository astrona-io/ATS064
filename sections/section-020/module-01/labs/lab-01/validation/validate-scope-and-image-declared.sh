#!/usr/bin/env bash
# Check: The manifest names the namespace starfleet, a pinned image tag and a memory limit
set -uo pipefail

REPO="$HOME/gitops-lab/lab-020"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

f=apps/deployment-scout.yaml
grep -qE '^  namespace: starfleet' "$f" || { echo "FAIL: metadata.namespace is not starfleet"; fail=1; }
grep -qE 'image: ghcr.io/stefanprodan/podinfo:6\.15\.0' "$f" || { echo "FAIL: the image is not pinned to 6.15.0"; fail=1; }
grep -qE 'memory: 128Mi' "$f" || { echo "FAIL: no memory limit of 128Mi"; fail=1; }
grep -qE 'replicas: 2' "$f" || { echo "FAIL: replicas is not 2"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: namespace, image tag, limit and replicas are declared"
exit "$fail"
