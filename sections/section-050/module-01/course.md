---
draft: true
exam_objectives:
  - Reconciliation
---
# Reconciliation

This module explains the loop that makes a cluster match its desired state: observe, compare, act, and repeat. You watch Kubernetes controllers correct a deleted pod, and then you see what happens when a delivery cannot succeed: an image that does not exist, a quota that blocks pods and a manifest that is not valid.

## Learning Goals

- Describe the reconciliation loop and why it is level-triggered and idempotent.
- Explain what converged means, and how it differs from applied.
- Classify failures of a reconciliation as rejected, blocked or unhealthy.
- Read the signals that show why a delivery has not converged, and fix the cause in Git.

## Before You Start

You should know what a Deployment, a ReplicaSet and a pod are, and how `kubectl apply` works. The hands-on part uses a playground with a kind cluster, `kubectl`, `git` and `jq`. Technical terms are defined where they first appear.

## Reading Order

1. The Reconciliation Loop
2. When Reconciliation Fails
3. Summary

<!-- astrona:playground -->
