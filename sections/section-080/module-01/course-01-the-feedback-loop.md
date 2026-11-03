---
draft: true
exam_objectives:
  - Feedback Loop
---
# The Feedback Loop

A commit that merged is not a delivery that worked. The agent applied some objects, and the cluster accepted them, but whether the application now runs is a separate fact. The **feedback loop** is the path that carries that fact back: from the cluster to the agent, and from the agent to the people and tools that need to know. Without it, a team learns about a failed delivery from its users.

## Two kinds of success

A delivery can succeed at two levels, and they are easy to confuse.

- **Applied.** The API server accepted the objects. The command returned without an error.
- **Healthy.** The workload that the objects describe is running and serving. Pods exist, are ready and have been updated to the new template.

A manifest with a wrong image tag is applied without any error. The API server does not pull images. The failure appears later, in the pods. This is why a GitOps agent reports both: the **sync status**, which says whether the cluster matches the repository, and the **health status**, which says whether the workloads work.

## Where Kubernetes records progress

Controllers write the result of their work into the `status` field of an object. The `status` is separate from the `spec`, which holds the desired state. A person or an agent writes the spec. The controller writes the status. For a Deployment the status holds these facts.

- `replicas`, `updatedReplicas`, `readyReplicas` and `availableReplicas`: how many pods exist, how many run the newest template, how many pass their readiness check and how many have been ready long enough to count as available.
- `observedGeneration`: the generation of the spec that the controller has processed. The `metadata.generation` field increases each time the spec changes. When the two numbers are equal, the status describes the current spec. When `observedGeneration` is lower, the status is old and must not be trusted.
- `conditions`: a list of named facts, each with a `type`, a `status` of `True`, `False` or `Unknown`, a `reason` and a `message`.

Read the conditions of a healthy Deployment in the playground:

<!-- astrona:playground:renew -->

```sh
kubectl -n starfleet get deployment scout -o json | jq '.metadata.generation, .status.observedGeneration'
kubectl -n starfleet get deployment scout -o json | jq -r '.status.conditions[] | "\(.type) \(.status) \(.reason)"'
```

The first command prints the generation of the spec and the generation that the controller has seen. The second prints one line for each condition. A Deployment has two main ones. `Available` is `True` when enough pods are available. `Progressing` is `True` while a rollout moves forward and after it completes.

## The progress deadline

A rollout that cannot finish would otherwise stay in progress forever. The field `spec.progressDeadlineSeconds` sets a time limit. If the Deployment makes no progress within that number of seconds, the controller sets the `Progressing` condition to `False` with the reason `ProgressDeadlineExceeded`. Progress means a new pod was created, a pod became ready, or a pod was removed. The default is 600 seconds. The controller does not stop the rollout and does not roll back. It only records the fact, so that a person or an agent can see it.

This is the central piece of feedback for a delivery. A stuck rollout turns into a condition that tools can read. A short deadline gives fast feedback and a long deadline tolerates a slow start. Choose a deadline that is a little longer than your normal rollout time.

## Waiting for the result

`kubectl rollout status deployment/<name>` blocks until the rollout completes, and exits with a non-zero status if the progress deadline is exceeded. `kubectl wait` blocks until a condition has a given value:

```sh
kubectl -n starfleet wait deployment/scout --for=condition=Available --timeout=60s
```

Both commands turn the status into an exit code, which is what a script or a pipeline step needs to decide whether to continue. Give them a timeout, because without one they wait for as long as the condition is unmet.

## Pod phase is not health

A pod has a **phase**, such as `Pending`, `Running` or `Succeeded`. `Running` means that the pod was assigned to a node and at least one container has started. It does not mean that the application works. A pod can be `Running` and not ready for hours. The readiness of the pod is a separate condition, and it is the one that Services and Deployments use. When you read health, read readiness and the Deployment conditions, and use the phase only to see whether a pod exists and has started.

```sh
kubectl -n starfleet get pods -o custom-columns=NAME:.metadata.name,PHASE:.status.phase,READY:.status.containerStatuses[0].ready
```

The columns show the phase next to the readiness of the first container, which makes a running pod that is not ready easy to spot.

## What a rolling update does to the evidence

The default update strategy of a Deployment is a rolling update. It creates pods from the new template and removes old pods only as new ones become available. The limits are `maxSurge`, how many extra pods may exist, and `maxUnavailable`, how many may be missing. When the new pods never become ready, the old pods stay in place, and the application keeps serving the old version. This is a safety property, and it also hides the failure: users see no outage, and the only sign is in the status. This is why the progress deadline matters. The cluster protects the users and tells you only through the condition.

## Speed of feedback

Feedback has a delay. The time between a commit and a visible result is made of the agent's interval, the rollout time and the progress deadline. A team that waits ten minutes for a failure signal will have shipped the next change by then. Shorter intervals and deadlines give faster signals and more false alarms for slow applications, so tune them with the real startup time of the application as the lower bound.

## Conditions and events together

Conditions and events answer different questions. A condition is a current fact: it holds one value per type and is replaced when the state changes. An event is a record of something that happened at a time, such as a failed probe or a failed image pull, and events pile up and expire. Use the condition to learn the class of the problem, for example that a rollout is stuck. Use the events to learn the cause, for example which probe failed with which status. A report that only forwards the condition is short but leaves the reader to look for the cause. A report that forwards both lets them act at once.

## What the agent does with feedback

An agent has three jobs once it has the status. It reports it, so that people can see the sync and health result. It may gate further steps on it, for example by promoting a change to the next environment only after the first one is healthy. And it keeps trying: the next reconciliation compares again, so a transient failure heals without a person.

What the agent should not do is hide a failure by retrying silently. If the cause is in the repository, such as a wrong image tag, no number of retries will help. The feedback must reach the person who can change the repository, with enough detail to act on: which object, which revision and which reason.

## Readiness is the signal

Everything above depends on the readiness probe. A pod is ready when its readiness probe succeeds. A Deployment counts ready pods, and a rollout moves forward only as pods become ready. A workload without a readiness probe is counted as ready as soon as its container starts, and the feedback loop then reports success for an application that may not work. A probe that is too lenient hides failures. A probe that is too strict turns a healthy application into a failed delivery.

A short way to remember the order: apply, wait, read the condition, read the events, then decide. Each step uses the output of the one before it, and none of them needs more than a single command.

## Common pitfalls

> [!WARNING]
> Do not treat a successful `kubectl apply` as a successful delivery. Do not read a status without comparing `observedGeneration` to the generation. Do not leave a Deployment without a readiness probe, and do not leave the progress deadline at a value so long that nobody sees the failure. Report failures to the people who can fix the repository.
