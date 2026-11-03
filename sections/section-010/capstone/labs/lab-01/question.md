# Question

Solve this question on: `terminal`

The Git repository in `~/gitops-lab/cap-010` is the desired state of the `starfleet` namespace. The cluster still runs the first commit. Two newer commits are not applied: one scales `scout` to four replicas and one scales `shuttle` to two replicas. The second commit contains a mistake, and a plain `kubectl apply` of the repository prints an error for it.

Build a continuous agent and make the cluster match Git.

1. Fix the mistake in a new commit. Do not rewrite or delete any existing commit.
2. Write `reconcile.sh` in the repository root and commit it. It must:
   - change to its own directory, so it works from anywhere;
   - print `revision <short commit id>` in every pass;
   - apply every manifest under `apps` with `kubectl apply -R -f apps`;
   - when `kubectl apply` fails, print a line that contains the word `FAILED` and keep running, so the valid manifests are still applied;
   - wait `INTERVAL` seconds between passes (default 15);
   - stop after one pass when `RECONCILE_ONCE` is set.
3. Run one pass so that `scout`, `probe` and `shuttle` match the latest commit.

The grader runs your script several times, including once with an extra invalid manifest in `apps` and `probe` changed by hand. Do not delete or scale down any workload.
