# Question

Solve this question on: `terminal`

The `scout` Deployment in `starfleet` was created by hand with `kubectl create deployment`, and the repository only holds the script that did it. The Git repository is in `~/gitops-lab/lab-020`. Replace the script's result with a declaration so that an agent can apply it again and again.

1. Create `apps/deployment-scout.yaml` with a complete description of `scout`:
   - the namespace `starfleet` stated in the file;
   - two replicas;
   - the image `ghcr.io/stefanprodan/podinfo:6.15.0`, pinned to a tag;
   - a memory limit of `128Mi`;
   - the container named `podinfo` and the label `app: scout` on the selector and the pod template, because those are the names the existing Deployment uses.
2. Commit the file. The working tree must be clean afterwards.
3. Apply the manifest with `kubectl apply` so that the live object is managed from the file and `kubectl diff -f apps/deployment-scout.yaml` shows no difference.

Do not delete the Deployment or scale it to zero. `kubectl` already points at the cluster as the cluster administrator.
