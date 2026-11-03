---
draft: true
exam_objectives:
  - Declarative Description
---
# Summary

A declarative description states the result that must exist and leaves the sequence of steps to the system that applies it. A manifest names the objects and field values. An imperative procedure lists commands that depend on the state that earlier commands left behind.

Applying a manifest is idempotent: the tool compares the manifest with the live object and changes only what differs, so a second run reports no change. A create command fails when the object exists. A GitOps agent repeats its work, so it needs a description that can be applied again and again. A script stored in Git has a history, but it is still a procedure.

A declaration is independent of the tool that applies it, not of the platform that interprets it. It must also be complete. It states its scope, so the same file means the same thing on every machine. It uses stable references, and it names an image by a tag or a digest. It records the defaults it relies on, because the API server and the registry fill in values that the file does not mention. It declares or names its dependencies, such as a ConfigMap, because the API server accepts an object whose dependency is missing.

- A manifest states a result and a script states steps.
- `apply` repeats safely and `create` does not.
- Scope, references, defaults and dependencies decide whether a declaration means the same thing everywhere.

<!-- astrona:playground:destroy -->
