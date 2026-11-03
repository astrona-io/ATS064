# Continuous Operation And Missed Events - Playground

- **Slug:** ats-064-playground-010-01
- **Type:** Astrona playground: clean environment, no task, no grading
- **Status:** built untested (never booted by the author)

A single-node kind cluster (Kubernetes 1.35) with the starfleet workloads, and a Git repository whose latest commit is not applied to the cluster yet.

## Run it

```sh
astrona run -c .
astrona destroy ats-064-playground-010-01
```

`astrona destroy` takes the environment name (`metadata.name`), not the config path.

## Layout

| Path | Purpose |
| --- | --- |
| `config.yaml` | Environment definition |
| `bootstrap/01-seed.sh` | Creates the Git repository `~/gitops-lab/play-010` and applies its first revision |
| `docs/overview.md` | What the environment contains and ideas to try |
