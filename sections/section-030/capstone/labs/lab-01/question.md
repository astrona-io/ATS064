# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/cap-030` is meant to be the complete desired state of the `starfleet` namespace. Someone created two objects in the cluster by hand and never wrote them down. If the cluster were lost, they would be lost with it.

1. Find every Deployment, Service and ConfigMap in `starfleet` that the repository does not produce. Compare `kubectl -n starfleet get deployments,services,configmaps -o name` with `kubectl apply --dry-run=client -R -f apps -o name`. Objects that the system makes by itself are not part of the desired state.
2. Export each missing object, remove every field that the cluster generated or allocated, and save it as a manifest under `apps`. The live data must not change: the ConfigMap keeps its keys and values, and the Service keeps its port and selector.
3. No file in `apps` may contain `uid`, `resourceVersion`, `creationTimestamp`, `clusterIP`, `clusterIPs` or a `status` block.
4. After your change `kubectl diff -R -f apps` must show no difference.
5. Commit the new files in a new commit. The working tree must be clean afterwards.

Do not rewrite or delete existing commits, and do not delete any object from the cluster.
