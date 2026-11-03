# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/cap-020` is the desired state of the `starfleet` namespace. The latest commit changes `apps/deployment-shuttle.yaml` so that `shuttle` reads its settings from a ConfigMap. The cluster still runs the previous commit, and the new file is not a complete description.

1. Read the manifest and find what it leaves to defaults or to other places. Do not apply it as it is.
2. Make the description complete in a new commit. The manifest of `shuttle` must name the namespace `starfleet` and pin the image to `ghcr.io/stefanprodan/podinfo:6.15.0`. The ConfigMap `shuttle-settings` that it reads must be declared in Git, in the file `apps/configmap-shuttle-settings.yaml`, with the key `MODE` set to `standard`.
3. Apply the repository so that the cluster matches it. `shuttle` must read the ConfigMap and have an available replica.
4. No object named `shuttle` may exist in the `default` namespace at the end.

Do not rewrite or delete existing commits, and do not delete any Deployment in `starfleet`.
