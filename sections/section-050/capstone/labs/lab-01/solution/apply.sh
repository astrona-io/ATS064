#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/cap-050"
cd "$REPO"
sed -i.bak 's/6\.15\.O/6.15.0/' apps/deployment-shuttle.yaml && rm apps/deployment-shuttle.yaml.bak
sed -i.bak 's/pods: "2"/pods: "4"/' apps/resourcequota-outpost.yaml && rm apps/resourcequota-outpost.yaml.bak
sed -i.bak 's/retries: 3/retries: "3"/' apps/configmap-outpost-notes.yaml && rm apps/configmap-outpost-notes.yaml.bak
git add apps
git commit -q -m "Fix the shuttle tag, raise the outpost quota and quote the retries value"
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/shuttle --timeout=120s
kubectl -n outpost rollout status deployment/drifter --timeout=180s
