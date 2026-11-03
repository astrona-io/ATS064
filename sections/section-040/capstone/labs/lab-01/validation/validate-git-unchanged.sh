#!/usr/bin/env bash
# Check: Git was not edited: HEAD is the seed commit and the working tree is clean
set -uo pipefail

REPO="$HOME/gitops-lab/cap-040"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ "$(git rev-parse HEAD)" = "$(git rev-parse seed)" ] || { echo "FAIL: HEAD is not the seed commit"; exit 1; }
[ -z "$(git status --porcelain)" ] || { echo "FAIL: the working tree has changes"; exit 1; }
echo "PASS: Git is untouched"
