---
draft: true
exam_objectives:
  - Managed System
---
# The Managed System And The Agent

This module explains what a managed system is, where its boundaries lie, and what access the GitOps agent needs to change it. You create the identity of an agent, give it only the permissions it needs, and test those permissions from the command line.

## Learning Goals

- Name the parts of a GitOps setup: state store, agent and managed system.
- Define the scope of a managed system and the objects that fall outside it.
- Explain how an agent gets an identity and permissions in Kubernetes.
- Apply least privilege to an agent and test what it can and cannot do.

## Before You Start

You should know what a namespace, a Deployment and a ServiceAccount are, and how `kubectl apply` works. The hands-on part uses a playground with a kind cluster, `kubectl`, `git` and `jq`. Technical terms are defined where they first appear.

## Reading Order

1. What The Managed System Is
2. Agent Identity And Least Privilege
3. Summary

<!-- astrona:playground -->
