# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running so you can continue after a failed check. This lab was built without running it, so the text describes what you should see instead of printing output.

Start the lab if it is not running:

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-010/module-01/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`. It stays your guard.

## Step 1: Look at the difference

Open the repository and compare it with the cluster:

```sh
cd ~/gitops-lab/lab-010
git log --oneline
kubectl diff -R -f apps
```

The diff shows `scout` going from two to three replicas. The cluster runs the first commit and the repository holds a second one.

## Step 2: Write the loop

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

The `cd "$(dirname "$0")"` line makes the relative path `apps` work from any directory. `RECONCILE_ONCE` ends the loop after one pass.

## Step 3: Commit it and run one pass

```sh
chmod +x reconcile.sh
git add reconcile.sh
git commit -m "Add the reconciliation loop"
RECONCILE_ONCE=1 ./reconcile.sh
kubectl -n starfleet rollout status deployment/scout
```

Grade it:

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-010/module-01/labs/lab-01 --keep
```

All checks pass. The check `script-repairs-drift` changes `probe` by hand and proves that one pass of your script restores it.
