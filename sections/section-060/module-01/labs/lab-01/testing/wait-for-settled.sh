#!/usr/bin/env bash
# Runs under `astrona test` after the reference solution: waits until the
# Deployments in starfleet have finished rolling out.
set -euo pipefail

for name in $(kubectl -n starfleet get deployments -o jsonpath='{.items[*].metadata.name}'); do
  kubectl -n starfleet rollout status "deployment/$name" --timeout=120s || true
done
sleep 3
echo "[testing] settled."
