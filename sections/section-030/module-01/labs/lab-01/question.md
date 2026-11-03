# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/lab-030` is the state store of the `starfleet` namespace. The latest commit replaced `apps/service-scout.yaml` with a raw export of the live Service, taken with `kubectl get -o yaml`. The cluster still runs the previous version of the file, and the export is not fit to be desired state.

1. Read the file and find the fields that the cluster generated or allocated. Do not apply it as it is.
2. Edit `apps/service-scout.yaml` so that it holds only the fields that people decide. It must keep the name `scout`, the namespace `starfleet`, the selector `app: scout` and the port `9898` with target port `9898`.
3. The file must pass `kubectl apply --dry-run=server -f apps/service-scout.yaml`, and `kubectl diff -f apps/service-scout.yaml` must show no difference.
4. Commit the change in a new commit. The working tree must be clean afterwards.

Do not rewrite or delete existing commits, and do not delete the Service. `kubectl` already points at the cluster as the cluster administrator.
