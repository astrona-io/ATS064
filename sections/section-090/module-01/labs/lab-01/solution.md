# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-090/module-01/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Read the history

```sh
cd ~/gitops-lab/lab-090
git log --stat --format='%h %an %s'
```

The newest commit changes only `apps/deployment-probe.yaml`.

## Step 2: Revert

```sh
git revert --no-edit HEAD
git diff HEAD~2 HEAD -- apps
```

The revert adds a commit with a message that starts with `Revert` and contains `This reverts commit`. The diff compares the state before the bad commit with the state now and is expected to print nothing.

## Step 3: Apply and confirm

```sh
kubectl diff -R -f apps
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/probe --timeout=180s
kubectl -n starfleet get configmap visitor-log -o jsonpath='{.data.count}'
```

The diff lists only the image of `probe`. The rollout completes, and the counter is still `42`.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-090/module-01/labs/lab-01 --keep
```

All checks pass.
