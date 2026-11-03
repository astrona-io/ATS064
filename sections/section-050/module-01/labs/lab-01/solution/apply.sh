#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/lab-050"
cd "$REPO"
cat > report.txt <<'EOF'
scout is stuck in a rollout. The new pod has the status ImagePullBackOff because the image tag 6.15.O in apps/deployment-scout.yaml does not exist. The tag has a letter O where a zero belongs.
EOF
sed -i.bak 's/6\.15\.O/6.15.0/' apps/deployment-scout.yaml && rm apps/deployment-scout.yaml.bak
git add report.txt apps/deployment-scout.yaml
git commit -q -m "Fix the scout image tag and report the failed rollout"
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/scout --timeout=120s
