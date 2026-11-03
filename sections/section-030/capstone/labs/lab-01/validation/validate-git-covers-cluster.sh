#!/usr/bin/env bash
# Check: Every Deployment, Service and ConfigMap in starfleet, except system-made ones, is produced by apps
set -uo pipefail

REPO="$HOME/gitops-lab/cap-030"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

live="$(kubectl -n starfleet get deployments,services,configmaps -o name | grep -v 'configmap/kube-root-ca.crt' | sort)"
desired="$(kubectl apply --dry-run=client -R -f apps -o name 2>/dev/null | grep -E '^(deployment|service|configmap)' | sort)"
missing="$(comm -23 <(echo "$live") <(echo "$desired"))"
[ -z "$missing" ] || { echo "FAIL: in the cluster but not in Git:"; echo "$missing"; exit 1; }
echo "PASS: Git describes every live object"
