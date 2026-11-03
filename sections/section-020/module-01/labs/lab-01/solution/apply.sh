#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/lab-020"
cd "$REPO"
cat > apps/deployment-scout.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: scout
  namespace: starfleet
  labels:
    app: scout
spec:
  replicas: 2
  selector:
    matchLabels:
      app: scout
  template:
    metadata:
      labels:
        app: scout
    spec:
      containers:
        - name: podinfo
          image: ghcr.io/stefanprodan/podinfo:6.15.0
          ports:
            - containerPort: 9898
          readinessProbe:
            httpGet:
              path: /readyz
              port: 9898
            periodSeconds: 3
          resources:
            requests:
              cpu: 10m
              memory: 32Mi
            limits:
              memory: 128Mi
EOF
git add apps/deployment-scout.yaml
git commit -q -m "Declare the scout Deployment"
kubectl apply -f apps/deployment-scout.yaml
kubectl -n starfleet rollout status deployment/scout --timeout=120s
