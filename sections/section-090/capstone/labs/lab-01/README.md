---
estimated_duration: 45m
---

# Capstone: Rollback

Graded integration lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: the 30 second deadline and the old pods that keep probe and shuttle available during their stuck rollouts.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-090/capstone/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-090/capstone/labs/lab-01
astrona destroy ats-064-capstone-090
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-bad-reverted-good-kept.sh` | probe and shuttle manifests equal the first commit and scout equals the scaled version |
| `validate-history-kept.sh` | The history was not rewritten: the four seed commits are ancestors of HEAD and the tree is clean |
| `validate-all-converged.sh` | kubectl diff shows no difference and every Deployment in starfleet is converged |
| `validate-scout-scaled.sh` | scout runs 3 replicas, so the good change between the bad commits is live |
| `validate-data-survived.sh` | The ConfigMap visitor-log still exists with count 42 |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
