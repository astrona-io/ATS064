---
estimated_duration: 25m
---

# Lab: Replace An Imperative Deployment With A Declaration

Graded lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: the merge of the applied manifest with an object that has no last-applied annotation.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-020/module-01/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-020/module-01/labs/lab-01
astrona destroy ats-064-lab-020-01
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-declared-and-committed.sh` | apps/deployment-scout.yaml exists, is committed and the working tree is clean |
| `validate-scope-and-image-declared.sh` | The manifest names the namespace starfleet, a pinned image tag and a memory limit |
| `validate-applied-declaratively.sh` | The live scout Deployment was applied from the manifest and kubectl diff shows no difference |
| `validate-one-container.sh` | The scout pods have exactly one container, named podinfo |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
