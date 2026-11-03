#!/usr/bin/env bash
# Check: An annotated tag release-1 names the parent of the commit that added EXPERIMENTAL_MODE
set -uo pipefail

REPO="$HOME/gitops-lab/lab-070"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

bad="$(git log seed --format=%H -S EXPERIMENTAL_MODE --reverse | head -1)"
[ -n "$bad" ] || { echo "FAIL: the search found no commit (history changed?)"; exit 1; }
git rev-parse -q --verify refs/tags/release-1 >/dev/null || { echo "FAIL: no tag release-1"; exit 1; }
[ "$(git cat-file -t release-1)" = "tag" ] || { echo "FAIL: release-1 is not an annotated tag"; exit 1; }
[ "$(git rev-parse 'release-1^{commit}')" = "$(git rev-parse "$bad^")" ] || { echo "FAIL: release-1 does not name the parent of the bad commit"; exit 1; }
echo "PASS: release-1 is an annotated tag on the last good revision"
