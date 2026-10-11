---
draft: true
exam_objectives:
- Rollback
---
# Summary

GitOps rollback changes authoritative intent to a selected earlier or corrective version and lets management converge under current policy. It is not a universal undo operation. Artifacts, schema migrations, secrets and external side effects can make earlier configuration incompatible with current state. Recovery therefore separates configuration, runtime and business-data responsibilities. The selected version and resulting health need evidence rather than an assumption that historical success guarantees present safety.
