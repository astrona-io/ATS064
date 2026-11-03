# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/cap-090` holds the desired state of the `starfleet` namespace and was applied to the cluster. It has four commits. Two of them are bad: one points `probe` at an image tag that does not exist, and one moves the readiness check of `shuttle` to a path that does not exist. Between them sits a good commit that scales `scout` to 3 replicas. The namespace also holds a ConfigMap `visitor-log` with live data that is not in the repository.

1. Undo both bad commits with new commits, and keep the scale-up of `scout`. The files of `probe` and `shuttle` must equal their state in the first commit.
2. Apply `apps` and wait until every Deployment in `starfleet` is converged.
3. Make sure `scout` runs 3 replicas and the ConfigMap `visitor-log` is unchanged.

Do not use `git reset`, do not rewrite or delete commits, do not use `kubectl edit` and do not delete any object. The working tree must be clean at the end. `kubectl` already points at the cluster.
