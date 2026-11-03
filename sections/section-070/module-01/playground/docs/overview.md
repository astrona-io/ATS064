# Overview: The State Store And Its History (Playground)

This is a **playground**, not a lab. It starts a fresh cluster and a Git repository, and then waits. There is no task, no `astrona submit` and no pass or fail.

## What's in the box

- A single-node `kind` cluster running Kubernetes 1.35 with `kubectl` pointed at it as the cluster administrator. You need `git` and `jq` on your machine.
- A Git repository in `~/gitops-lab/play-070` with four commits by three authors. The newest commit is applied to the cluster. One of the commits adds an environment variable `EXPERIMENTAL_MODE` to `shuttle`.

## Practice tasks

- Read the history with `git log --format='%h %an %ad %s' --date=short` and name who changed what.
- Find the commit that added `EXPERIMENTAL_MODE` with `git log -S"EXPERIMENTAL_MODE"`, and read it with `git show`.
- Create an annotated tag on its parent and check it with `git cat-file -t`.
- Export the tagged revision with `git archive`, run `kubectl diff -R -f` on it and apply it. Check that the branch did not move.
- Try a lightweight tag, and compare `git rev-parse <tag>` with `git rev-parse <tag>^{commit}` for both kinds.
