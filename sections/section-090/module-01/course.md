---
draft: true
exam_objectives:
  - Rollback
---
# Rollback

This module explains how a GitOps setup undoes a bad change. A rollback is a new commit that reverses an earlier one, and the agent applies it like any other change. You revert one or several commits, keep the good commits between them, and check that data which never lived in Git survives.

## Learning Goals

- Explain why a rollback in GitOps is a commit and not a command on the cluster.
- Use `git revert` to undo one or several commits without rewriting history.
- Keep good changes that sit between the bad ones.
- Name what a rollback cannot undo, such as data and deleted objects.

## Before You Start

You should know `git log`, `git commit` and how to apply manifests with `kubectl`. The hands-on part uses a playground with a kind cluster, `kubectl`, `git` and `jq`. Technical terms are defined where they first appear.

## Reading Order

1. Why Rollback Is A Commit
2. Reverting Safely
3. Summary

<!-- astrona:playground -->
