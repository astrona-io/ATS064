---
draft: true
exam_objectives:
  - Reconciliation
---
# Section 050: Reconciliation

This section teaches the reconciliation loop and what happens when it cannot succeed. You watch controllers correct a deleted pod, and then you diagnose a stuck rollout, a blocked quota and an invalid manifest, and fix each cause in Git.

**Exam objective covered:** Reconciliation

---

## What You Will Master

- Describe the observe, compare and act loop and why it is level-triggered and idempotent.
- Explain the difference between applied and converged.
- Classify failures as rejected, blocked or unhealthy.
- Find the cause of a stuck delivery from pod status and events and fix it in Git.

---

## The Learning Path

### 1. Reconciliation
*   **Module Reader:** **[Module 1: Reconciliation](./module-01/course.md)**
*   **Hands-on Playground:** `sections/section-050/module-01/playground` - kind cluster, `kubectl`, `git` and `jq` on your machine. A cluster with the starfleet workloads and a Git repository in ~/gitops-lab/play-050 for watching controllers correct deleted pods and for creating failed deliveries.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-050/module-01/playground
    ```
*   **Lab:** `sections/section-050/module-01/labs/lab-01` (UNTESTED). Find the cause of a stuck rollout, report it and fix it in a new commit.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-050/module-01/labs/lab-01
    astrona submit -c .
    ```

### Section Capstone Challenge
*   **Comprehensive Challenge:** Reconciliation Capstone - `sections/section-050/capstone/labs/lab-01` (UNTESTED)
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-050/capstone/labs/lab-01
    astrona submit -c .
    ```
*   **Hands-on Objective:** Fix three separate causes of a partly delivered repository: an image tag, a quota and an invalid manifest. The grader reads the cluster and repeats the apply to check idempotence.

### Knowledge Check
*   **Quiz:** 8 questions in `sections/section-050/quiz.yaml`. The pass score is 70 percent.
