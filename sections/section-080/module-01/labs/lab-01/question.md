# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/lab-080` holds the desired state of the `starfleet` namespace and was applied to the cluster. One Deployment, `shuttle`, did not roll out. It has a progress deadline of 30 seconds, which has passed.

1. Read the `Progressing` condition of the Deployment `shuttle` and write its `reason` into a file `feedback.txt` in the repository root. Find the cause of the failure from the pod events.
2. Fix the cause in the manifest in the repository, not on the live object.
3. Commit `feedback.txt` and the fix in a new commit, and apply `apps`.
4. Wait until `shuttle` has finished rolling out. The status must be current, with every replica updated and available.

Do not delete a Deployment, do not rewrite history and do not use `kubectl edit`. `kubectl` already points at the cluster.
