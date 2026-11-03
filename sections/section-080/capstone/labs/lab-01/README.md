---
estimated_duration: 45m
---

# Capstone: Feedback Loop

Graded integration lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: the progress deadline of 30 seconds is assumed to pass for both broken Deployments within the 150 second wait of the seed.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-080/capstone/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-080/capstone/labs/lab-01
astrona destroy ats-064-capstone-080
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-both-fixed-in-git.sh` | The committed manifests of shuttle and drifter no longer use the missing image tag or the missing readiness path |
| `validate-all-converged.sh` | Every Deployment in starfleet is converged: current status, all replicas updated and available, Progressing True |
| `validate-sync-status-record.sh` | The ConfigMap sync-status in starfleet has revision equal to the HEAD SHA, result Synced and failed-before drifter,shuttle |
| `validate-matches-git.sh` | kubectl diff on apps shows no difference and sync-status is not stored in Git |
| `validate-workloads-running.sh` | scout and probe are available |
