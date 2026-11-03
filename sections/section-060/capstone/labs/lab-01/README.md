---
estimated_duration: 45m
---

# Capstone: Managed System

Graded integration lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: baseline Pod Security Admission is assumed to block the privileged probe pods when the Deployment rolls out, and to allow the other podinfo pods.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-060/capstone/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-060/capstone/labs/lab-01
astrona destroy ats-064-capstone-060
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-bootstrap-in-platform.sh` | platform holds the namespace, ServiceAccount, Role and RoleBinding for gitops-agent, committed and applied |
| `validate-agent-permissions.sh` | The agent may deliver and read pods in starfleet but may not delete pods, read secrets or change roles |
| `validate-no-cluster-wide-grant.sh` | No ClusterRoleBinding or wildcard Role gives gitops-agent cluster-wide or wildcard access |
| `validate-pod-security-enforced.sh` | The namespace starfleet enforces the baseline Pod Security level, and the label is declared in Git |
| `validate-probe-compliant.sh` | probe runs without a privileged container, with every replica updated and available |
| `validate-matches-and-committed.sh` | kubectl diff on apps and platform shows no difference and the work is committed on top of the seed |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
