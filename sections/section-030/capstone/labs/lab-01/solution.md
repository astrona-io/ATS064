# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-030/capstone/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Find the gap

```sh
cd ~/gitops-lab/cap-030
kubectl -n starfleet get deployments,services,configmaps -o name
kubectl apply --dry-run=client -R -f apps -o name
```

The cluster list has `configmap/scout-settings` and `service/shuttle` that the repository list lacks. It also has `configmap/kube-root-ca.crt`, which the cluster creates in every namespace. Leave that one out.

## Step 2: Export and clean

Look at each object, and keep the fields that people decide:

```sh
kubectl -n starfleet get configmap scout-settings -o yaml
kubectl -n starfleet get service shuttle -o yaml
```

Save `apps/configmap-scout-settings.yaml` with the name, the namespace and the data `LOG_LEVEL: info` and `REGION: outpost-1`. Save `apps/service-shuttle.yaml` with the name, the namespace, the label and the selector `app: shuttle`, the port `9898` and target port `9898`. Do not copy `uid`, `resourceVersion`, `creationTimestamp`, `clusterIP`, `clusterIPs` or `status`.

## Step 3: Check, commit and grade

```sh
kubectl diff -R -f apps
echo $?
git add apps
git commit -m "Describe the ConfigMap and the Service that were made by hand"
kubectl apply -R -f apps
```

The diff prints nothing and the exit status is 0.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-030/capstone/labs/lab-01 --keep
```

All checks pass.
