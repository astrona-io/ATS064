# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-080/module-01/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Read the feedback

```sh
cd ~/gitops-lab/lab-080
kubectl -n starfleet get deployment shuttle -o json | jq -r '.status.conditions[] | "\(.type) \(.status) \(.reason)"'
kubectl -n starfleet describe pod -l app=shuttle
```

The `Progressing` condition is `False` with the reason `ProgressDeadlineExceeded`. The events show that the readiness probe fails on the path `/nothere`.

```sh
kubectl -n starfleet get deployment shuttle -o json | jq -r '.status.conditions[] | select(.type=="Progressing") | .reason' > feedback.txt
```

## Step 2: Fix the manifest

In `apps/deployment-shuttle.yaml`, change the readiness probe path from `/nothere` to `/readyz`.

```sh
sed -i.bak 's#/nothere#/readyz#' apps/deployment-shuttle.yaml && rm apps/deployment-shuttle.yaml.bak
git add -A
git commit -m "Fix the readiness path of shuttle"
```

## Step 3: Apply and wait

```sh
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/shuttle --timeout=180s
```

The rollout completes, and `Progressing` returns to `True`.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-080/module-01/labs/lab-01 --keep
```

All checks pass.
