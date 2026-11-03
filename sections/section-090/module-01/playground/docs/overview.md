# Overview: Rollback (Playground)

This is a **playground**, not a lab. It starts a fresh cluster and a Git repository, and then waits. There is no task, no `astrona submit` and no pass or fail.

## What's in the box

- A single-node `kind` cluster running Kubernetes 1.35 with `kubectl` pointed at it as the cluster administrator. You need `git` and `jq` on your machine.
- A Git repository in `~/gitops-lab/play-090` with three commits, applied at the newest one. The newest commit points `probe` at an image tag that does not exist, so that Deployment cannot finish its rollout while the old pod keeps running.
- A ConfigMap `visitor-log` in `starfleet` with a counter. It is not stored in the repository.

## Practice tasks

- Read the history and find the bad commit. Run `kubectl -n starfleet rollout status deployment/probe --timeout=60s` and read why it fails.
- Run `kubectl rollout undo deployment/probe -n starfleet` and then reapply `apps` to see the bad change return.
- Revert the bad commit with `git revert --no-edit HEAD` and apply. Compare `git diff HEAD~2 HEAD -- apps`.
- Check that `visitor-log` still holds its value.
- Revert the revert and observe what happens, then revert it again.
