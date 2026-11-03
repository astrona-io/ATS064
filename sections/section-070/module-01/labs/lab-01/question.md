# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/lab-070` is the state store of the `starfleet` namespace. It has four commits by three authors, and the newest is applied to the cluster. One commit added an environment variable `EXPERIMENTAL_MODE` to the `shuttle` Deployment, and the team wants the cluster back at the revision just before it.

1. Find the commit that introduced `EXPERIMENTAL_MODE` using the Git history.
2. Create an annotated tag `release-1` on the parent of that commit, with a message.
3. Write the full 40-character SHA of the commit that `release-1` names into a file `released.txt` in the repository root, and commit the file.
4. Bring the cluster to the revision named by `release-1`. Do not check out another revision in your working tree.

Do not use `git reset`, do not rewrite or delete commits, and do not delete a Deployment. `kubectl` already points at the cluster.
