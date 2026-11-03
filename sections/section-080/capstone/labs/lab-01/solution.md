# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-080/capstone/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Diagnose both Deployments

```sh
cd ~/gitops-lab/cap-080
kubectl -n starfleet get deployments
kubectl -n starfleet get pods
kubectl -n starfleet describe pod -l app=shuttle
kubectl -n starfleet describe pod -l app=drifter
```

Both Deployments report `Progressing` as `False` with the reason `ProgressDeadlineExceeded`, which only tells you that they are stuck. The pod of `shuttle` cannot pull its image, because the tag `6.99.0` does not exist, and the events show the pull error. The pod of `drifter` runs but never becomes ready, and the events show the failed readiness probe on `/nothere`.

## Step 2: Fix and commit

Set the image of `shuttle` to `ghcr.io/stefanprodan/podinfo:6.15.0` in `apps/deployment-shuttle.yaml`, and the readiness path of `drifter` to `/readyz` in `apps/deployment-drifter.yaml`.

```sh
git add -A
git commit -m "Fix the image of shuttle and the readiness path of drifter"
```

## Step 3: Apply and wait

```sh
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/shuttle --timeout=180s
kubectl -n starfleet rollout status deployment/drifter --timeout=180s
```

## Step 4: Report the result

The report must name the final commit, so create it last:

```sh
kubectl -n starfleet create configmap sync-status \
  --from-literal=revision="$(git rev-parse HEAD)" \
  --from-literal=result=Synced \
  --from-literal=failed-before=drifter,shuttle
```

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-080/capstone/labs/lab-01 --keep
```

All checks pass.
