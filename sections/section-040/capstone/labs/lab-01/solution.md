# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-040/capstone/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Find the differences

```sh
cd ~/gitops-lab/cap-040
git log --oneline
kubectl diff -R -f apps
```

The diff lists `scout` at 4 replicas where Git states 2, `probe` with a 256Mi limit where Git states 128Mi, `shuttle` at 1 replica where the latest commit states 2, and `drifter` in `outpost` at 5 replicas where Git states 3. The first three belong to your namespace. The last one belongs to another team.

## Step 2: Apply the starfleet files with server-side apply

Apply only the files of the namespace you own:

```sh
for n in scout probe shuttle; do
  kubectl apply --server-side --field-manager=gitops-agent --force-conflicts -f apps/deployment-$n.yaml
done
kubectl apply --server-side --field-manager=gitops-agent --force-conflicts -f apps/service-scout.yaml
```

Without `--force-conflicts` the apply of `scout` and `probe` is refused, because other managers own the fields that were changed by hand. Do not run `kubectl apply -R -f apps`: it would also apply the drifter manifest.

## Step 3: Check ownership and grade

```sh
kubectl -n starfleet get deployment scout --show-managed-fields -o yaml
kubectl -n outpost get deployment drifter
git status
```

The managed fields of `scout` list the manager `gitops-agent` with the operation `Apply`. The drifter keeps 5 replicas, and Git has no changes.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-040/capstone/labs/lab-01 --keep
```

All checks pass.
