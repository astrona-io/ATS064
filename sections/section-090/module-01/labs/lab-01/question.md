# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/lab-090` holds the desired state of the `starfleet` namespace and was applied to the cluster. The newest commit points the `probe` Deployment at an image tag that does not exist, so its rollout cannot finish. The namespace also holds a ConfigMap `visitor-log` with live data that is not stored in the repository.

1. Undo the bad commit with a new commit, so that the history is kept and the files under `apps` equal the state before the bad commit.
2. Apply `apps` and wait until `probe` is converged.
3. Make sure the ConfigMap `visitor-log` is unchanged.

Do not use `git reset`, do not rewrite or delete commits, do not use `kubectl edit` and do not delete any object. `kubectl` already points at the cluster.
