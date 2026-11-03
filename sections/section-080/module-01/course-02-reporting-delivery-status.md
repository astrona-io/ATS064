---
draft: true
exam_objectives:
  - Feedback Loop
---
# Reporting Delivery Status

The status exists inside the cluster. This part shows how to read it reliably, how to tie it to a revision of the repository, and how to publish it as a small record that people and tools can use.

## Read a failure from the status

Start with a Deployment that cannot finish. In the playground, apply a Deployment whose readiness probe path does not exist, with a short deadline. Save this as `apps/deployment-orbit.yaml`, built from the same shape as the other workloads:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: orbit
  namespace: starfleet
spec:
  replicas: 1
  progressDeadlineSeconds: 30
  selector:
    matchLabels:
      app: orbit
  template:
    metadata:
      labels:
        app: orbit
    spec:
      containers:
        - name: orbit
          image: ghcr.io/stefanprodan/podinfo:6.15.0
          ports:
            - containerPort: 9898
          readinessProbe:
            httpGet:
              path: /nothere
              port: 9898
            periodSeconds: 3
```

<!-- astrona:playground:renew -->

```sh
cd ~/gitops-lab/play-080
kubectl apply -f apps/deployment-orbit.yaml
kubectl -n starfleet wait deployment/orbit --for=condition=Progressing=false --timeout=120s
kubectl -n starfleet get deployment orbit -o json | jq -r '.status.conditions[] | "\(.type) \(.status) \(.reason)"'
kubectl -n starfleet get pods -l app=orbit
```

The pod starts and stays not ready, because its probe path returns an error. After about 30 seconds the `Progressing` condition turns `False` with the reason `ProgressDeadlineExceeded`. The `Available` condition shows that no replica is available. The pod itself is running, which shows why the pod phase alone is not a health signal.

The events add detail. They are short records that controllers write, and they expire after about an hour by default.

```sh
kubectl -n starfleet describe pod -l app=orbit
```

The events at the end of the output include the failed readiness probe and its HTTP status. Together, the condition names the problem class and the events name the cause.

## Fix it where the cause lives

The cause is in the manifest, so the fix is a commit. Changing the live object with `kubectl edit` would make the cluster work while the repository stays wrong, and the next sync would undo the fix. Correct the path in the file, commit and apply:

```sh
sed -i.bak 's#/nothere#/readyz#' apps/deployment-orbit.yaml && rm apps/deployment-orbit.yaml.bak
git add apps/deployment-orbit.yaml
git commit -m "Add orbit with a working readiness path"
kubectl apply -f apps/deployment-orbit.yaml
kubectl -n starfleet rollout status deployment/orbit --timeout=120s
```

After the fix, a new pod becomes ready, `Available` turns `True`, and `Progressing` returns to `True` with the reason `NewReplicaSetAvailable`. The old condition is replaced, so status always describes the present state.

## Tie the status to a revision

A status without a revision is hard to use. "Healthy" says little unless it says healthy at which commit. A report should carry at least three fields: the revision of the repository that was applied, the sync result, and the time. The revision is the full SHA from `git rev-parse HEAD`.

A simple record is a ConfigMap that the agent writes after each reconciliation:

```sh
kubectl -n starfleet create configmap sync-status \
  --from-literal=revision="$(git rev-parse HEAD)" \
  --from-literal=result=Synced \
  --dry-run=client -o yaml | kubectl apply -f -
```

The pipe to `kubectl apply` makes the command repeatable, because `kubectl create` alone fails when the object already exists. Values in a ConfigMap are strings, so a number or a boolean must be quoted if you write the manifest by hand. Real agents publish richer status on their own objects, but the content is the same: a revision, a result and a reason.

## Compare the report to the repository

A report is only useful if it is current. Compare the recorded revision to the repository:

```sh
test "$(kubectl -n starfleet get configmap sync-status -o jsonpath='{.data.revision}')" = "$(git rev-parse HEAD)" && echo current
```

If the two differ, the cluster has not caught up with the newest commit, or the reporter stopped. Both are worth an alert. A report that is current but says `Failed` means the repository is ahead of a cluster that could not take the change.

## Where the report goes

People do not watch a cluster. A report becomes useful when it reaches the place where the team already looks: a chat channel, a dashboard, a pull request check or a ticket. Send failures, and state changes such as the first success after a failure. Do not send every successful reconciliation, because a channel that posts every minute is ignored. Include the revision and the reason, so the reader can act without opening a terminal.

Delay is part of the loop. The time from a commit to a visible result is the sum of the polling interval of the agent, the rollout time and the progress deadline. A team should know that number, because it is the time that a bad change can run before anyone is told.

## Common pitfalls

> [!WARNING]
> Do not fix a failed delivery with `kubectl edit` and leave the repository unchanged. Do not report a result without the revision it belongs to. Do not send a message for every reconciliation, because people stop reading. When you write a ConfigMap by hand, quote values that look like numbers or booleans, since an unquoted integer is rejected.
