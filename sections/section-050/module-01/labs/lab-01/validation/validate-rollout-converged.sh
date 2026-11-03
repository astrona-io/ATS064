#!/usr/bin/env bash
# Check: The scout Deployment has finished its rollout with the image 6.15.0 and no pod waits on an image pull
set -uo pipefail

REPO="$HOME/gitops-lab/lab-050"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

want="$(kubectl -n starfleet get deployment scout -o jsonpath='{.spec.replicas}')"
upd="$(kubectl -n starfleet get deployment scout -o jsonpath='{.status.updatedReplicas}')"
avail="$(kubectl -n starfleet get deployment scout -o jsonpath='{.status.availableReplicas}')"
[ "${upd:-0}" = "$want" ] && [ "${avail:-0}" = "$want" ] || { echo "FAIL: scout has updated=$upd available=$avail of $want"; exit 1; }
img="$(kubectl -n starfleet get deployment scout -o jsonpath='{.spec.template.spec.containers[0].image}')"
[ "$img" = "ghcr.io/stefanprodan/podinfo:6.15.0" ] || { echo "FAIL: the live image is $img"; exit 1; }
bad="$(kubectl -n starfleet get pods -l app=scout -o json | jq '[.items[].status.containerStatuses[]? | select(.state.waiting.reason=="ImagePullBackOff" or .state.waiting.reason=="ErrImagePull")] | length')"
[ "$bad" -eq 0 ] || { echo "FAIL: $bad pods still wait on an image pull"; exit 1; }
echo "PASS: the rollout converged"
