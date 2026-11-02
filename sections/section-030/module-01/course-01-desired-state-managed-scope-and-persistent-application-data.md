---
draft: true
exam_objectives:
- Desired State
---
# Desired State, Managed Scope And Persistent Application Data

Desired state is the configuration a managed system is intended to satisfy. Within a defined scope, it should describe enough information to reconstruct behaviorally equivalent operation. That can include resource definitions, artifact references, environment settings and relationships to supporting systems. It does not normally include every persistent business record or every transient detail of runtime execution.

Scope is important because no single declaration necessarily describes an entire organization. A team may manage one application's workloads while another manages databases and identity. The application's desired state can reference those capabilities through supported contracts. Reconstruction then depends on those references being available and correctly interpreted. The declaration is sufficient within its management boundary, not an unexplained promise to recreate every external dependency.

Consider a service that uses a managed database. Its configuration identifies the image, replica policy and database connection reference. The database's customer records change as users perform work. Returning the application configuration to an earlier version does not return those records to an earlier moment. Data backup, recovery and migration are separate responsibilities with their own safety constraints.

Artifact identity contributes to desired-state precision. A declaration using a content-identified artifact describes a more stable input than a moving tag. Configuration that depends on a mutable chart version or external default can change behavior without a visible commit. Reproducibility therefore involves the complete input chain, not only the final document's filename.

Secret values require a related distinction. Desired state can describe how a workload obtains a secret without publishing the secret itself. An approved secret controller or external store can provide the value. The reference and delivery policy can be versioned, while confidential contents follow their own access and rotation process. A configuration repository should not become a plaintext credential archive merely to appear complete.

Observed fields are not automatically desired fields. A controller can report status, timestamps and assigned identifiers. Those values describe implementation results and can change during normal operation. Copying them into authoritative input can create meaningless drift or constrain the system incorrectly. The management contract should define which fields are intent, which are defaults and which are observation.

Behavioral reconstruction is stronger than textual similarity. Two systems can use different transient Pod identifiers while satisfying the same workload configuration. Conversely, identical-looking manifests can resolve different mutable artifact content. Useful reasoning therefore asks which properties affect intended behavior rather than demanding that every runtime byte or timestamp match a historical snapshot.

Desired state can also include policy about lifecycle. A resource may be retained or removed when no longer declared, depending on ownership and safety requirements. Deletion is not always an incidental cleanup operation, especially for persistent infrastructure. The author should know whether an omitted declaration triggers removal, leaves an orphan or requires separate approval under the selected controller contract.

A review of desired state should identify the managed resources, external assumptions and data boundaries. It should explain what can be recreated and what requires separate recovery. That clarity supports both normal delivery and incident response because operators can distinguish configuration convergence from restoration of business information.

## Common pitfalls

> [!WARNING]
> Desired configuration is not a complete backup of business data. Separate intent from generated status and identify external dependencies. Reverting text cannot guarantee restoration of records, secret contents or every side effect produced by an earlier release.
