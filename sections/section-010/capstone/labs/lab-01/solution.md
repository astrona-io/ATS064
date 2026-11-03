# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-010/capstone/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Find the mistake

```sh
cd ~/gitops-lab/cap-010
git log --oneline
kubectl apply --dry-run=server -R -f apps
```

The dry run asks the API server to validate every file without changing anything. It rejects `apps/deployment-shuttle.yaml` because the field `spec.replica` does not exist. The correct field name is `replicas`.

## Step 2: Fix it in a new commit

Edit the file so that the line reads `replicas: 2`, then commit:

```sh
git add apps/deployment-shuttle.yaml
git commit -m "Fix the replicas field of shuttle"
kubectl apply --dry-run=server -R -f apps
```

The dry run now succeeds. The old commit stays in the history, which is why you add a new commit.

## Step 3: Write the agent

Save this as `reconcile.sh`:

```sh
#!/usr/bin/env bash
INTERVAL="${INTERVAL:-15}"
cd "$(dirname "$0")"

while true; do
  echo "revision $(git rev-parse --short HEAD)"
  if ! kubectl apply -R -f apps; then
    echo "FAILED: apply returned an error, retrying in ${INTERVAL}s"
  fi
  if [ -n "${RECONCILE_ONCE:-}" ]; then
    exit 0
  fi
  sleep "$INTERVAL"
done
```

The script does not use `set -e`, so a failed `apply` does not end it. `kubectl apply` still applies the valid files when one file fails.

## Step 4: Commit and run one pass

```sh
chmod +x reconcile.sh
git add reconcile.sh
git commit -m "Add the reconciliation loop"
RECONCILE_ONCE=1 ./reconcile.sh
```

Wait for the rollouts, then grade:

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-010/capstone/labs/lab-01 --keep
```

All checks pass.
