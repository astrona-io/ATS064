---
draft: true
exam_objectives:
  - Feedback Loop
---
# Summary

The feedback loop carries the result of a delivery from the cluster back to the agent and to people. A delivery can be applied, which means the API server accepted the objects, and still not be healthy. An agent reports sync status, whether the cluster matches the repository, and health status, whether the workloads work. Controllers write the result into the `status` of an object. For a Deployment this includes replica counts, `observedGeneration` and conditions. A status is current only when `observedGeneration` equals `metadata.generation`.

`progressDeadlineSeconds` turns a stuck rollout into the condition `Progressing=False` with the reason `ProgressDeadlineExceeded`, and the controller does not roll back. `kubectl rollout status` and `kubectl wait` turn status into exit codes. Readiness probes are the underlying signal, and a Deployment without one reports success for a container that merely started. Events add the cause to the condition. A failure with its cause in the manifest is fixed with a commit, not by editing the live object. A report should carry the revision as a full SHA, the result and the reason, be compared to the repository HEAD, and be sent only on failures and state changes.

- Check health, not only whether the apply succeeded.
- Read `observedGeneration` before trusting the status.
- Attach the revision to every report.

<!-- astrona:playground:destroy -->
