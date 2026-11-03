# Prerequisites

- The `astrona` command-line tool, installed and working (`astrona check` passes).
- A container engine that kind can use (Podman or Docker) with about 2 GiB of free memory.
- `kubectl`, `git` and `jq` on your machine.
- You can read a Deployment manifest and run basic `git` commands (`status`, `add`, `commit`, `log`).

The lab starts a single-node kind cluster (Kubernetes 1.35) and creates a local Git repository in `~/gitops-lab/lab-060`. The repository is the state store: its `apps` directory holds the desired state of the cluster.
