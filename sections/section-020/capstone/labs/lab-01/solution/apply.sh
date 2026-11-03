#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/cap-020"
cd "$REPO"
cat > apps/deployment-shuttle.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: shuttle
  namespace: starfleet
  labels:
    app: shuttle
spec:
  replicas: 2
  selector:
    matchLabels:
      app: shuttle
  template:
    metadata:
      labels:
        app: shuttle
    spec:
      containers:
        - name: shuttle
          image: ghcr.io/stefanprodan/podinfo:6.15.0
          envFrom:
            - configMapRef:
                name: shuttle-settings
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
cat > apps/configmap-shuttle-settings.yaml <<'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: shuttle-settings
  namespace: starfleet
data:
  MODE: standard
EOF
git add apps
git commit -q -m "Declare the scope, the image tag and the ConfigMap of shuttle"
kubectl -n default delete deployment shuttle --ignore-not-found
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/shuttle --timeout=120s
