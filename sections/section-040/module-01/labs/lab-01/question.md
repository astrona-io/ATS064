# Question

Solve this question on: `terminal`

Someone worked on the `starfleet` namespace by hand during a traffic spike and did not update Git. The repository in `~/gitops-lab/lab-040` is the desired state. Two live Deployments no longer match it.

1. Find the drift with `kubectl diff -R -f apps`.
2. Write `drift-report.md` at the root of the repository. For each drifted object, name the object, the field, the live value and the declared value, and state your decision (adopt or revert).
3. The scale of `scout` to 5 replicas was deliberate: adopt it. Edit the manifest so that it states 5 replicas.
4. The memory limit of `probe` was not decided by anyone: revert it in the cluster, and do not commit it.
5. Commit the report and the manifest in a new commit. The working tree must be clean afterwards. At the end, `kubectl diff -R -f apps` must show no difference.

Do not rewrite or delete existing commits, and do not delete any Deployment.
