# The State Store And Its History - Playground

- **Slug:** ats-064-playground-070-01
- **Type:** Astrona playground: clean environment, no task, no grading
- **Status:** built untested (never booted by the author)

A single-node kind cluster and a Git repository with four commits from three authors, applied at HEAD.

## Run it

```sh
astrona run -c .
astrona destroy ats-064-playground-070-01
```

`astrona destroy` takes the environment name (`metadata.name`), not the config path.

## Layout

| Path | Purpose |
| --- | --- |
| `config.yaml` | Environment definition |
| `bootstrap/01-seed.sh` | Creates the Git repository `~/gitops-lab/play-070` and applies its first revision |
| `docs/overview.md` | What the environment contains and ideas to try |
