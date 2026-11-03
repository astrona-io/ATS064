# Question

Solve this question on: `terminal`

The latest commit in the repository `~/gitops-lab/lab-050` updated the image of `scout`, and the cluster was changed to match. The delivery did not finish. The Git repository is the desired state of the `starfleet` namespace.

1. Find out why the rollout of `scout` is stuck. Use the pods, their description and the events.
2. Write `report.txt` at the root of the repository. It must name the object, the failure reason that Kubernetes shows (`ImagePullBackOff` or `ErrImagePull`) and the wrong image tag.
3. Fix the cause in Git with a new commit. Do not rewrite or delete existing commits.
4. Apply the repository and wait until `scout` has finished its rollout with every replica updated and available.
5. Commit the report. The working tree must be clean, and `kubectl diff -R -f apps` must show no difference.

Do not delete pods or Deployments to make the symptom go away. `kubectl` already points at the cluster as the cluster administrator.
