---
draft: true
exam_objectives:
  - Desired State
---
# Section 030: Desired State

This section teaches what the desired state is and what the state store must guarantee. You export a live object, remove the fields that the cluster generated, and check that the repository describes every object that the cluster runs.

**Exam objective covered:** Desired State

---

## What You Will Master

- Distinguish the desired state from the observed state.
- Recognize fields that the system generates and keep them out of Git.
- Explain what versioned and immutable mean for a state store.
- Find objects that exist in the cluster without a description in Git.

---

## The Learning Path

### 1. Desired State In Version Control
*   **Module Reader:** **[Module 1: Desired State In Version Control](./module-01/course.md)**
*   **Hands-on Playground:** `sections/section-030/module-01/playground` - kind cluster, `kubectl`, `git` and `jq` on your machine. A cluster with the starfleet workloads and a Git repository in ~/gitops-lab/play-030 that you can compare with the live objects.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-030/module-01/playground
    ```
*   **Lab:** `sections/section-030/module-01/labs/lab-01` (UNTESTED). Clean a raw export of a live Service so that only the declared fields are stored in Git.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-030/module-01/labs/lab-01
    astrona submit -c .
    ```

### Section Capstone Challenge
*   **Comprehensive Challenge:** Desired State Capstone - `sections/section-030/capstone/labs/lab-01` (UNTESTED)
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-030/capstone/labs/lab-01
    astrona submit -c .
    ```
*   **Hands-on Objective:** Bring two objects that were made by hand under version control by exporting them, removing generated fields and committing. The grader compares the repository with the live cluster.

### Knowledge Check
*   **Quiz:** 8 questions in `sections/section-030/quiz.yaml`. The pass score is 70 percent.
