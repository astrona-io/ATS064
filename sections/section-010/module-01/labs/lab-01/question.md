# Question

Solve this question on: `terminal`

The `scout` Deployment must run the revision that the Git repository holds, and nobody wants to apply it by hand again. The repository is in `~/gitops-lab/lab-010`. The latest commit sets `scout` to three replicas, and the cluster still runs the previous commit.

1. Write a script `reconcile.sh` in the repository root that works as a simple GitOps agent:
   - It changes to its own directory, so it works when you start it from anywhere.
   - In every pass it prints the line `revision <short commit id>` and applies every manifest under `apps` with `kubectl apply -R -f apps`.
   - It reads the time between passes from the variable `INTERVAL` (default 15 seconds) and waits that long after each pass.
   - When the variable `RECONCILE_ONCE` is set, it stops after one pass.
2. Make the script executable and commit it to the repository. The working tree must be clean afterwards.
3. Run one pass so that `scout` in the cluster matches the latest commit.

The grader changes the replica count of `probe` by hand, runs one pass of your script from another directory, and expects the value from Git to return. Do not delete or scale down any workload.
