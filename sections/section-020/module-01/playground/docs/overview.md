# Overview: Declarative Descriptions (Playground)

This is a **playground**, not a lab. It starts a fresh cluster and a Git repository, and then waits. There is no task, no `astrona submit` and no pass or fail.

## What's in the box

- A single-node `kind` cluster running Kubernetes 1.35 with `kubectl` pointed at it as the cluster administrator. You need `git` and `jq` on your machine.
- A Git repository in `~/gitops-lab/play-020`. The `apps` directory holds declarative manifests for `scout`, `probe`, `shuttle` and a Service for `scout`, all applied. The `scripts` directory holds `deploy-demo.sh`, an imperative procedure. It is not applied.

## Practice tasks

- Run `kubectl apply -R -f apps` twice and compare what the two runs report.
- Run `bash scripts/deploy-demo.sh` twice and read the error of the second run.
- Remove the `namespace` line from a copy of `apps/deployment-scout.yaml` and run `kubectl apply --dry-run=server -f` on it. Find out in which namespace the object would be created.
- Run `kubectl apply --dry-run=server -o yaml -f apps/deployment-probe.yaml` and list every field that the API server added.
- Write a Deployment that refers to a ConfigMap that does not exist. Apply it, find the pod status and the message that names the ConfigMap, and then declare the ConfigMap.
