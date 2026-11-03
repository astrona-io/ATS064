# Overview: Desired State (Playground)

This is a **playground**, not a lab. It starts a fresh cluster and a Git repository, and then waits. There is no task, no `astrona submit` and no pass or fail.

## What's in the box

- A single-node `kind` cluster running Kubernetes 1.35 with `kubectl` pointed at it as the cluster administrator. You need `git` and `jq` on your machine.
- A Git repository in `~/gitops-lab/play-030` with one commit. The `apps` directory holds the manifests for `scout`, `probe`, `shuttle` and a Service for `scout`, all applied.

## Practice tasks

- Export the `scout` Service with `kubectl -n starfleet get service scout -o yaml` and list every field that is not in `apps/service-scout.yaml`.
- Use `kubectl get service scout -n starfleet -o json | jq 'del(.metadata.uid, .metadata.resourceVersion, .metadata.creationTimestamp, .metadata.managedFields, .status, .spec.clusterIP, .spec.clusterIPs)'` and compare the result with the file in Git.
- Create a ConfigMap by hand with `kubectl create configmap`, then find it with `kubectl apply --dry-run=client -R -f apps -o name` and `kubectl get configmaps -o name` and see that it is missing from Git.
- Run `git log --format='%H %an %s'` and note that each commit has a fixed hash.
- Make a commit, create a branch and a tag on it, and then add another commit on the branch. See which name moved.
