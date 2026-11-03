---
estimated_duration: 25m
---

# Lab: Find And Mark The Last Good Revision

Graded lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: kubectl apply removing the env var that the old revision does not set, through the last-applied annotation.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-070/module-01/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-070/module-01/labs/lab-01
astrona destroy ats-064-lab-070-01
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-tag-on-last-good.sh` | An annotated tag release-1 names the parent of the commit that added EXPERIMENTAL_MODE |
| `validate-released-file.sh` | released.txt holds the full SHA of the tagged commit and is committed |
| `validate-cluster-at-release.sh` | The cluster matches the files of release-1 and shuttle has no EXPERIMENTAL_MODE variable |
| `validate-history-intact.sh` | The history was not rewritten: the seed and the bad commit are still on main |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
