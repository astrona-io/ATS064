---
draft: true
exam_objectives:
- Feedback Loop
---
# Outcome Feedback, Health And Control Decisions

Feedback closes the management loop by describing the result of an attempted change. An agent can observe whether target resources match intent, whether a dependency is blocked and whether another action is appropriate. Human operators use related evidence to decide when intervention is needed. The value of feedback depends on its meaning, freshness and connection to an identified desired version.

Several outcomes must be distinguished. A source revision can be fetched successfully. Its declarations can render successfully. The target API can accept the resulting resources. Those resources can become ready. The application can then satisfy its user-facing service expectations. Each outcome is useful, but success at one boundary does not automatically establish the next.

Consider a workload whose new configuration references an unavailable secret. The agent may apply the workload successfully because the API accepts the reference. The runtime can still fail to start. Reporting only apply success conceals the operational result. Reporting the missing dependency gives an operator a concrete contract to repair without claiming that the configuration file itself could not be parsed.

Feedback also supports control decisions. A progressive delivery controller can pause or abort based on observed measurements under its configured policy. A reconciliation agent can retry a temporary error or report a persistent invalid input. The decision needs an appropriate signal population and freshness. A stale metric or empty result should not be silently interpreted as a healthy application.

Status should identify what was evaluated. A source branch can move while the target still reports an earlier revision. Without revision identity, an operator can mistake old success for new convergence. Timestamps and conditions can help explain freshness, but their meaning should be explicit. A process heartbeat is not the same as a recent successful reconciliation.

Errors should be actionable at the correct boundary. A denied target operation points to permission or policy. A rendering failure points to inputs or tool compatibility. A scheduling failure can point to capacity or placement. Collapsing these into a generic failed label forces operators to guess. Useful diagnostics name the operation and condition while avoiding disclosure of secrets.

Feedback can have its own delivery failures. Notifications may fail, dashboards may query the wrong labels and status updates can be delayed. The management action may have succeeded while its alert path failed. Conversely, a delivered notification can report a failed action. Students should separate the outcome being described from the channel used to describe it.

Observability needs to avoid circular assumptions. A management service that reports only through the application it is trying to repair may lose visibility during that application's outage. Independent internal diagnostics or suitable external observation can help preserve evidence. This does not mean every signal must be duplicated everywhere, but critical failure reporting should have an understood dependency path.

Human feedback is also part of improvement. Repeated blocked changes can reveal unclear platform contracts or unsuitable defaults. A team can use those findings to refine declarations, policy and user guidance. That is different from automatically changing desired state whenever a single metric fluctuates; control decisions still need explicit policy and ownership.

A useful explanation connects one intended version to its actual outcomes and remaining uncertainty. It can say that resources were accepted but readiness is blocked by a missing dependency. That measured statement is more informative than a universal green label and gives students a defensible basis for the next action.

## Common pitfalls

> [!WARNING]
> Apply success, readiness and user-facing health are distinct outcomes. Check feedback freshness and evaluated revision. Notifications can fail independently, and empty or stale measurements must not be invented into proof of healthy operation.
