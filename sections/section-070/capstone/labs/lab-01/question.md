# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/cap-070` is the state store of the `starfleet` namespace. Its four commits are applied to the cluster. One commit added an environment variable `EXPERIMENTAL_MODE` to `shuttle`. The team wants three things.

1. Install a `commit-msg` hook in the repository that rejects a commit message without a `Reviewed-by` trailer and accepts one that has it. The hook must be executable.
2. Create an annotated tag `release-1` on the parent of the commit that added `EXPERIMENTAL_MODE`, and bring the cluster to that revision without checking it out in your working tree.
3. Create `audit.txt` in the repository root with the unique names of all authors in the existing history, one per line and sorted, and commit it.

Every commit that you make must carry a `Reviewed-by` trailer, for example `Reviewed-by: Ada Voss`. Do not rewrite history. `kubectl` already points at the cluster.
