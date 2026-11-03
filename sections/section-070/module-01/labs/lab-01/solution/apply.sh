#!/usr/bin/env bash
# Applies the reference solution. Run only by `astrona test`.
set -euo pipefail

REPO="$HOME/gitops-lab/lab-070"
cd "$REPO"
bad="$(git log -S EXPERIMENTAL_MODE --format=%H --reverse | head -1)"
git tag -a release-1 "$bad^" -m "Last revision before EXPERIMENTAL_MODE"
git rev-parse 'release-1^{commit}' > released.txt
git add released.txt
git commit -q -m "Record the release revision"
WORK="$(mktemp -d)"
git archive release-1 apps | tar -x -C "$WORK"
kubectl apply -R -f "$WORK/apps"
rm -rf "$WORK"
kubectl -n starfleet rollout status deployment/shuttle --timeout=180s
