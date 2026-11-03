---
draft: true
exam_objectives:
  - Rollback
---
# Section 090: Rollback

This section teaches rollback as a commit. You revert one or several bad commits with git revert, keep the good commits between them, apply the result and check that runtime data outside Git survives.

**Exam objective covered:** Rollback

---

## What You Will Master

- Explain why a GitOps rollback is a commit and not a cluster command.
- Use git revert and tell it from git reset.
- Keep good commits between bad ones.
- Name what a rollback does not restore.

---

## The Learning Path

### 1. Rollback
*   **Module Reader:** **[Module 1: Rollback](./module-01/course.md)**
*   **Hands-on Playground:** `sections/section-090/module-01/playground` - kind cluster, `kubectl`, `git` and `jq` on your machine. A cluster and a Git repository in ~/gitops-lab/play-090 with a bad newest commit and a ConfigMap that is not in Git, for practicing revert and apply.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-090/module-01/playground
    ```
*   **Lab:** `sections/section-090/module-01/labs/lab-01` (UNTESTED). Revert a bad commit with a new commit, apply it and confirm that runtime data is unchanged.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-090/module-01/labs/lab-01
    astrona submit -c .
    ```

### Section Capstone Challenge
*   **Comprehensive Challenge:** Rollback Capstone - `sections/section-090/capstone/labs/lab-01` (UNTESTED)
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-090/capstone/labs/lab-01
    astrona submit -c .
    ```
*   **Hands-on Objective:** Revert two bad commits while keeping a good commit between them, then converge the cluster and check that live data survived.

### Knowledge Check
*   **Quiz:** 8 questions in `sections/section-090/quiz.yaml`. The pass score is 70 percent.
