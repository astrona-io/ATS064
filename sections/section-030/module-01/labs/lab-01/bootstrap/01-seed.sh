#!/usr/bin/env bash
# Starting state for the desired state lab. Environment only: it builds the Git repository (the
# state store) at ~/gitops-lab/lab-030 and applies one revision of it to the cluster.
# The problems the learner must solve are left in place on purpose.
set -euo pipefail

REPO="$HOME/gitops-lab/lab-030"

commit_as() {
  git add -A
  git -c user.name="$1" -c user.email="$1@example.com" commit -q -m "$2"
}

seed_repo() {
  git init -q -b main
  git config user.name "Starfleet Operator"
  git config user.email "operator@example.com"
  mkdir -p apps
  mkdir -p "$(dirname apps/namespaces.yaml)"
  cat > apps/namespaces.yaml <<'EOF'
apiVersion: v1
kind: Namespace
metadata:
  name: starfleet
---
apiVersion: v1
kind: Namespace
metadata:
  name: outpost
EOF
  mkdir -p "$(dirname apps/deployment-scout.yaml)"
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
        - name: scout
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
  mkdir -p "$(dirname apps/service-scout.yaml)"
  cat > apps/service-scout.yaml <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: scout
  namespace: starfleet
spec:
  selector:
    app: scout
  ports:
    - port: 9898
      targetPort: 9898
EOF
  mkdir -p "$(dirname apps/deployment-probe.yaml)"
  cat > apps/deployment-probe.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: probe
  namespace: starfleet
  labels:
    app: probe
spec:
  replicas: 1
  selector:
    matchLabels:
      app: probe
  template:
    metadata:
      labels:
        app: probe
    spec:
      containers:
        - name: probe
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
  mkdir -p "$(dirname apps/deployment-shuttle.yaml)"
  cat > apps/deployment-shuttle.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: shuttle
  namespace: starfleet
  labels:
    app: shuttle
spec:
  replicas: 1
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
  commit_as "Starfleet Operator" "Add the starfleet workloads"
  mkdir -p "$(dirname apps/service-scout.yaml)"
  cat > apps/service-scout.yaml <<'EOF'
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2026-01-10T09:00:00Z"
  labels:
    app: scout
  name: scout
  namespace: starfleet
  resourceVersion: "48213"
  uid: 5b1f0c0e-1111-4222-8333-444455556666
spec:
  clusterIP: 10.96.14.20
  clusterIPs:
    - 10.96.14.20
  ports:
    - port: 9898
      protocol: TCP
      targetPort: 9898
  selector:
    app: scout
  type: ClusterIP
status:
  loadBalancer: {}
EOF
  commit_as "Starfleet Operator" "Replace the scout Service with an export from the cluster"
}

mkdir -p "$REPO"
cd "$REPO"
if [ -d .git ] && git rev-parse -q --verify refs/tags/seed >/dev/null; then
  # A previous run left this repository: return it to the starting state.
  git checkout -q -f main
  git reset -q --hard seed
  git clean -qfdx
else
  seed_repo
  git tag seed
fi

# Apply one revision of the repository to the cluster.
WORK="$(mktemp -d)"
git archive HEAD~1 apps | tar -x -C "$WORK"
kubectl apply -f "$WORK/apps/namespaces.yaml"
kubectl apply -R -f "$WORK/apps"
rm -rf "$WORK"
kubectl -n starfleet rollout status deployment/scout --timeout=180s
kubectl -n starfleet rollout status deployment/probe --timeout=180s
kubectl -n starfleet rollout status deployment/shuttle --timeout=180s
echo "[lab] Ready. The Git repository is $HOME/gitops-lab/lab-030"
