# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/cap-040` is the desired state. The agent role for the `starfleet` namespace is yours. The cluster has drifted from Git in two ways: a change that is already committed and waits for delivery, and changes that people made by hand. Another team keeps a `drifter` Deployment in the `outpost` namespace. Its manifest is in the same repository, but the live replica count is theirs.

1. Find every difference with `kubectl diff -R -f apps`.
2. Reconcile only the `starfleet` namespace with server-side apply. Use the field manager name `gitops-agent`, and take ownership of the fields that Git declares with `--force-conflicts`.
3. After your work, `scout`, `probe` and `shuttle` must match the manifests in replicas and memory limit, and each of them must have an `Apply` entry for the manager `gitops-agent` in its managed fields.
4. The `drifter` Deployment in `outpost` must still have 5 replicas, and the manager `gitops-agent` must not appear in its managed fields.
5. Git is the source of truth. Do not edit or commit any file.

Do not delete any Deployment. `kubectl` already points at the cluster as the cluster administrator.
