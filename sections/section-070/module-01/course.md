---
draft: true
exam_objectives:
  - State Store
---
# The State Store And Its History

This module explains why a Git repository works as the state store of a GitOps setup, what its history gives you, and how to find and mark a known good revision. You search the history for the commit that introduced a change, mark the revision before it, and bring the cluster to that revision without rewriting anything.

## Learning Goals

- Explain what a state store must provide: versioning, immutability and an audit trail.
- Read a commit history to find who changed what, when and why.
- Find the commit that introduced a change with `git log -S`.
- Mark a revision with an annotated tag and apply that revision to a cluster.

## Before You Start

You should know `git add`, `git commit` and `git log`, and what a Deployment manifest looks like. The hands-on part uses a playground with a kind cluster, `kubectl`, `git` and `jq`. Technical terms are defined where they first appear.

## Reading Order

1. The State Store And Its History
2. Finding And Marking A Revision
3. Summary

<!-- astrona:playground -->
