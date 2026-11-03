#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/cap-090"
cd "$REPO"
c4="$(git rev-parse HEAD)"
c2="$(git rev-list --reverse seed | sed -n 2p)"
git revert --no-edit "$c4"
git revert --no-edit "$c2"
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/probe --timeout=180s
kubectl -n starfleet rollout status deployment/shuttle --timeout=180s
