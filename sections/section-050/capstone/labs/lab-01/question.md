# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/cap-050` is the desired state of the `starfleet` and `outpost` namespaces. The latest commit added several objects and changed one more. The cluster is partly delivered, and three separate things prevent it from converging.

1. Find each cause. One of them is in the `starfleet` namespace and shows in a pod status, one is in `outpost` and shows in an event of a ReplicaSet, and one is a manifest that the API server rejects. Do not apply the whole directory blindly: read the failures first.
2. Fix each cause in Git, in new commits. Do not rewrite or delete existing commits.
3. The `shuttle` Deployment must run the image `ghcr.io/stefanprodan/podinfo:6.15.0` with every replica updated and available.
4. The `drifter` Deployment in `outpost` asks for 3 replicas. The namespace quota must allow at least 3 pods, and `drifter` must have 3 available replicas. The ConfigMap `outpost-notes` must exist with the value `retries` set to `3`.
5. Every manifest in `apps` must be valid. A second `kubectl apply -R -f apps` must report every object as unchanged. The working tree must be clean.

Do not delete pods or Deployments to make symptoms go away. `kubectl` already points at the cluster as the cluster administrator.
