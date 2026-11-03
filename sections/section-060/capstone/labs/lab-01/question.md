# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/cap-060` holds the desired state of the `starfleet` namespace. A GitOps agent will manage it, and you are the administrator who prepares the managed system. Three things are missing.

1. Bootstrap the agent. In a new directory `platform`, declare the namespace `gitops-system`, the ServiceAccount `gitops-agent` in it, a Role `gitops-agent` in `starfleet` and a RoleBinding to the ServiceAccount. The agent must be able to `get`, `list`, `watch`, `create`, `update` and `patch` deployments, services and configmaps in `starfleet`, and only `get`, `list` and `watch` pods. It must not delete pods, read Secrets, create Roles or RoleBindings, or change deployments in `outpost`. Use no wildcards, no ClusterRole and no ClusterRoleBinding.
2. Make the `starfleet` namespace enforce the `baseline` Pod Security Standard by declaring the label `pod-security.kubernetes.io/enforce: baseline` on it in `apps/namespaces.yaml`.
3. One Deployment in `apps` runs a privileged container, which `baseline` does not allow. Fix its manifest so that the Deployment rolls out under the new rule, with every replica updated and available.
4. Commit everything in new commits, apply `platform` and `apps`, and make sure `kubectl diff -R -f apps` and `kubectl diff -R -f platform` show no difference. The working tree must be clean.

Do not rewrite or delete existing commits. `kubectl` already points at the cluster as the cluster administrator.
