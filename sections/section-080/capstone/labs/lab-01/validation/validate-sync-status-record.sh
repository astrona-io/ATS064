#!/usr/bin/env bash
# Check: The ConfigMap sync-status in starfleet has revision equal to the HEAD SHA, result Synced and failed-before drifter,shuttle
set -uo pipefail

REPO="$HOME/gitops-lab/cap-080"
fail=0
cd "$REPO" 2>/dev/null || { echo "FAIL: the repository $REPO does not exist"; exit 1; }

cm="$(kubectl -n starfleet get configmap sync-status -o json 2>/dev/null)" || { echo "FAIL: no ConfigMap sync-status in starfleet"; exit 1; }
rev="$(echo "$cm" | jq -r '.data.revision // ""')"
res="$(echo "$cm" | jq -r '.data.result // ""')"
fb="$(echo "$cm" | jq -r '.data["failed-before"] // ""')"
[ "$rev" = "$(git rev-parse HEAD)" ] || { echo "FAIL: revision '$rev' is not the HEAD SHA"; fail=1; }
[ "$res" = "Synced" ] || { echo "FAIL: result is '$res', expected Synced"; fail=1; }
[ "$fb" = "drifter,shuttle" ] || { echo "FAIL: failed-before is '$fb', expected drifter,shuttle"; fail=1; }
[ "$fail" -eq 0 ] && echo "PASS: the status record is correct and current"
exit "$fail"
