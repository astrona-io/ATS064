#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/lab-090"
cd "$REPO"
git revert --no-edit HEAD
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/probe --timeout=180s
