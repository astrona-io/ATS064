#!/usr/bin/env bash
# Check: shuttle reads the ConfigMap and has an available replica
set -uo pipefail

REPO="$HOME/gitops-lab/cap-020"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

ref="$(kubectl -n starfleet get deployment shuttle -o jsonpath='{.spec.template.spec.containers[0].envFrom[0].configMapRef.name}')"
[ "$ref" = "shuttle-settings" ] || { echo "FAIL: shuttle does not read shuttle-settings (found: $ref)"; fail=1; }
avail="$(kubectl -n starfleet get deployment shuttle -o jsonpath='{.status.availableReplicas}')"
[ "${avail:-0}" -ge 1 ] || { echo "FAIL: shuttle has no available replica"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: shuttle uses the ConfigMap and is available"
exit "$fail"
