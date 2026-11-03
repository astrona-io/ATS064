---
estimated_duration: 25m
---

# Lab: Find And Fix A Stuck Rollout

Graded lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: the guard check assumes the old scout pods stay available while the new pod cannot pull its image.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-050/module-01/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-050/module-01/labs/lab-01
astrona destroy ats-064-lab-050-01
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-report.sh` | report.txt names the failing object, the failure reason and the wrong tag, and is committed |
| `validate-fixed-in-git.sh` | A new commit states the image ghcr.io/stefanprodan/podinfo:6.15.0 for scout |
| `validate-rollout-converged.sh` | The scout Deployment has finished its rollout with the image 6.15.0 and no pod waits on an image pull |
| `validate-matches-git.sh` | kubectl diff on apps shows no difference and the working tree is clean |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
