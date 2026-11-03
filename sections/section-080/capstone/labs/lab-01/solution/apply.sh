#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/cap-080"
cd "$REPO"
sed -i.bak 's#podinfo:6.99.0#podinfo:6.15.0#' apps/deployment-shuttle.yaml && rm apps/deployment-shuttle.yaml.bak
sed -i.bak 's#/nothere#/readyz#' apps/deployment-drifter.yaml && rm apps/deployment-drifter.yaml.bak
git add -A
git commit -q -m "Fix the image of shuttle and the readiness path of drifter"
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/shuttle --timeout=180s
kubectl -n starfleet rollout status deployment/drifter --timeout=180s
kubectl -n starfleet delete configmap sync-status --ignore-not-found
kubectl -n starfleet create configmap sync-status --from-literal=revision="$(git rev-parse HEAD)" --from-literal=result=Synced --from-literal=failed-before=drifter,shuttle
