#!/usr/bin/env bash
# Check: feedback.txt names the Progressing reason that the failing Deployment reported, and is committed
set -uo pipefail

REPO="$HOME/gitops-lab/lab-080"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

[ -f feedback.txt ] || { echo "FAIL: feedback.txt is missing"; exit 1; }
git ls-files --error-unmatch feedback.txt >/dev/null 2>&1 || { echo "FAIL: feedback.txt is not committed"; exit 1; }
grep -q 'ProgressDeadlineExceeded' feedback.txt || { echo "FAIL: feedback.txt does not contain the reason ProgressDeadlineExceeded"; exit 1; }
echo "PASS: the failure reason is recorded"
