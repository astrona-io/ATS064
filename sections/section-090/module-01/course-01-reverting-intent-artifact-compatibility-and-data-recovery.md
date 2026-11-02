---
draft: true
exam_objectives:
- Rollback
---
# Reverting Intent, Artifact Compatibility And Data Recovery

Rollback is a recovery action that returns selected behavior toward an earlier acceptable condition. In a GitOps system, configuration rollback normally changes authoritative desired state to a chosen earlier or corrective version. The management agent then evaluates that intent and acts through its normal contracts. This preserves a record of the recovery decision rather than relying solely on an unexplained target edit.

A source revert and a runtime rollback are related but distinct. A revert creates a new version that reverses selected configuration changes. A target-specific rollback can alter live resources directly. If authoritative desired state still asks for the newer version, an active agent can restore it. Recovery must therefore account for the source of intent and the current management policy.

Consider a service whose new release causes an error spike. Reverting its image reference can select the previous artifact. That artifact must still be available and compatible with the current configuration. If the previous image was referenced only by a moving tag, the historical name may no longer identify the original content. Artifact retention and identity are part of the rollback contract.

Persistent data is the major boundary. A release may apply a database migration or write records in a new format. Returning to earlier application code does not automatically reverse those changes. The earlier code may be unable to interpret the current schema. A recovery plan should distinguish application selection, schema compatibility and data restoration rather than treating version control as a complete backup.

External side effects can also be irreversible. A release may send messages, charge accounts or provision resources. Reverting configuration does not unsend those messages or erase completed transactions. Compensating actions may be needed under the business contract. Students should understand that rollback can reduce further harm without recreating a world in which the faulty release never ran.

Secrets and identities add another constraint. An older configuration can reference a credential that has been rotated or revoked. Restoring the reference does not restore its former external authority. Recovery should preserve current security requirements instead of reintroducing a compromised credential simply because it was present in a successful historical version.

Deletion policy matters during recovery. A revert can remove declarations added by the failed change. If pruning is enabled, that can remove managed resources with important state. The intended retention and ownership policy should be reviewed before assuming that a revert affects only application code. Persistent resources deserve especially clear lifecycle treatment.

A forward correction can be safer than returning to an incompatible earlier version. The decision depends on the failure, available artifacts, current data and time pressure. GitOps supports recording either intent, but it does not choose the business recovery strategy automatically. The team should identify why the selected version is suitable under current conditions.

After selection, observe convergence and relevant health. A source commit proves that recovery intent was recorded. An agent status can prove that resources were updated. User-facing indicators and dependency evidence establish whether the recovery achieved its purpose. A green source history alone cannot prove the application is healthy.

## Common pitfalls

> [!WARNING]
> Rollback is not a universal undo. Preserve artifact identity and assess data, schema, secrets and external side effects. Target-only changes can be overwritten by unchanged authoritative intent, and historical success does not guarantee present compatibility.
