---
estimated_duration: 45m
---

# Capstone: Reconciliation

Graded integration lab. **Status: UNTESTED.** It was built without booting the lab; run `astrona test -c .` before relying on it. Open risk: whether kubectl apply -R continues with valid files after a file with a validation error, and the exact retry timing of the blocked third drifter pod.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-050/capstone/labs/lab-01
astrona submit --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-050/capstone/labs/lab-01
astrona destroy ats-064-capstone-050
```

Authors run the local copy with `astrona run -c <lab>` and prove the reference solution with `astrona test -c <lab>`.

## Checks

| Script | What it proves |
| --- | --- |
| `validate-shuttle-converged.sh` | shuttle runs the image 6.15.0 with every replica updated and available |
| `validate-quota-fixed.sh` | The quota in outpost allows at least 3 pods in Git and live, and drifter has 3 available replicas |
| `validate-manifests-valid.sh` | Every manifest in apps is valid and the ConfigMap outpost-notes exists with retries "3" |
| `validate-idempotent.sh` | A second kubectl apply of the whole repository reports every object as unchanged |
| `validate-committed-on-history.sh` | The fixes are committed on top of the seed with a clean working tree |
| `validate-workloads-running.sh` | scout, probe and shuttle are available |
