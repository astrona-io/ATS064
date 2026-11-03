---
draft: true
exam_objectives:
  - Feedback Loop
---
# Section 080: Feedback Loop

This section teaches how information flows from the cluster back to the agent and to people. You read Deployment conditions and events, fix failed deliveries in Git, and report a sync result that names the revision it belongs to.

**Exam objective covered:** Feedback Loop

---

## What You Will Master

- Tell applied from healthy and sync status from health status.
- Read conditions, replica counts and observedGeneration.
- Use a progress deadline to make a stuck rollout visible.
- Report a result together with the revision it belongs to.

---

## The Learning Path

### 1. The Feedback Loop
*   **Module Reader:** **[Module 1: The Feedback Loop](./module-01/course.md)**
*   **Hands-on Playground:** `sections/section-080/module-01/playground` - kind cluster, `kubectl`, `git` and `jq` on your machine. A cluster with the starfleet workloads and a Git repository in ~/gitops-lab/play-080 for reading conditions, causing a failed rollout and reporting status.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-080/module-01/playground
    ```
*   **Lab:** `sections/section-080/module-01/labs/lab-01` (UNTESTED). Read the status of a failed Deployment, record the reason, fix the cause in Git and confirm convergence.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-080/module-01/labs/lab-01
    astrona submit -c .
    ```

### Section Capstone Challenge
*   **Comprehensive Challenge:** Feedback Loop Capstone - `sections/section-080/capstone/labs/lab-01` (UNTESTED)
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-080/capstone/labs/lab-01
    astrona submit -c .
    ```
*   **Hands-on Objective:** Diagnose two Deployments that failed for different reasons, fix both in Git, wait for convergence and publish a sync-status record tied to the HEAD commit.

### Knowledge Check
*   **Quiz:** 8 questions in `sections/section-080/quiz.yaml`. The pass score is 70 percent.
