---
estimated_duration: 40m
---

# Capstone: Continuous Operation

Graded integration lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: the checks write a temporary invalid manifest into apps and run the script several times.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-010/capstone/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-010/capstone/labs/lab-01
astrona destroy ats-064-capstone-010
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-manifest-fixed-in-git.sh` | The invalid shuttle manifest is fixed in a new commit and passes server-side validation |
| `validate-cluster-converged.sh` | scout, probe and shuttle in the cluster match the replica counts in the latest commit |
| `validate-script-committed.sh` | reconcile.sh is executable, valid and committed |
| `validate-script-interval-and-revision.sh` | The loop runs several passes with INTERVAL=2, prints the revision and stops with RECONCILE_ONCE |
| `validate-script-survives-failed-apply.sh` | A failed apply is reported with the word FAILED and does not stop other manifests from being applied |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
