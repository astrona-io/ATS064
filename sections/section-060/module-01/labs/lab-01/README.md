---
estimated_duration: 25m
---

# Lab: Give The Agent A Narrow Identity

Graded lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: kubectl auth can-i with --as for a ServiceAccount whose namespace was just created.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-060/module-01/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-060/module-01/labs/lab-01
astrona destroy ats-064-lab-060-01
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-identity-declared.sh` | The ServiceAccount gitops-agent exists in gitops-system and is declared in a committed file under platform |
| `validate-role-is-narrow.sh` | A Role gitops-agent exists in starfleet without wildcards and covers deployments, services and configmaps |
| `validate-agent-can-deliver.sh` | The agent identity may patch deployments and create services and configmaps in starfleet |
| `validate-agent-is-contained.sh` | The agent identity may not read secrets, delete namespaces or change deployments in outpost |
| `validate-committed-on-history.sh` | The manifests are committed on top of the seed with a clean working tree |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
