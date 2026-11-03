#!/usr/bin/env bash
# Check: Every new commit has a Reviewed-by trailer and the history was not rewritten
set -uo pipefail

REPO="$HOME/gitops-lab/cap-070"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

git merge-base --is-ancestor seed HEAD || { echo "FAIL: history was rewritten"; exit 1; }
[ "$(git rev-list --count seed..HEAD)" -ge 1 ] || { echo "FAIL: no new commit"; exit 1; }
for c in $(git rev-list seed..HEAD); do
  git log -1 --format=%B "$c" | git interpret-trailers --parse | grep -q '^Reviewed-by: .' || { echo "FAIL: commit $(git rev-parse --short "$c") has no Reviewed-by trailer"; fail=1; }
done
[ "$fail" -eq 0 ] && echo "PASS: all new commits carry the trailer"
exit "$fail"
