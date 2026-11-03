# The Feedback Loop - Playground

- **Slug:** ats-064-playground-080-01
- **Type:** Astrona playground: clean environment, no task, no grading
- **Status:** built untested (never booted by the author)

A single-node kind cluster with the starfleet workloads and a Git repository that holds them.

## Run it

```sh
astrona run -c .
astrona destroy ats-064-playground-080-01
```

`astrona destroy` takes the environment name (`metadata.name`), not the config path.

## Layout

| Path | Purpose |
| --- | --- |
| `config.yaml` | Environment definition |
| `bootstrap/01-seed.sh` | Creates the Git repository `~/gitops-lab/play-080` and applies its first revision |
| `docs/overview.md` | What the environment contains and ideas to try |
