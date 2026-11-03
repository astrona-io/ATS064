#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/lab-030"
cd "$REPO"
cat > apps/service-scout.yaml <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: scout
  namespace: starfleet
  labels:
    app: scout
spec:
  selector:
    app: scout
  ports:
    - port: 9898
      protocol: TCP
      targetPort: 9898
  type: ClusterIP
EOF
git add apps/service-scout.yaml
git commit -q -m "Keep only the declared fields of the scout Service"
kubectl apply -f apps/service-scout.yaml
