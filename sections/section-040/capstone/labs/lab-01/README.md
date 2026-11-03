---
estimated_duration: 40m
---

# Capstone: Drift

Graded integration lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: whether kubectl scale and set resources create a conflict that needs --force-conflicts on the first server-side apply.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-040/capstone/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-040/capstone/labs/lab-01
astrona destroy ats-064-capstone-040
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-starfleet-converged.sh` | scout, probe and shuttle match their manifests in replicas and memory limit |
| `validate-agent-owns-fields.sh` | The Deployments scout, probe and shuttle have a server-side apply entry for the manager gitops-agent |
| `validate-outpost-untouched.sh` | The drifter Deployment in outpost still has 5 replicas and no gitops-agent entry |
| `validate-git-unchanged.sh` | Git was not edited: HEAD is the seed commit and the working tree is clean |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
