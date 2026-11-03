#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/cap-070"
cd "$REPO"
mkdir -p .git/hooks
cat > .git/hooks/commit-msg <<'EOF'
#!/usr/bin/env bash
# Reject a commit whose message has no Reviewed-by trailer.
if git interpret-trailers --parse "$1" | grep -q '^Reviewed-by: .'; then
  exit 0
fi
echo "commit rejected: add a Reviewed-by trailer" >&2
exit 1
EOF
chmod +x .git/hooks/commit-msg
bad="$(git log -S EXPERIMENTAL_MODE --format=%H --reverse | head -1)"
git tag -a release-1 "$bad^" -m "Last revision before EXPERIMENTAL_MODE"
git log seed --format=%an | sort -u > audit.txt
git add audit.txt
git commit -q -m "Record the authors" -m "Reviewed-by: Ada Voss"
WORK="$(mktemp -d)"
git archive release-1 apps | tar -x -C "$WORK"
kubectl apply -R -f "$WORK/apps"
rm -rf "$WORK"
kubectl -n starfleet rollout status deployment/shuttle --timeout=180s
