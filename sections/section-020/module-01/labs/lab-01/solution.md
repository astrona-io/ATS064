# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-020/module-01/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Read the live object

```sh
cd ~/gitops-lab/lab-020
kubectl -n starfleet get deployment scout -o yaml
```

The object has the label `app: scout` and one container named `podinfo`. `kubectl create deployment` names the container after the image. There is no `last-applied-configuration` annotation, because no manifest was ever applied.

## Step 2: Write the declaration

Save this as `apps/deployment-scout.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: scout
  namespace: starfleet
  labels:
    app: scout
spec:
  replicas: 2
  selector:
    matchLabels:
      app: scout
  template:
    metadata:
      labels:
        app: scout
    spec:
      containers:
        - name: podinfo
          image: ghcr.io/stefanprodan/podinfo:6.15.0
          ports:
            - containerPort: 9898
          resources:
            requests:
              cpu: 10m
              memory: 32Mi
            limits:
              memory: 128Mi
```

The container name `podinfo` matters. Kubernetes merges the list of containers by name, so a different name would add a second container instead of changing the first.

## Step 3: Commit and apply

```sh
git add apps/deployment-scout.yaml
git commit -m "Declare the scout Deployment"
kubectl apply -f apps/deployment-scout.yaml
kubectl diff -f apps/deployment-scout.yaml
echo $?
```

The diff prints nothing and the exit status is 0. Apply a second time and the tool reports that nothing changed.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-020/module-01/labs/lab-01 --keep
```

All checks pass.
