#!/usr/bin/env bash
# Check: An annotated tag release-1 names the parent of the EXPERIMENTAL_MODE commit and the cluster matches it
set -uo pipefail

REPO="$HOME/gitops-lab/cap-070"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

bad="$(git log seed --format=%H -S EXPERIMENTAL_MODE --reverse | head -1)"
git rev-parse -q --verify refs/tags/release-1 >/dev/null || { echo "FAIL: no tag release-1"; exit 1; }
[ "$(git cat-file -t release-1)" = "tag" ] || { echo "FAIL: release-1 is not annotated"; fail=1; }
[ "$(git rev-parse 'release-1^{commit}')" = "$(git rev-parse "$bad^")" ] || { echo "FAIL: release-1 is not on the parent of the bad commit"; fail=1; }
WORK="$(mktemp -d)"
git archive release-1 apps | tar -x -C "$WORK"
kubectl diff -R -f "$WORK/apps" >/dev/null 2>&1
rc=$?
rm -rf "$WORK"
[ "$rc" -eq 0 ] || { echo "FAIL: the cluster differs from release-1 (kubectl diff exit $rc)"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: release-1 is right and the cluster matches it"
exit "$fail"
