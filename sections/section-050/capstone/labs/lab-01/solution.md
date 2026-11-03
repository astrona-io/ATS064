# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-050/capstone/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Find the three causes

```sh
cd ~/gitops-lab/cap-050
git show HEAD --stat
kubectl -n starfleet get pods
kubectl -n outpost get resourcequota
kubectl -n outpost get events
kubectl apply --dry-run=client -R -f apps
```

The first cause is a `shuttle` pod that waits with `ErrImagePull` or `ImagePullBackOff`, because the tag is `6.15.O` with a letter O. The second is the ResourceQuota `outpost-quota`, which allows 2 pods while `drifter` asks for 3, and the events of the ReplicaSet show that creating the pod failed because of the quota. The third is the file `apps/configmap-outpost-notes.yaml`, where `retries` is a number and a ConfigMap value must be a string. The dry run reports an error for that file.

## Step 2: Fix the three causes

Edit `apps/deployment-shuttle.yaml` so that the image is `ghcr.io/stefanprodan/podinfo:6.15.0`. Edit `apps/resourcequota-outpost.yaml` so that `pods` is `"4"`. Edit `apps/configmap-outpost-notes.yaml` so that the value is quoted: `retries: "3"`. Commit:

```sh
git add apps
git commit -m "Fix the shuttle tag, raise the outpost quota and quote the retries value"
```

## Step 3: Apply and wait for convergence

```sh
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/shuttle --timeout=120s
kubectl -n outpost rollout status deployment/drifter --timeout=180s
kubectl apply -R -f apps
```

The second apply reports every object as unchanged. The third replica of `drifter` appears once the ReplicaSet retries after the quota was raised, which can take a short time.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-050/capstone/labs/lab-01 --keep
```

All checks pass.
