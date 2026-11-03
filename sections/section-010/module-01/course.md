---
draft: true
exam_objectives:
  - Continuous
---
# Continuous Operation And Missed Events

This module explains what the word continuous means in GitOps. A one-time delivery job applies a revision once. A continuous agent returns to the same comparison again and again, and recovers when a change notification is lost. You build a small reconciliation loop on a real cluster to see both behaviors.

## Learning Goals

- Explain continuous reconciliation without claiming instantaneous execution.
- Distinguish repeated control behavior from a one-time deployment job.
- Reason about polling intervals, events, missed events, retries and convergence time.
- Run `kubectl diff` and `kubectl apply` against a Git repository and use them as one reconciliation pass.

## Before You Start

You should know what a pod, a Deployment and a namespace are, and basic `git` commands. The hands-on part uses a playground with a kind cluster, `kubectl`, `git` and `jq`. Technical terms are defined where they first appear.

## Reading Order

1. One-Time Delivery Versus A Continuous Agent
2. Intervals, Events And Missed Events
3. Summary

<!-- astrona:playground -->
