# Overview: The Managed System And The Agent (Playground)

This is a **playground**, not a lab. It starts a fresh cluster and a Git repository, and then waits. There is no task, no `astrona submit` and no pass or fail.

## What's in the box

- A single-node `kind` cluster running Kubernetes 1.35 with `kubectl` pointed at it as the cluster administrator. You need `git` and `jq` on your machine.
- A Git repository in `~/gitops-lab/play-060` with one commit. The `apps` directory holds the manifests for `scout`, `probe`, `shuttle` and a Service for `scout`, all applied.

## Practice tasks

- List the objects in `starfleet` and mark which ones are described in the repository and which ones the cluster created.
- Create the namespace `gitops-system` and a ServiceAccount `gitops-agent`, and test `kubectl auth can-i get deployments -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent`.
- Add a Role and a RoleBinding in `starfleet`, and run the same check again.
- Run `kubectl auth can-i --list -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent` and read the rules.
- Add the wildcard `"*"` to the Role and see what `can-i` answers for deleting namespaces and for reading Secrets. Remove it again.
