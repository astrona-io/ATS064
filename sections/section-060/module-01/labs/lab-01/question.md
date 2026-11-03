# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/lab-060` holds the desired state of the `starfleet` namespace, which a GitOps agent will manage. The agent does not have an identity yet. You are the administrator who bootstraps it. The bootstrap objects go in a separate directory `platform`, apart from `apps`.

1. Create the namespace `gitops-system` and the ServiceAccount `gitops-agent` in it.
2. Create a Role `gitops-agent` in `starfleet`. It must allow `get`, `list`, `watch`, `create`, `update` and `patch` on `deployments` (group `apps`) and on `services` and `configmaps`. It must not use a wildcard and it must not allow `delete`.
3. Bind the Role to the ServiceAccount with a RoleBinding in `starfleet`.
4. Check the result with `kubectl auth can-i --as=system:serviceaccount:gitops-system:gitops-agent`. The agent must be able to patch deployments and create services and configmaps in `starfleet`. It must not read Secrets in `starfleet`, delete namespaces, delete deployments, or patch deployments in `outpost`.
5. Save every manifest under `platform`, commit it in a new commit and apply it. The working tree must be clean afterwards.

Do not use a ClusterRole or `cluster-admin`. `kubectl` already points at the cluster as the cluster administrator.
