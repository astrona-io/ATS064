# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-060/module-01/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Write the bootstrap manifests

```sh
cd ~/gitops-lab/lab-060
mkdir -p platform
```

Save these four files in `platform`. First `namespace-gitops-system.yaml` and `serviceaccount-gitops-agent.yaml`, with the namespace `gitops-system` and the ServiceAccount `gitops-agent` in it. Then `role-gitops-agent.yaml`:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: gitops-agent
  namespace: starfleet
rules:
  - apiGroups: ["apps"]
    resources: ["deployments"]
    verbs: ["get", "list", "watch", "create", "update", "patch"]
  - apiGroups: [""]
    resources: ["services", "configmaps"]
    verbs: ["get", "list", "watch", "create", "update", "patch"]
```

And `rolebinding-gitops-agent.yaml`, which binds that Role to the ServiceAccount of `gitops-system`:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: gitops-agent
  namespace: starfleet
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: gitops-agent
subjects:
  - kind: ServiceAccount
    name: gitops-agent
    namespace: gitops-system
```

## Step 2: Commit and apply

The namespace must exist before the ServiceAccount, so apply it first:

```sh
git add platform
git commit -m "Add the narrow identity of the agent"
kubectl apply -f platform/namespace-gitops-system.yaml
kubectl apply -R -f platform
```

## Step 3: Test the permissions

```sh
kubectl auth can-i patch deployments -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent
kubectl auth can-i get secrets -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent
kubectl auth can-i patch deployments -n outpost --as=system:serviceaccount:gitops-system:gitops-agent
```

The first answer is `yes`. The other two are `no`, because the Role does not cover Secrets and lives only in `starfleet`.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-060/module-01/labs/lab-01 --keep
```

All checks pass.
