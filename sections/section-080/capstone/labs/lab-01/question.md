# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/cap-080` holds the desired state of the `starfleet` namespace and was applied to the cluster. Two Deployments did not roll out. Both have a progress deadline of 30 seconds, which has passed.

1. Find out why each of the two failed, from the Deployment conditions, the pod status and the events. Fix each cause in the manifest in the repository.
2. Commit the fixes, apply `apps`, and wait until every Deployment in `starfleet` is converged: the status is current, and every replica is updated and available.
3. After your last commit, create a ConfigMap `sync-status` in `starfleet` with these keys: `revision` with the full SHA of the commit at HEAD, `result` with the value `Synced`, and `failed-before` with the names of the two Deployments that failed, sorted and separated by a comma. This ConfigMap is created in the cluster only, not stored in `apps`.

Do not delete a Deployment, do not rewrite history and do not use `kubectl edit`. The working tree must be clean at the end. `kubectl` already points at the cluster.
