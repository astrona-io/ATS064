---
draft: true
exam_objectives:
  - Managed System
---
# Section 060: Managed System

This section teaches the parts of a GitOps setup and the scope of a managed system. You bootstrap an agent identity with only the permissions it needs, test the permissions from the command line, and make the managed system enforce a Pod Security level.

**Exam objective covered:** Managed System

---

## What You Will Master

- Name the state store, the agent and the managed system.
- Define and write down the scope of a managed system.
- Create an agent identity with a ServiceAccount, a Role and a RoleBinding.
- Apply least privilege and test it with kubectl auth can-i.

---

## The Learning Path

### 1. The Managed System And The Agent
*   **Module Reader:** **[Module 1: The Managed System And The Agent](./module-01/course.md)**
*   **Hands-on Playground:** `sections/section-060/module-01/playground` - kind cluster, `kubectl`, `git` and `jq` on your machine. A cluster with the starfleet workloads and a Git repository in ~/gitops-lab/play-060 for practicing identities, roles and permission checks.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-060/module-01/playground
    ```
*   **Lab:** `sections/section-060/module-01/labs/lab-01` (UNTESTED). Bootstrap a narrow identity for the agent and test what it can and cannot do.
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-060/module-01/labs/lab-01
    astrona submit -c .
    ```

### Section Capstone Challenge
*   **Comprehensive Challenge:** Managed System Capstone - `sections/section-060/capstone/labs/lab-01` (UNTESTED)
    ```bash
    astrona run --git ssh://git@github.com/astrona-io/ATS064.git -c sections/section-060/capstone/labs/lab-01
    astrona submit -c .
    ```
*   **Hands-on Objective:** Bootstrap the agent, enforce the baseline Pod Security level on the namespace and fix the privileged Deployment that it would block. The grader tests the permissions with kubectl auth can-i.

### Knowledge Check
*   **Quiz:** 8 questions in `sections/section-060/quiz.yaml`. The pass score is 70 percent.
