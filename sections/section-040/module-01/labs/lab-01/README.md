---
estimated_duration: 25m
---

# Lab: Report And Reconcile Drift

Graded lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: the scale and the resource change are made after the first apply, so the apply of the learner must merge with live edits.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-040/module-01/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-040/module-01/labs/lab-01
astrona destroy ats-064-lab-040-01
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-drift-report.sh` | drift-report.md names both drifted objects and fields and is committed |
| `validate-intentional-change-adopted.sh` | The committed manifest of scout states 5 replicas, matching the live Deployment |
| `validate-unintended-change-reverted.sh` | The memory limit of probe is back to 128Mi in the cluster and unchanged in Git |
| `validate-no-drift-left.sh` | kubectl diff on apps shows no difference |
| `validate-committed-on-history.sh` | The changes are committed on top of the seed with a clean working tree |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
