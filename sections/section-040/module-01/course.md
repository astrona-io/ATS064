---
draft: true
exam_objectives:
  - Drift
---
# Configuration Drift

This module explains what drift is, where it comes from, how it is detected and what a team can do with it. You create drift on a real cluster, read the difference, and then choose between reverting the cluster and adopting the change into Git. You also see how field ownership decides which tool may change which field.

## Learning Goals

- Define drift and name its common sources.
- Detect drift by comparing the desired state with the live state.
- Choose between reverting, adopting and excluding a drifted field.
- Explain field ownership and what server-side apply does with a conflict.

## Before You Start

You should know what a Deployment is, how `kubectl apply` compares a manifest with a live object, and basic `git` commands. The hands-on part uses a playground with a kind cluster, `kubectl`, `git` and `jq`. Technical terms are defined where they first appear.

## Reading Order

1. What Drift Is And How To Detect It
2. Reverting, Adopting And Field Ownership
3. Summary

<!-- astrona:playground -->
