---
draft: true
exam_objectives:
  - Desired State
---
# Desired State In Version Control

This module explains what the desired state is, what belongs in it and what does not, and why the version control system that holds it must keep it versioned and immutable. You export a live object, find the fields the cluster generated, and clean them out of the file that Git stores.

## Learning Goals

- Distinguish the desired state in Git from the observed state in the cluster.
- Recognize fields that the system generates and that must not be stored as desired state.
- Explain what versioned and immutable mean for a state store, and why GitOps needs both.
- Check that the repository covers every object the cluster should run.

## Before You Start

You should know what a Deployment, a Service and a ConfigMap are, and basic `git` commands. The hands-on part uses a playground with a kind cluster, `kubectl`, `git` and `jq`. Technical terms are defined where they first appear.

## Reading Order

1. What Belongs In The Desired State
2. Versioned, Immutable And Complete
3. Summary

<!-- astrona:playground -->
