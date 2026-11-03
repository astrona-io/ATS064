---
draft: true
exam_objectives:
  - Rollback
---
# Summary

In GitOps a rollback is a change of the repository whose result equals an earlier good state, and the agent applies it like any other change. `kubectl rollout undo` acts on the cluster only. The repository still holds the bad change, so the next sync brings it back. `git revert <commit>` creates a new commit that applies the reverse of the given one and leaves history intact. `git reset --hard` rewrites the branch and breaks the shared history, so it does not belong on a branch that an agent follows. Rolling forward with a fix is the alternative when the cause is understood or the previous state is not available.

To roll back safely, choose the bad commits, revert them while keeping good commits between them, resolve conflicts on purpose, compare with `git diff <good-sha> HEAD -- apps` and `kubectl diff -R -f apps`, apply, and confirm convergence. A revert changes only the declared state. Data that never lived in Git, such as runtime ConfigMaps, volumes and databases, is not restored, and an agent that prunes can delete objects whose manifests the revert removed. A revert can itself be reverted, which only works while the history is intact.

- Revert with a new commit and never rewrite a shared branch.
- Keep the good commits between the bad ones.
- Check what a rollback does not restore.

<!-- astrona:playground:destroy -->
