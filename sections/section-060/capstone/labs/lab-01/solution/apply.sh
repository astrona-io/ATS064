#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/cap-060"
cd "$REPO"
sed -i.bak '/^  name: starfleet$/a\
  labels:\
    pod-security.kubernetes.io/enforce: baseline' apps/namespaces.yaml && rm apps/namespaces.yaml.bak
sed -i.bak '/privileged: true/d; /securityContext:/d' apps/deployment-probe.yaml && rm apps/deployment-probe.yaml.bak
mkdir -p platform
cat > platform/namespace-gitops-system.yaml <<'EOF'
apiVersion: v1
kind: Namespace
metadata:
  name: gitops-system
EOF
cat > platform/serviceaccount-gitops-agent.yaml <<'EOF'
apiVersion: v1
kind: ServiceAccount
metadata:
  name: gitops-agent
  namespace: gitops-system
EOF
cat > platform/role-gitops-agent.yaml <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: gitops-agent
  namespace: starfleet
rules:
  - apiGroups: ["apps"]
    resources: ["deployments"]
    verbs: ["get", "list", "watch", "create", "update", "patch"]
  - apiGroups: [""]
    resources: ["services", "configmaps"]
    verbs: ["get", "list", "watch", "create", "update", "patch"]
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list", "watch"]
EOF
cat > platform/rolebinding-gitops-agent.yaml <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: gitops-agent
  namespace: starfleet
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: gitops-agent
subjects:
  - kind: ServiceAccount
    name: gitops-agent
    namespace: gitops-system
EOF
git add -A
git commit -q -m "Bootstrap the agent, enforce baseline and drop the privileged probe"
kubectl apply -f platform/namespace-gitops-system.yaml
kubectl apply -R -f platform
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/probe --timeout=180s
