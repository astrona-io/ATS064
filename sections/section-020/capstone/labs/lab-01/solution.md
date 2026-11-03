# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-020/capstone/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Find what the file leaves out

```sh
cd ~/gitops-lab/cap-020
git show HEAD
```

The new file has no `metadata.namespace`, so `kubectl` would use the namespace of the current context, which is `default`. The image has no tag, so it resolves to `latest`. The file reads the ConfigMap `shuttle-settings`, and nothing in the repository declares it.

## Step 2: Complete the description

Edit `apps/deployment-shuttle.yaml`: add `namespace: starfleet` under `metadata` and use the image `ghcr.io/stefanprodan/podinfo:6.15.0`. Keep the `envFrom` block. Then save this as `apps/configmap-shuttle-settings.yaml`:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: shuttle-settings
  namespace: starfleet
data:
  MODE: standard
```

Commit both files:

```sh
git add apps
git commit -m "Declare the scope, the image tag and the ConfigMap of shuttle"
```

## Step 3: Apply and check

Apply the whole directory and wait for the rollout. If you applied the first version by mistake, remove the Deployment it created in `default`:

```sh
kubectl -n default delete deployment shuttle --ignore-not-found
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/shuttle
kubectl -n default get deployment
```

The last command shows no `shuttle`. Grade it:

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-020/capstone/labs/lab-01 --keep
```

All checks pass.
