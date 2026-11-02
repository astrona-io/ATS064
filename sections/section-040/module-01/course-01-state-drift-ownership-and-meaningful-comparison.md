---
draft: true
exam_objectives:
- State Drift
---
# State Drift, Ownership And Meaningful Comparison

State drift is divergence between desired and actual managed conditions. It can arise from manual changes, another controller, an external system or a failed partial operation. An intentional update to authoritative desired state also creates a temporary difference until the target converges. The management process needs to distinguish the intended transition from unexplained change, even though both involve comparison.

Comparison scope determines what counts as meaningful divergence. Managed fields can express authoritative intent, while generated status and runtime identifiers describe observations. Defaults and admission mutations can also affect the live representation. A naive byte-for-byte comparison of every field can report endless noise even when the intended behavior is satisfied. A comparison that ignores too much can miss important changes.

Consider a Deployment whose replica field is managed by an autoscaler. If another GitOps controller repeatedly writes a fixed count to that same field, the two authorities can fight. The result is not a lack of reconciliation frequency but an ownership conflict. A deliberate contract can assign the autoscaled field to the autoscaler while retaining GitOps ownership of the appropriate configuration.

Ignoring a field is a policy choice. It can prevent noise from an expected external writer, but it removes that difference from the agent's assessment. An ignore rule should name the reason and scope. Broadly ignoring an entire resource because one generated value changes can conceal unauthorized image, permission or network-policy modifications.

Drift does not explain its own cause. A changed image reference can be a deliberate emergency intervention or an unauthorized action. A missing resource can result from a human deletion or a failing dependency. The drift report supplies evidence of a state difference, while audit and operational context help determine why it happened. Students should avoid treating detection as a complete incident conclusion.

Correction also depends on policy. Some agents can automatically restore managed fields, while others require a permitted synchronization action. A system can detect divergence and still leave it unchanged because reconciliation is suspended or authority is missing. The words monitored and corrected should therefore refer to different observed behaviors.

Emergency changes need follow-up. An operator may alter actual state to mitigate an incident, but an active reconciler can overwrite that edit if desired state remains unchanged. The team needs a controlled way to update intent, suspend the relevant behavior or explicitly delegate ownership during the intervention. Afterward, the approved state and ongoing management policy should be reconciled deliberately.

Persistent data creates another boundary. A database's changing records are not usually drift from a deployment's desired configuration. Treating every customer transaction as configuration divergence would misunderstand the management scope. The same system can have stable infrastructure configuration and changing business data without inconsistency.

Useful evidence includes the evaluated desired revision, compared fields, actual values and correction result. A status showing an old revision can make an apparent difference harder to interpret. A healthy process alone does not prove it compared the latest intended state. The diagnosis should identify the version and scope before deciding whether the report represents real drift, expected mutation or stale observation.

## Common pitfalls

> [!WARNING]
> Drift detection is not cause analysis or guaranteed correction. Avoid broad ignore rules and conflicting writers. Emergency target edits can be overwritten unless the authoritative intent or management policy is updated through a controlled process.
