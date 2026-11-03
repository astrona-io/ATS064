---
estimated_duration: 25m
---

# Lab: Read A Failed Delivery And Fix It

Graded lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: kubectl wait --for=condition=Progressing=false in the seed, with a 30 second progress deadline.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-080/module-01/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-080/module-01/labs/lab-01
astrona destroy ats-064-lab-080-01
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-feedback-recorded.sh` | feedback.txt names the Progressing reason that the failing Deployment reported, and is committed |
| `validate-fixed-in-git.sh` | The shuttle manifest at HEAD no longer uses the missing readiness path, and the fix is committed on top of the seed |
| `validate-shuttle-converged.sh` | shuttle is converged: observedGeneration equals generation, every replica is updated and available, and Progressing is True |
| `validate-matches-git.sh` | kubectl diff on apps shows no difference |
| `validate-workloads-running.sh` | scout and probe are available |
