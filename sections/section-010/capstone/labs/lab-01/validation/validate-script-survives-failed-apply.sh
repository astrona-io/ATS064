#!/usr/bin/env bash
# Check: A failed apply is reported with the word FAILED and does not stop other manifests from being applied
set -uo pipefail

REPO="$HOME/gitops-lab/cap-010"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -f reconcile.sh ] || { echo "FAIL: reconcile.sh is missing"; exit 1; }
cat > apps/zz-invalid.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: zz-invalid
  namespace: starfleet
spec:
  replica: 1
EOF
kubectl -n starfleet scale deployment probe --replicas=3 >/dev/null
out="$( cd /tmp && RECONCILE_ONCE=1 timeout 120 bash "$REPO/reconcile.sh" 2>&1 )"
rm -f apps/zz-invalid.yaml
want="$(grep -E '^  replicas:' apps/deployment-probe.yaml | awk '{print $2}')"
have="$(kubectl -n starfleet get deployment probe -o jsonpath='{.spec.replicas}')"
echo "$out" | grep -q 'FAILED' || { echo "FAIL: the script did not print FAILED for an invalid manifest"; exit 1; }
[ "$have" = "$want" ] || { echo "FAIL: the valid manifests were not applied (probe has $have, Git declares $want)"; exit 1; }
echo "PASS: the script reported the failure and still applied the valid manifests"
