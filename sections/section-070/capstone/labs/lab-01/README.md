---
estimated_duration: 45m
---

# Capstone: State Store

Graded integration lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: the commit-msg hook is exercised directly, not through git commit; hooks are not part of the repository.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-070/capstone/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-070/capstone/labs/lab-01
astrona destroy ats-064-capstone-070
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-tag-and-cluster.sh` | An annotated tag release-1 names the parent of the EXPERIMENTAL_MODE commit and the cluster matches it |
| `validate-review-hook.sh` | A commit-msg hook rejects a message without a Reviewed-by trailer and accepts one with it |
| `validate-audit-file.sh` | audit.txt lists the unique authors of the seed history, one per line and sorted, and is committed |
| `validate-new-commits-reviewed.sh` | Every new commit has a Reviewed-by trailer and the history was not rewritten |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
