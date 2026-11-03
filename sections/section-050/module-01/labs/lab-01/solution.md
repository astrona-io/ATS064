# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-050/module-01/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`, because the old `scout` pods keep running.

## Step 1: Find the cause

```sh
cd ~/gitops-lab/lab-050
kubectl -n starfleet get pods -l app=scout
kubectl -n starfleet describe pod -l app=scout
kubectl -n starfleet get events --sort-by=.lastTimestamp
git show HEAD
```

One new pod waits with the reason `ErrImagePull` or `ImagePullBackOff`, and the old pods are still running. The description and the events name the image `ghcr.io/stefanprodan/podinfo:6.15.O`. The commit changed the tag from `6.15.0` to `6.15.O`, with a letter O.

## Step 2: Write the report and fix the tag

Save `report.txt` with the object, the reason and the tag, for example: `scout is stuck in a rollout. The new pod has the status ImagePullBackOff because the image tag 6.15.O does not exist.` Then change the image line in `apps/deployment-scout.yaml` to `ghcr.io/stefanprodan/podinfo:6.15.0`.

```sh
git add report.txt apps/deployment-scout.yaml
git commit -m "Fix the scout image tag and report the failed rollout"
```

## Step 3: Apply and wait for convergence

```sh
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/scout --timeout=120s
kubectl diff -R -f apps
echo $?
```

The rollout completes and the exit status of the diff is 0.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-050/module-01/labs/lab-01 --keep
```

All checks pass.
