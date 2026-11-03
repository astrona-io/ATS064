---
draft: true
exam_objectives:
  - State Store
---
# Section 070: State Store

This section teaches what a state store must provide and why Git fits. You search a commit history for the change that caused a problem, mark the last good revision with an annotated tag, and bring the cluster to it without rewriting history.

**Exam objective covered:** State Store

---

## What You Will Master

- Explain versioned, immutable and auditable storage.
- Read a history and find the commit that introduced a change.
- Create an annotated tag and record the exact commit SHA.
- Apply an older revision while leaving the history intact.

---

## The Learning Path

### 1. The State Store And Its History
*   **Module Reader:** **[Module 1: The State Store And Its History](./module-01/course.md)**
*   **Hands-on Playground:** `sections/section-070/module-01/playground` - kind cluster, `kubectl`, `git` and `jq` on your machine. A cluster and a Git repository in ~/gitops-lab/play-070 with four commits by three authors, for practicing history search, tags and applying an older revision.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-070/module-01/playground
    ```
*   **Lab:** `sections/section-070/module-01/labs/lab-01` (UNTESTED). Find the commit that added a setting, tag its parent, record the SHA and bring the cluster to that revision.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-070/module-01/labs/lab-01
    astrona submit -c .
    ```

### Section Capstone Challenge
*   **Comprehensive Challenge:** State Store Capstone - `sections/section-070/capstone/labs/lab-01` (UNTESTED)
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-070/capstone/labs/lab-01
    astrona submit -c .
    ```
*   **Hands-on Objective:** Install a review-trailer hook, tag and apply the last good revision, and write an audit file of the authors. The grader exercises the hook directly and checks every new commit.

### Knowledge Check
*   **Quiz:** 8 questions in `sections/section-070/quiz.yaml`. The pass score is 70 percent.
