---
draft: true
exam_objectives:
  - Drift
---
# Summary

Drift is a difference between the desired state in Git and the live state that nobody decided by changing Git. Its sources are manual changes, other controllers such as an autoscaler, admission webhooks, API defaults, partly finished deliveries and objects created by hand. Only some of them are mistakes.

Drift is found by comparing the merged result of a dry run with the live object. `kubectl diff` exits with 0 for no difference, 1 for differences and a higher value for a failed command. The comparison covers the fields that the manifest states, so it cannot see added fields that no manifest mentions and objects without a manifest.

A team can revert, adopt or exclude a drifted field. Revert changes the cluster to match Git. Adopt writes the live value into a commit. Exclude removes the field from the manifest because another controller owns it. Decide before you revert, because the live value is the evidence for adopting. Client-side apply does not remove fields that no manifest ever stated. Server-side apply records a manager for every field, refuses a conflicting write and lets an agent take ownership with `--force-conflicts`. An agent limits its apply to its own scope.

- Drift is a signal and not always a defect.
- Revert, adopt or exclude, and decide first.
- A conflict means that another manager owns the field.

<!-- astrona:playground:destroy -->
