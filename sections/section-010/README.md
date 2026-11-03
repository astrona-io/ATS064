---
draft: true
exam_objectives:
  - Continuous
---
# Section 010: Continuous

This section teaches what the word continuous means in GitOps. A one-time delivery job applies a revision once. A continuous agent returns to the comparison between Git and the cluster again and again, and recovers when a change notification is lost.

**Exam objective covered:** Continuous

---

## What You Will Master

- Distinguish a one-time deployment job from a continuous agent.
- Explain polling intervals, events, missed events and convergence time.
- Explain why each repeated pass must be safe, authorized and have one owner of each managed field.
- Write a small reconciliation loop with kubectl diff and kubectl apply against a Git repository.

---

## The Learning Path

### 1. Continuous Operation And Missed Events
*   **Module Reader:** **[Module 1: Continuous Operation And Missed Events](./module-01/course.md)**
*   **Hands-on Playground:** `sections/section-010/module-01/playground` - kind cluster, `kubectl`, `git` and `jq` on your machine. A cluster with the starfleet workloads and a Git repository in ~/gitops-lab/play-010 whose latest commit is not applied yet.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-010/module-01/playground
    ```
*   **Lab:** `sections/section-010/module-01/labs/lab-01` (UNTESTED). Write a reconciliation loop script, commit it and make the cluster match Git.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-010/module-01/labs/lab-01
    astrona submit -c .
    ```

### Section Capstone Challenge
*   **Comprehensive Challenge:** Continuous Operation Capstone - `sections/section-010/capstone/labs/lab-01` (UNTESTED)
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-010/capstone/labs/lab-01
    astrona submit -c .
    ```
*   **Hands-on Objective:** Fix an invalid manifest in a new commit, write a loop that reports a failed apply and still applies the valid manifests, supports INTERVAL and RECONCILE_ONCE, and make three Deployments match Git. The grader reads the live cluster and the repository.

### Knowledge Check
*   **Quiz:** 8 questions in `sections/section-010/quiz.yaml`. The pass score is 70 percent.
