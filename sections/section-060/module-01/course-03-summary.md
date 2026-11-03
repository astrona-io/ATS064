---
draft: true
exam_objectives:
  - Managed System
---
# Summary

A GitOps setup has three parts: the state store, the agent and the managed system. The store holds the desired state, and the agent is the only part that reads the store and writes to the managed system. The managed system is the set of cluster objects, with the workloads they run, that the agent is responsible for. Its scope must be written down, and it separates the objects that the agent owns from those that another system owns and from those that the cluster owns. Scope can follow a namespace, a cluster or an environment. The bootstrap objects that give the agent its access are applied by an administrator, apart from the objects that the agent applies.

An agent in Kubernetes has an identity, a ServiceAccount, and permissions through a Role and a RoleBinding. A new ServiceAccount has no permissions. Least privilege means giving only what the job needs: specific verbs and resources, no wildcards, no access to Secrets or to its own Roles. `kubectl auth can-i --as=system:serviceaccount:<namespace>:<name>` tests both what the agent may and may not do, and the exit status is 0 for yes and 1 for no. A pull-based agent keeps its cluster token inside the cluster.

- Name the three parts and the scope of the managed system.
- Bootstrap the agent identity apart from what the agent applies.
- Test the denials as well as the permissions.

<!-- astrona:playground:destroy -->
