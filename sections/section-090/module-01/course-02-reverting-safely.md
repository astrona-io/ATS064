---
draft: true
exam_objectives:
  - Rollback
---
# Reverting Safely

A rollback works best as a fixed procedure. This part gives one: how to choose the commits to undo, how to revert one or several of them while keeping the good changes around them, how to verify the result before and after applying, and what to do when Git reports a conflict.

## Step 1: choose the commits

Read the history with the files that each commit touched:

<!-- astrona:playground:renew -->

```sh
cd ~/gitops-lab/play-090
git log --stat --format='%h %an %s'
```

Mark the commits that caused the problem, and mark the commits that are good and must stay. A bad commit often sits between good ones, because delivery continued while the problem was still unknown. Reverting everything back to the last good point throws the good changes away together with the bad ones. Reverting only the bad commits keeps them.

## Step 2: revert them

Revert one commit:

```sh
git revert --no-edit <sha>
```

`--no-edit` accepts the default message. To revert several commits, list them in the order in which you want the reverts recorded. Start with the newest, because reverting the newest first reduces the chance of a conflict:

```sh
git revert --no-edit <newest-bad> <older-bad>
```

Each commit gets its own revert commit. If you prefer a single commit for the whole rollback, use `git revert --no-commit` for each one, which changes the working tree without committing, and then run `git commit` once with a message that explains the reason. A revert of a merge commit needs `-m 1`, which names the parent that counts as the mainline.

## Step 3: resolve a conflict

If a later commit changed the same lines, Git stops with a conflict. The files hold conflict markers. Decide what the final content should be, edit the file, add it and continue:

```sh
git add apps/deployment-scout.yaml
git revert --continue
```

`git revert --abort` returns to the state before the command. A conflict is information: it says that the reverted change and a later change are linked, and a person should decide what the combination means.

## Step 4: verify before applying

Check the result in two ways. The first compares the files to the last good revision:

```sh
git diff <good-sha> HEAD -- apps
```

When the whole rollback restores one earlier state, the output is empty. When good changes were kept on purpose, the output shows exactly those changes. The second check compares the files to the cluster:

```sh
kubectl diff -R -f apps
```

`kubectl diff` shows what an apply would change. It exits with 0 when there is no difference, with 1 when there are differences, and with a higher value when it failed. Read the difference before applying: it must contain the reversal and nothing else.

## Step 5: apply and confirm

```sh
kubectl apply -R -f apps
kubectl -n starfleet rollout status deployment/probe --timeout=180s
```

A Deployment whose template returns to a previous content reuses the ReplicaSet of that content, so a rollback of a template can be quick. Confirm convergence with the status of every affected Deployment, as the delivery is not finished until each one reports its replicas updated and available.

## Step 6: check what the revert did not touch

Look at the objects that never lived in Git. In the playground, a ConfigMap `visitor-log` holds a counter that an application would write:

```sh
kubectl -n starfleet get configmap visitor-log -o jsonpath='{.data.count}'
```

The value is the same as before the revert, because the revert changed the manifests under `apps` and the ConfigMap is not one of them. Applying a directory never removes objects that the directory does not mention, unless pruning is switched on. This is the reason to know whether your agent prunes: with pruning on and a data object that is tracked by the repository, a revert that removes its manifest would delete its data.

## Undoing a revert

A revert is a commit, and it can be reverted as well. If the rollback itself was a mistake, `git revert <revert-sha>` re-applies the original change. This works only when the revert is still in the history, which is another reason not to rewrite it. In practice, the original change should be fixed before it returns, usually in a new commit that carries the fix and a clear message.

## Record the rollback

Write why. The default message names what was reverted, and the reason belongs in the body, together with a reference to the incident or ticket. A reader of the history in six months should be able to see why a change appeared and disappeared, and what replaced it.

## Common pitfalls

> [!WARNING]
> Do not revert a commit and apply without reading `kubectl diff`, because a conflict resolution can change more than you intend. Do not revert good commits together with the bad ones when only the bad ones are the problem. Do not assume that anything outside the repository was restored. After the revert, confirm that every affected Deployment is converged.
