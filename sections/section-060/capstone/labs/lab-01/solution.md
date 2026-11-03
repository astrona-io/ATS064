# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-060/capstone/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Find the privileged container

```sh
cd ~/gitops-lab/cap-060
grep -rn "privileged" apps
```

The match is in `apps/deployment-probe.yaml`, in the `securityContext` of the container. The `baseline` level rejects privileged containers, so the next rollout of `probe` would fail to create pods.

## Step 2: Edit the repository

In `apps/namespaces.yaml`, give the `starfleet` namespace the label:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: starfleet
  labels:
    pod-security.kubernetes.io/enforce: baseline
```

In `apps/deployment-probe.yaml`, remove the `securityContext` block with `privileged: true`. Then create the four bootstrap manifests in `platform`: the namespace `gitops-system`, the ServiceAccount, a Role with the rules for deployments, services and configmaps plus a rule with only the verbs `get`, `list` and `watch` on `pods`, and the RoleBinding that names the ServiceAccount of `gitops-system` as subject.

```sh
git add -A
git commit -m "Bootstrap the agent, enforce baseline and drop the privileged probe"
```

## Step 3: Apply and test

Apply the bootstrap objects, and then the applications:

```sh
kubectl apply -f platform/namespace-gitops-system.yaml
kubectl apply -R -f platform
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/probe --timeout=180s
kubectl auth can-i delete pods -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent
kubectl auth can-i get pods -n starfleet --as=system:serviceaccount:gitops-system:gitops-agent
```

The rollout completes, the first `can-i` answers `no` and the second answers `yes`.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-060/capstone/labs/lab-01 --keep
```

All checks pass.
