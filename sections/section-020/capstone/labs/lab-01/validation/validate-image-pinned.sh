#!/usr/bin/env bash
# Check: The shuttle manifest pins the image tag 6.15.0 and the live pods run it
set -uo pipefail

REPO="$HOME/gitops-lab/cap-020"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

grep -qE 'image: ghcr.io/stefanprodan/podinfo:6\.15\.0' apps/deployment-shuttle.yaml || { echo "FAIL: the manifest does not pin the image to 6.15.0"; fail=1; }
live="$(kubectl -n starfleet get deployment shuttle -o jsonpath='{.spec.template.spec.containers[0].image}')"
[ "$live" = "ghcr.io/stefanprodan/podinfo:6.15.0" ] || { echo "FAIL: the live image is $live"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the image is pinned"
exit "$fail"
