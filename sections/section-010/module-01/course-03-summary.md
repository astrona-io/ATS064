---
draft: true
exam_objectives:
  - Continuous
---
# Summary

Continuous operation means that a GitOps agent returns to the same work again and again without a new trigger. Each pass reads the desired state, observes the actual state, compares the two and acts only when they differ. A one-time delivery job runs when an event happens and then ends, so it cannot notice a change made to the cluster afterwards.

Continuous does not mean instant. The time between a change and a matching cluster is the sum of the wait until the agent notices, the fetch, the apply and the cluster's own work. The polling interval controls only the first wait. A short interval finds changes sooner and adds read load on the Git source and the cluster API.

Events such as webhooks shorten the wait, but they are only signals to look. An event can be lost, delayed or sent twice. The agent stays correct because it can read the desired state itself on every timer pass, so a missed event delays a change and never loses it.

Repetition is safe when each pass is idempotent, when the agent has permission to change what it manages and when each managed field has one owner. A failed pass is recorded and retried later with a growing delay.

- Continuous means repeated comparison, not a faster pipeline.
- The interval, the fetch, the apply and the cluster's work make up the convergence time.
- A timer recovers from missed events; an event only speeds up the next pass.

<!-- astrona:playground:destroy -->
