---
draft: true
exam_objectives:
  - Desired State
---
# Summary

The desired state is the set of objects and values that people declare. The observed state is what the cluster reports. A Kubernetes object holds both: the spec is declared, while the uid, creation timestamp, resource version, generation, managed fields, allocated addresses and the status block are written by the system. A field belongs in Git if a person decides it. Exporting an object with `kubectl get -o yaml` and committing it stores the history of one object, so the generated fields must be removed.

The state store must be versioned, immutable and complete. Versioned means each change is a new version and earlier ones remain, which Git does with commits. Immutable means a version never changes, because a commit hash is computed from the content and the parent, so a hash is a fixed reference. A branch is a moving name, and rewriting shared history changes what a branch shows. Complete means every object that the cluster should run is described, apart from the objects that the system makes by itself. Secrets need an encrypted form or a reference, because immutable history keeps any plaintext value.

- Keep the fields people own, and delete the fields the system owns.
- A commit hash is fixed, and a branch name moves.
- An object that exists only in the cluster is hidden state.

<!-- astrona:playground:destroy -->
