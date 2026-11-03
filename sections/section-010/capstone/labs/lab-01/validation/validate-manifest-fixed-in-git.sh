#!/usr/bin/env bash
# Check: The invalid shuttle manifest is fixed in a new commit and passes server-side validation
set -uo pipefail

REPO="$HOME/gitops-lab/cap-010"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

if ! kubectl apply --dry-run=server -R -f apps >/dev/null 2>&1; then echo "FAIL: kubectl apply --dry-run=server rejects a manifest under apps"; exit 1; fi
if [ -n "$(git status --porcelain)" ]; then echo "FAIL: uncommitted changes in the repository"; exit 1; fi
git merge-base --is-ancestor seed HEAD || { echo "FAIL: the history was rewritten; the seed commit is not an ancestor of HEAD"; exit 1; }
[ "$(git rev-list --count seed..HEAD)" -ge 1 ] || { echo "FAIL: no new commit after the starting commit"; exit 1; }
echo "PASS: the manifests are valid and committed on top of the existing history"
