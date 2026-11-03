# Overview: The Feedback Loop (Playground)

This is a **playground**, not a lab. It starts a fresh cluster and a Git repository, and then waits. There is no task, no `astrona submit` and no pass or fail.

## What's in the box

- A single-node `kind` cluster running Kubernetes 1.35 with `kubectl` pointed at it as the cluster administrator. You need `git` and `jq` on your machine.
- A Git repository in `~/gitops-lab/play-080` with one commit. The `apps` directory holds the manifests for `scout`, `probe`, `shuttle` and a Service for `scout`, all applied and healthy.

## Practice tasks

- Print the conditions of `scout` with `jq`, and compare `metadata.generation` to `status.observedGeneration`.
- Add a Deployment with a wrong readiness path and `progressDeadlineSeconds: 30`. Watch the `Progressing` condition change reason.
- Read the pod events with `kubectl describe pod` and name the cause.
- Fix the path in Git, apply and wait with `kubectl rollout status`.
- Write a `sync-status` ConfigMap with the HEAD SHA and compare it to `git rev-parse HEAD`.
