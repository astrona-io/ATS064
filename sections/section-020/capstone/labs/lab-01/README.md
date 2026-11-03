---
estimated_duration: 40m
---

# Capstone: Declarative Description

Graded integration lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: the starting repository holds a manifest that creates a Deployment in the default namespace if applied.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-020/capstone/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-020/capstone/labs/lab-01
astrona destroy ats-064-capstone-020
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-scope-declared.sh` | The shuttle manifest names the namespace starfleet and no stray shuttle Deployment exists in default |
| `validate-image-pinned.sh` | The shuttle manifest pins the image tag 6.15.0 and the live pods run it |
| `validate-configmap-declared.sh` | The ConfigMap shuttle-settings is declared in Git and exists in the cluster with the key MODE |
| `validate-shuttle-uses-config.sh` | shuttle reads the ConfigMap and has an available replica |
| `validate-committed-on-history.sh` | The fix is committed on top of the existing history with a clean working tree and passes server-side validation |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
