---
draft: true
exam_objectives:
  - Feedback Loop
---
# The Feedback Loop

This module explains how information flows back from the cluster to the agent and to the people who own the delivery. You read the status that Kubernetes records on a Deployment, tell a delivery that succeeded from one that only started, and report the result together with the revision it belongs to.

## Learning Goals

- Explain why a GitOps setup needs feedback and what it should report.
- Read Deployment conditions, `observedGeneration` and replica counts to judge health.
- Use a progress deadline so that a stuck delivery turns into a visible failure.
- Report a sync result that names the revision it belongs to.

## Before You Start

You should know what a Deployment and a readiness probe are, and how to apply manifests with `kubectl`. The hands-on part uses a playground with a kind cluster, `kubectl`, `git` and `jq`. Technical terms are defined where they first appear.

## Reading Order

1. The Feedback Loop
2. Reporting Delivery Status
3. Summary

<!-- astrona:playground -->
