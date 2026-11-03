# Overview: Continuous Operation And Missed Events (Playground)

This is a **playground**, not a lab. It starts a fresh cluster and a Git repository, and then waits. There is no task, no `astrona submit` and no pass or fail. Change things, watch what happens, `astrona destroy`, start over.

## What's in the box

- A single-node `kind` cluster running Kubernetes 1.35. `kubectl` is already pointed at it, as the cluster administrator. You need `git` and `jq` on your machine.
- A Git repository in `~/gitops-lab/play-010`. It is the state store. The `apps` directory holds the manifests (the desired state).
- Two commits. The first adds the workloads. The second sets `scout` to three replicas. The cluster holds the first commit only, so `scout` runs two replicas and the repository declares three.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployments `scout`, `probe`, `shuttle` | The example application |
| `starfleet` | Service `scout` | Selects the `scout` pods on port 9898 |

## Practice tasks

- Run `kubectl diff -R -f apps` in the repository and read the difference. Run `echo $?` right after and explain the exit status.
- Apply the repository with `kubectl apply -R -f apps` and run the diff again. Explain why the second diff is empty.
- Scale `shuttle` by hand with `kubectl scale`. Decide which component would notice, and how long the difference would last in a system with no agent.
- Write a loop in `reconcile.sh` with an `INTERVAL` variable and a `RECONCILE_ONCE` variable. Run it with `INTERVAL=5` while you change the cluster by hand in a second terminal. Measure how long the cluster takes to return.
- Make a commit and do not run the loop. Start the loop later and note that it applies the commit without any event.
- Break the loop on purpose: add a file with an unknown field to `apps` and read what `kubectl apply` prints. Check whether the valid files were applied.
