---
draft: true
exam_objectives:
- State Store
---
# State Store Identity, History And Access Policy

A state store holds authoritative versions of desired declarations. Agents need to obtain those versions reliably, while reviewers and operators need to identify what changed and which version was evaluated. Git is a common state-store implementation because it provides version history and familiar review workflows. The essential contract is controlled, retrievable versioned intent rather than the presence of a particular hosting brand.

Version identity must be distinguished from selection. A Git commit identifies a specific tree and history relationship. A branch name points to a commit and can advance. A tag can also be mutable unless the surrounding policy prevents movement. An agent following a branch therefore needs to report the actual revision it obtained. The branch name alone is not evidence of which content reached a target.

Consider a production configuration branch that advances twice while an agent is recovering from an outage. An operator needs to know whether the target evaluated the first or second revision. A status naming only the branch is ambiguous. Recording the resolved revision connects declared intent with observed management results and supports meaningful rollback analysis.

Access policy controls who can propose and approve state changes. A repository may allow many contributors to open changes while limiting direct updates to an authoritative branch. Review, policy validation and protected references can support accountability. These controls are separate from the agent's target permissions. A source writer can influence the target through approved intent, but the system should not automatically give that person unrelated runtime credentials.

History supports audit and recovery only if it remains available and interpretable. Rewriting an authoritative history or deleting required artifacts can weaken those properties. The team should know which versions are retained and which external inputs they reference. An old configuration pointing at an unavailable image may remain readable while no longer being deployable.

Secrets have a separate contract. Storing a password in desired-state history preserves it across every clone and retained revision. Later deletion does not remove earlier copies. A better design versions references, encrypted representations under an approved key model or secret-delivery policy without treating public history as a confidential store. The chosen mechanism needs its own access and recovery reasoning.

Alternative stores can satisfy the relevant principles when they retain identified immutable versions and provide controlled retrieval. An artifact registry or another system can hold declarative bundles. Its reference semantics, retention and audit capabilities need review. A mutable file endpoint that always overwrites yesterday's content does not provide the same history contract merely because an agent can download it.

State-store availability affects management progress. An agent may retain a previously obtained version, but behavior during source failure depends on its implementation and policy. It should not invent a new desired version from an incomplete response. Source authentication failures also need visible evidence so operators can distinguish an unchanged system from an agent unable to observe updated intent.

A useful design records source identity, revision selection, resolved content and access roles. This gives students concrete questions to ask: can the agent retrieve intent after a missed event, can reviewers identify the evaluated version, and can unauthorized writers alter the managed system? Those questions reveal the state store's operational role.

## Common pitfalls

> [!WARNING]
> A mutable branch or tag is not immutable content identity. Preserve meaningful history and artifact availability, and keep credentials out of exposed revisions. State-store access should separate proposal, approval, writing and agent reading roles.
