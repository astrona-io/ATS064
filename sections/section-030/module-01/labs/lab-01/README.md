---
estimated_duration: 25m
---

# Lab: Clean A Raw Export Of Live State

Graded lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: a server-side dry run of the cleaned Service assumes kubectl diff exits 0 for an identical object.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-030/module-01/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-030/module-01/labs/lab-01
astrona destroy ats-064-lab-030-01
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-generated-fields-removed.sh` | apps/service-scout.yaml holds no uid, resourceVersion, creationTimestamp, clusterIP, clusterIPs or status |
| `validate-intent-kept.sh` | The Service keeps its name, namespace, selector and port 9898 |
| `validate-applies-and-matches.sh` | The file passes a server-side dry run and kubectl diff shows no difference with the live Service |
| `validate-committed-on-history.sh` | The cleaned file is committed in a new commit on top of the seed with a clean working tree |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
