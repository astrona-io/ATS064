---
estimated_duration: 25m
---

# Lab: Build A Reconciliation Loop

Graded lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: the checks scale probe and run reconcile.sh, which needs a working API server.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-010/module-01/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-010/module-01/labs/lab-01
astrona destroy ats-064-lab-010-01
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-scout-converged.sh` | The scout Deployment in the cluster matches the replica count in the latest commit |
| `validate-script-committed.sh` | reconcile.sh is executable, has valid syntax and is committed with a clean working tree |
| `validate-script-repairs-drift.sh` | One pass of reconcile.sh returns a manually changed Deployment to the value in Git |
| `validate-script-loops-and-logs.sh` | reconcile.sh stops after one pass with RECONCILE_ONCE, loops otherwise and prints the Git revision |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
