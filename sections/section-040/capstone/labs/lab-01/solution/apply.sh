#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/cap-040"
cd "$REPO"
for n in scout probe shuttle; do
  kubectl apply --server-side --field-manager=gitops-agent --force-conflicts -f apps/deployment-$n.yaml
done
kubectl apply --server-side --field-manager=gitops-agent --force-conflicts -f apps/service-scout.yaml
kubectl -n starfleet rollout status deployment/shuttle --timeout=120s
