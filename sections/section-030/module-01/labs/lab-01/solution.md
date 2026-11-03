# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-030/module-01/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Find the generated fields

```sh
cd ~/gitops-lab/lab-030
git show HEAD
cat apps/service-scout.yaml
```

The file holds these fields that the system wrote: `metadata.creationTimestamp`, `metadata.resourceVersion`, `metadata.uid`, `spec.clusterIP`, `spec.clusterIPs` and the `status` block. People decided the name, the namespace, the label, the selector, the port and the type.

## Step 2: Keep only the declared fields

Replace the content of `apps/service-scout.yaml` with:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: scout
  namespace: starfleet
  labels:
    app: scout
spec:
  selector:
    app: scout
  ports:
    - port: 9898
      protocol: TCP
      targetPort: 9898
  type: ClusterIP
```

## Step 3: Check, commit and grade

```sh
kubectl apply --dry-run=server -f apps/service-scout.yaml
kubectl diff -f apps/service-scout.yaml
echo $?
git add apps/service-scout.yaml
git commit -m "Keep only the declared fields of the scout Service"
```

The dry run is accepted, and the diff prints nothing and the exit status is 0, because the cluster already holds this Service.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-030/module-01/labs/lab-01 --keep
```

All checks pass.
