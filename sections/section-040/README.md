---
draft: true
exam_objectives:
  - Drift
---
# Section 040: Drift

This section teaches what drift is, where it comes from and how to detect it. You create drift on a real cluster, decide whether to revert, adopt or exclude each difference, and use server-side apply to see which tool owns which field.

**Exam objective covered:** Drift

---

## What You Will Master

- Define drift and name its sources.
- Detect drift with kubectl diff and read its exit status.
- Choose between reverting, adopting and excluding a drifted field.
- Explain field ownership and conflicts in server-side apply.

---

## The Learning Path

### 1. Configuration Drift
*   **Module Reader:** **[Module 1: Configuration Drift](./module-01/course.md)**
*   **Hands-on Playground:** `sections/section-040/module-01/playground` - kind cluster, `kubectl`, `git` and `jq` on your machine. A cluster with the starfleet workloads and a Git repository in ~/gitops-lab/play-040 that matches the cluster, ready to create drift in.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-040/module-01/playground
    ```
*   **Lab:** `sections/section-040/module-01/labs/lab-01` (UNTESTED). Find two drifted Deployments, write a report, adopt the deliberate change and revert the other one.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-040/module-01/labs/lab-01
    astrona submit -c .
    ```

### Section Capstone Challenge
*   **Comprehensive Challenge:** Drift Capstone - `sections/section-040/capstone/labs/lab-01` (UNTESTED)
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-040/capstone/labs/lab-01
    astrona submit -c .
    ```
*   **Hands-on Objective:** Reconcile the starfleet namespace with server-side apply under the manager name gitops-agent, while another team drifter stays untouched. The grader reads the managed fields.

### Knowledge Check
*   **Quiz:** 8 questions in `sections/section-040/quiz.yaml`. The pass score is 70 percent.
