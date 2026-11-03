#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/lab-040"
cd "$REPO"
sed -i.bak 's/^  replicas: 2$/  replicas: 5/' apps/deployment-scout.yaml && rm apps/deployment-scout.yaml.bak
cat > drift-report.md <<'EOF'
# Drift report

- scout: spec.replicas is 5 live and 2 in Git. Decision: adopt. The scale was deliberate, so Git now states 5.
- probe: the memory limit is 256Mi live and 128Mi in Git. Decision: revert. Nobody decided the change.
EOF
git add apps drift-report.md
git commit -q -m "Adopt five replicas for scout and report the drift"
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/probe --timeout=120s
