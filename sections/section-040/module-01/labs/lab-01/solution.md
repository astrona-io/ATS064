# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-040/module-01/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Find the drift

```sh
cd ~/gitops-lab/lab-040
kubectl diff -R -f apps
echo $?
```

The exit status is 1. The diff shows `spec.replicas` of `scout` at 5 where Git states 2, and the memory limit of the container in `probe` at `256Mi` where Git states `128Mi`.

## Step 2: Write the report

Save `drift-report.md` with one entry for each object, for example:

```markdown
# Drift report

- scout: spec.replicas is 5 live and 2 in Git. Decision: adopt, because the scale was deliberate.
- probe: the memory limit is 256Mi live and 128Mi in Git. Decision: revert, because nobody decided it.
```

## Step 3: Adopt one change and revert the other

Change the line `replicas: 2` in `apps/deployment-scout.yaml` to `replicas: 5`. Commit both files:

```sh
git add apps drift-report.md
git commit -m "Adopt five replicas for scout and report the drift"
```

Apply the repository. The manifest of `probe` states the 128Mi limit, so the apply puts it back:

```sh
kubectl apply -R -f apps
kubectl diff -R -f apps
echo $?
```

The diff prints nothing and the exit status is 0.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-040/module-01/labs/lab-01 --keep
```

All checks pass.
