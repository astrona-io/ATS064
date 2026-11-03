# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-070/module-01/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Find the commit

```sh
cd ~/gitops-lab/lab-070
git log -S"EXPERIMENTAL_MODE" --format='%H %an %s'
```

One commit matches, and its subject mentions `EXPERIMENTAL_MODE`. Copy its SHA. `git show <sha>` shows that it changes only the manifest of `shuttle`.

## Step 2: Tag the parent

```sh
git tag -a release-1 <sha>^ -m "Last revision before EXPERIMENTAL_MODE"
git cat-file -t release-1
```

The second command prints `tag`, which means the tag is annotated.

## Step 3: Record the SHA

```sh
git rev-parse 'release-1^{commit}' > released.txt
git add released.txt
git commit -m "Record the release revision"
```

The form with `^{commit}` follows the tag object to the commit it names. The SHA of the tag object itself would not match.

## Step 4: Apply the tagged revision

```sh
WORK="$(mktemp -d)"
git archive release-1 apps | tar -x -C "$WORK"
kubectl diff -R -f "$WORK/apps"
kubectl apply -R -f "$WORK/apps"
kubectl -n starfleet rollout status deployment/shuttle --timeout=180s
rm -rf "$WORK"
```

The diff lists the removed variable on `shuttle` and the `probe` replica count that changed after the tagged commit. `kubectl diff` exits with 1 when there are differences, which is expected here.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-070/module-01/labs/lab-01 --keep
```

All checks pass.
