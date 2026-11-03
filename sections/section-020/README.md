---
draft: true
exam_objectives:
  - Declarative Description
---
# Section 020: Declarative Description

This section teaches what a declarative description is and what it must contain to be complete. You compare an imperative script with a manifest on a real cluster, and then check a declaration for its scope, its references, its defaults and its dependencies.

**Exam objective covered:** Declarative Description

---

## What You Will Master

- Distinguish a desired-state description from an imperative procedure.
- Explain why kubectl apply is safe to repeat and kubectl create is not.
- Explain implementation independence and its limits.
- Find missing scope, unpinned references, hidden defaults and undeclared dependencies in a manifest.

---

## The Learning Path

### 1. Declarative Descriptions And Implementation Independence
*   **Module Reader:** **[Module 1: Declarative Descriptions And Implementation Independence](./module-01/course.md)**
*   **Hands-on Playground:** `sections/section-020/module-01/playground` - kind cluster, `kubectl`, `git` and `jq` on your machine. A cluster with the starfleet workloads and a Git repository in ~/gitops-lab/play-020 that holds declarative manifests and an imperative script.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-020/module-01/playground
    ```
*   **Lab:** `sections/section-020/module-01/labs/lab-01` (UNTESTED). Replace a Deployment that was created by hand with a committed, applied declaration.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-020/module-01/labs/lab-01
    astrona submit -c .
    ```

### Section Capstone Challenge
*   **Comprehensive Challenge:** Declarative Description Capstone - `sections/section-020/capstone/labs/lab-01` (UNTESTED)
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-020/capstone/labs/lab-01
    astrona submit -c .
    ```
*   **Hands-on Objective:** Complete the shuttle manifest in a new commit: declare its namespace, pin its image and add the ConfigMap that it reads. The grader reads the live cluster and the repository.

### Knowledge Check
*   **Quiz:** 8 questions in `sections/section-020/quiz.yaml`. The pass score is 70 percent.
