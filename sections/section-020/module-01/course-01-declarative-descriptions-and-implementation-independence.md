---
draft: true
exam_objectives:
- Declarative Description
---
# Declarative Descriptions And Implementation Independence

A declarative description states the operating condition a system should have. It separates the desired result from the implementation that reaches that result. For example, declaring a service with three replicas expresses an intended condition. Listing commands that create a service and then increment a count expresses a procedure. Both can use text files, so file format alone does not determine the distinction.

The implementing agent still performs actions. It reads the declaration, compares relevant conditions and invokes supported APIs or procedures. Declarative management does not mean that no imperative work exists anywhere. It means the authoritative input describes the result while the implementation chooses appropriate steps under its contracts and policy.

Consider a database claim requesting a supported capacity class and backup policy. The description can remain stable even if the provider changes which API calls create the database. That independence lets users express intent without knowing every implementation detail. It also requires a clear schema so the agent can interpret the requested class and report unsupported choices.

A description needs sufficient scope. An application declaration that identifies its image but omits critical configuration may not recreate the intended behavior. Some defaults can be deliberate and stable; other defaults can depend on a mutable environment or provider release. Authors should distinguish an explicit input from an assumption supplied elsewhere. Otherwise the same visible document can produce different systems.

Stable references matter because declarations commonly depend on artifacts. A moving image tag or unpinned package source can change content without a new configuration version. The description remains textually identical while the runtime changes. Identifying content or recording the relevant input version strengthens reproducibility, though it does not prove the selected artifact is safe or compatible.

Declarative descriptions can also include relationships. A workload may refer to a secret, network or storage claim. Those referenced objects have their own lifecycle and authority. The declaration should identify the intended relationship without embedding confidential values unnecessarily. A reference to a secret is not proof that the secret exists or that its value grants the desired external permission.

Validation operates at several levels. Syntax establishes that the document can be parsed. Schema validation establishes recognized fields and shapes. Policy can restrict choices such as approved images or capacity limits. Runtime implementation determines whether the target can satisfy the request. A valid declaration can still be impossible to realize because the environment lacks capacity or an external service denies access.

Changes should be evaluated by their intended state difference. A review can ask which resource, field or relationship changes and what that means operationally. This is more informative than reviewing a script whose effect depends on a reader's current shell state. Declarative review still needs domain knowledge; a clearly stated unsafe condition is not made safe by being easy to diff.

The authoritative description should avoid unexplained generated values. Rendering tools can translate higher-level input into concrete resources, but those transformations are part of the input chain. The team needs to know which values and versions produced the result. Reproducing that chain is different from merely retaining the final file after one successful render.

## Common pitfalls

> [!WARNING]
> Declarative syntax does not guarantee sufficient state, immutable inputs or safe policy. The agent still performs actions, and referenced dependencies retain their own contracts. Review hidden defaults and mutable references before claiming that a description recreates the same behavior.
