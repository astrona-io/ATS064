# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-090/capstone/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Identify the commits

```sh
cd ~/gitops-lab/cap-090
git log --stat --format='%h %an %s'
```

The first commit adds the workloads. The second changes only `apps/deployment-probe.yaml` and the fourth changes only `apps/deployment-shuttle.yaml`. The third scales `scout` and stays.

## Step 2: Revert the two bad commits

Revert the newest first:

```sh
git revert --no-edit HEAD
git revert --no-edit <sha of the second commit>
git diff <sha of the first commit> HEAD -- apps
```

The last diff shows only the replica count of `scout`, which is the good change that was kept.

## Step 3: Apply and confirm

```sh
kubectl diff -R -f apps
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/probe --timeout=180s
kubectl -n starfleet rollout status deployment/shuttle --timeout=180s
kubectl -n starfleet get configmap visitor-log -o jsonpath='{.data.count}'
```

Both rollouts complete, `scout` still has 3 replicas, and the counter is still `42`.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-090/capstone/labs/lab-01 --keep
```

All checks pass.
