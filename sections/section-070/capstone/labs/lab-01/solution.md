# Solution

Solve this lab on `terminal`. Each step ends with `astrona submit`. The `--keep` flag keeps the lab running. This lab was built without running it, so the text describes what you should see instead of printing output.

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-070/capstone/labs/lab-01
```

`astrona submit` right after the start shows one check that already passes: `workloads-running`.

## Step 1: Install the hook

Hooks live in `.git/hooks` and are not part of the repository. Create `.git/hooks/commit-msg`:

```sh
cd ~/gitops-lab/cap-070
cat > .git/hooks/commit-msg <<'EOF'
#!/usr/bin/env bash
if git interpret-trailers --parse "$1" | grep -q '^Reviewed-by: .'; then
  exit 0
fi
echo "commit rejected: add a Reviewed-by trailer" >&2
exit 1
EOF
chmod +x .git/hooks/commit-msg
```

Git passes the path of the message file as the first argument. A non-zero exit stops the commit.

## Step 2: Tag and apply

```sh
git log -S"EXPERIMENTAL_MODE" --format='%H %an %s'
git tag -a release-1 <sha>^ -m "Last revision before EXPERIMENTAL_MODE"
WORK="$(mktemp -d)"
git archive release-1 apps | tar -x -C "$WORK"
kubectl apply -R -f "$WORK/apps"
kubectl -n starfleet rollout status deployment/shuttle --timeout=180s
rm -rf "$WORK"
```

## Step 3: Write and commit the audit file

```sh
git log seed --format=%an | sort -u > audit.txt
git add audit.txt
git commit -m "Record the authors" -m "Reviewed-by: Ada Voss"
```

A commit without the trailer is now rejected by the hook. The second `-m` adds a paragraph, and a trailer in the last paragraph is read by `git interpret-trailers`.

```sh
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-070/capstone/labs/lab-01 --keep
```

All checks pass.
