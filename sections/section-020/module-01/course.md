---
draft: true
exam_objectives:
  - Declarative Description
---
# Declarative Descriptions And Implementation Independence

This module explains what a declarative description is and why GitOps requires one. You compare an imperative script with a manifest on a real cluster, and then look at what a declaration must contain to be complete: its scope, its stable references, its defaults and its dependencies.

## Learning Goals

- Distinguish a desired-state description from an imperative procedure.
- Explain why `kubectl apply` is safe to repeat and `kubectl create` is not.
- Identify the scope, references, hidden defaults and external dependencies that a complete declaration must state.
- Explain why a declaration does not depend on one implementation.

## Before You Start

You should know what a pod, a Deployment, a namespace and a ConfigMap are, and basic `git` commands. The hands-on part uses a playground with a kind cluster, `kubectl`, `git` and `jq`. Technical terms are defined where they first appear.

## Reading Order

1. Declarative Versus Imperative Descriptions
2. Scope, References, Defaults And Dependencies
3. Summary

<!-- astrona:playground -->
