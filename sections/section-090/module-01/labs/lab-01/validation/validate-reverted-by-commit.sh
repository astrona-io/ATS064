#!/usr/bin/env bash
# Check: The bad commit was reversed by a new git revert commit on top of the seed, and the history is intact
set -uo pipefail

REPO="$HOME/gitops-lab/lab-090"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

git merge-base --is-ancestor seed HEAD || { echo "FAIL: history was rewritten, the seed commit is not in HEAD"; exit 1; }
[ "$(git rev-list --count seed..HEAD)" -ge 1 ] || { echo "FAIL: no new commit"; exit 1; }
git log seed..HEAD --format=%B | grep -q "This reverts commit $(git rev-parse seed)" || { echo "FAIL: no revert commit for the bad commit"; exit 1; }
echo "PASS: the bad commit was reverted by a new commit"
