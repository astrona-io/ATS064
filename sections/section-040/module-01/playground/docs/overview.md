# Overview: Configuration Drift (Playground)

This is a **playground**, not a lab. It starts a fresh cluster and a Git repository, and then waits. There is no task, no `astrona submit` and no pass or fail.

## What's in the box

- A single-node `kind` cluster running Kubernetes 1.35 with `kubectl` pointed at it as the cluster administrator. You need `git` and `jq` on your machine.
- A Git repository in `~/gitops-lab/play-040` with one commit. The `apps` directory holds the manifests for `scout`, `probe`, `shuttle` and a Service for `scout`, all applied, so the cluster matches Git.

## Practice tasks

- Run `kubectl diff -R -f apps; echo $?` and read the exit status. Then scale `scout` by hand and run it again.
- Add an environment variable with `kubectl -n starfleet set env deployment/probe EXTRA=1`, apply the repository and check whether the variable is still there.
- Read `kubectl -n starfleet get deployment scout --show-managed-fields -o yaml` and find which managers own `spec.replicas`.
- Apply `apps/deployment-scout.yaml` with `--server-side --field-manager=gitops-agent` after a manual scale, read the conflict, and apply again with `--force-conflicts`.
- Remove `replicas` from a copy of the `scout` manifest, apply it, scale by hand and see that nothing is put back.
