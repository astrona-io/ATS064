---
estimated_duration: 40m
---

# Capstone: Desired State

Graded integration lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: kubectl create service clusterip is assumed to set the selector app=shuttle and the label app=shuttle.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-030/capstone/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-030/capstone/labs/lab-01
astrona destroy ats-064-capstone-030
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-configmap-in-git.sh` | The ConfigMap scout-settings is declared in Git with its live data |
| `validate-service-in-git.sh` | The Service shuttle is declared in Git with port 9898 and the selector app: shuttle |
| `validate-no-generated-fields.sh` | No file in apps holds a generated or allocated field |
| `validate-no-system-objects.sh` | The system-made ConfigMap kube-root-ca.crt is not committed |
| `validate-git-covers-cluster.sh` | Every Deployment, Service and ConfigMap in starfleet, except system-made ones, is produced by apps |
| `validate-matches-and-committed.sh` | kubectl diff on apps shows no difference and the work is committed on top of the seed |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
