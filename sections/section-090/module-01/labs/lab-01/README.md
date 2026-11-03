---
estimated_duration: 25m
---

# Lab: Roll Back A Bad Commit

Graded lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: probe keeps an available old pod while the bad rollout is stuck, so the starting guard check passes.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-090/module-01/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-090/module-01/labs/lab-01
astrona destroy ats-064-lab-090-01
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-reverted-by-commit.sh` | The bad commit was reversed by a new git revert commit on top of the seed, and the history is intact |
| `validate-apps-restored.sh` | The files under apps at HEAD equal the last good revision and the working tree is clean |
| `validate-cluster-converged.sh` | kubectl diff shows no difference and probe is converged with its image restored |
| `validate-data-survived.sh` | The ConfigMap visitor-log still exists with count 42 |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
