# Overview: Reconciliation (Playground)

This is a **playground**, not a lab. It starts a fresh cluster and a Git repository, and then waits. There is no task, no `astrona submit` and no pass or fail.

## What's in the box

- A single-node `kind` cluster running Kubernetes 1.35 with `kubectl` pointed at it as the cluster administrator. You need `git` and `jq` on your machine.
- A Git repository in `~/gitops-lab/play-050` with one commit. The `apps` directory holds the manifests for `scout`, `probe`, `shuttle` and a Service for `scout`, all applied.

## Practice tasks

- Delete the pods of `scout` and watch them come back with `kubectl -n starfleet get pods -w`.
- Change the image of `scout` in a copy of the manifest to a tag that does not exist, apply it, and find `ErrImagePull` and `ImagePullBackOff`. Check that the old pods keep running.
- Run `kubectl -n starfleet rollout status deployment/scout --timeout=30s` while the rollout is stuck, and read the result.
- Create a ResourceQuota in `outpost` with `pods: "1"`, create a Deployment with two replicas there, and find the `FailedCreate` event.
- Create a ConfigMap manifest with a number as a value and apply it with `kubectl apply -f`. Read the error.
