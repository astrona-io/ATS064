#!/usr/bin/env bash
# Check: probe runs without a privileged container, with every replica updated and available
set -uo pipefail

REPO="$HOME/gitops-lab/cap-060"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

git show HEAD:apps/deployment-probe.yaml | grep -qE 'privileged: true' && { echo "FAIL: the committed probe manifest is still privileged"; fail=1; }
priv="$(kubectl -n starfleet get deployment probe -o jsonpath='{.spec.template.spec.containers[0].securityContext.privileged}')"
[ "$priv" != "true" ] || { echo "FAIL: the live probe is privileged"; fail=1; }
want="$(kubectl -n starfleet get deployment probe -o jsonpath='{.spec.replicas}')"
upd="$(kubectl -n starfleet get deployment probe -o jsonpath='{.status.updatedReplicas}')"
avail="$(kubectl -n starfleet get deployment probe -o jsonpath='{.status.availableReplicas}')"
[ "${upd:-0}" = "$want" ] && [ "${avail:-0}" = "$want" ] || { echo "FAIL: probe has updated=$upd available=$avail of $want"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: probe is compliant and converged"
exit "$fail"
