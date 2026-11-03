#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/lab-080"
cd "$REPO"
kubectl -n starfleet get deployment shuttle -o json | jq -r '.status.conditions[] | select(.type=="Progressing") | .reason' > feedback.txt
sed -i.bak 's#/nothere#/readyz#' apps/deployment-shuttle.yaml && rm apps/deployment-shuttle.yaml.bak
git add -A
git commit -q -m "Fix the readiness path of shuttle"
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/shuttle --timeout=180s
