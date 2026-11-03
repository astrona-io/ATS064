#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/lab-010"
cd "$REPO"
cat > reconcile.sh <<'EOF'
#!/usr/bin/env bash
INTERVAL="${INTERVAL:-15}"
cd "$(dirname "$0")"

while true; do
  echo "revision $(git rev-parse --short HEAD)"
  if ! kubectl apply -R -f apps; then
    echo "FAILED: apply returned an error, retrying in ${INTERVAL}s"
  fi
  if [ -n "${RECONCILE_ONCE:-}" ]; then
    exit 0
  fi
  sleep "$INTERVAL"
done
EOF
chmod +x reconcile.sh
git add reconcile.sh
git commit -q -m "Add the reconciliation loop"
RECONCILE_ONCE=1 ./reconcile.sh
kubectl -n starfleet rollout status deployment/scout --timeout=120s
