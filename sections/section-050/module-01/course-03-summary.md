---
draft: true
exam_objectives:
  - Reconciliation
---
# Summary

Reconciliation is a repeated pass of three steps: observe the actual state, compare it with the desired state, and act on the difference. Kubernetes controllers are level-triggered, which means each pass reads the current state and does not depend on having seen an event, so a lost event does not leave a difference unnoticed. Actions are idempotent and expressed as targets, so a pass can be repeated or restarted safely.

A system has converged when the actual state equals the desired state. Applied is not converged: apply reports that the API server accepted an object, and `rollout status` reports whether the new pods are available. Dependencies such as a Namespace are handled by repeating the loop, and by applying them first.

A delivery can fail in three places. A rejected change is refused by the API server and shows as an apply error. A blocked change is accepted, and a controller cannot create the pods, for example because of a ResourceQuota, which shows as events. An unhealthy change creates pods that never become ready, for example `ImagePullBackOff` from an image that does not exist. Retries fix transient causes but not a cause in the repository. The correct fix is a new commit that corrects the cause, followed by a check for convergence.

- Observe, compare, act, and repeat.
- Applied means accepted, and converged means matching.
- Rejected, blocked and unhealthy have different evidence.

<!-- astrona:playground:destroy -->
