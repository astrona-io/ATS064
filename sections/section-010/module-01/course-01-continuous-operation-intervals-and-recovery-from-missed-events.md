---
draft: true
exam_objectives:
- Continuous
---
# Continuous Operation, Intervals And Recovery From Missed Events

Continuous operation describes a responsibility that remains active over time. In GitOps, an agent repeatedly obtains intended state, observes the managed system and evaluates whether action is needed. The word continuous does not mean every observation and correction happens instantly. Network access, scheduling, work queues and the target system's response all create real intervals.

A one-time deployment job performs work at a selected moment. It may successfully apply a reviewed configuration and then stop. That is useful delivery automation, but it does not establish that later drift will be noticed. An ongoing management process returns to the same responsibility after the original release event has passed. This difference is central when deciding whether a system is continuously managed.

Consider a service whose desired replica count is three. A pipeline applies that count successfully. Later, an administrator changes the managed count manually. If no active agent revisits the declaration and target, the change can remain indefinitely. If an agent continues evaluating the relevant state, it can detect and handle the divergence according to its ownership and policy.

Intervals trade latency against load. Frequent evaluation can reduce the time before a change is noticed, while increasing work against state stores and target APIs. Longer intervals can reduce load while extending correction delay. Event notifications can accelerate evaluation when something changes. They should be treated as signals to examine state rather than as an irreplaceable complete history of that state.

Missed events demonstrate why recovery matters. A notification can be delayed, duplicated or lost during an outage. An agent with durable access to authoritative versions can return to evaluation after recovery. A design that knows desired state only from a transient pushed payload has a different recovery contract. The ability to obtain state independently supports repeated management rather than reliance on one delivery opportunity.

Repeated evaluation should remain safe. If the desired state has not changed and the target already satisfies it, the agent should avoid unnecessary destructive actions. Failed actions may need retries with bounded rate and useful diagnostics. Repeating a non-idempotent action without checking current conditions can create duplicate resources or side effects instead of convergence.

Continuous behavior also depends on authority and ownership. An agent can run every minute while lacking permission to modify its target. Two agents can continuously write incompatible desired values to the same field. In both cases, repetition alone does not establish useful management. The observed control process must have a coherent source and a defined responsibility.

Feedback provides evidence about progress. A status reporting the evaluated revision, last attempt and relevant error can help operators distinguish a delayed observation from a persistently blocked correction. A process being alive is weaker evidence than it successfully evaluating the intended revision. Likewise, a successful apply is narrower than a healthy running application.

Convergence time is the duration between relevant divergence and a supported outcome. It depends on observation delay, rendering, admission, target behavior and policy. Some changes cannot converge because capacity is absent or configuration is invalid. A continuous system should make those conditions visible rather than claim that running longer guarantees success.

## Common pitfalls

> [!WARNING]
> Continuous does not mean instantaneous or inevitably successful. A one-time deployment is not evidence of later drift management. Review missed-event recovery, ownership, authority and useful progress rather than judging the system only by an interval setting.
