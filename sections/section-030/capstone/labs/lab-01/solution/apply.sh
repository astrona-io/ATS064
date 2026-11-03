#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/cap-030"
cd "$REPO"
cat > apps/configmap-scout-settings.yaml <<'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: scout-settings
  namespace: starfleet
data:
  LOG_LEVEL: info
  REGION: outpost-1
EOF
cat > apps/service-shuttle.yaml <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: shuttle
  namespace: starfleet
  labels:
    app: shuttle
spec:
  selector:
    app: shuttle
  ports:
    - name: "9898"
      port: 9898
      protocol: TCP
      targetPort: 9898
  type: ClusterIP
EOF
git add apps
git commit -q -m "Describe the ConfigMap and the Service that were made by hand"
kubectl apply -R -f apps
