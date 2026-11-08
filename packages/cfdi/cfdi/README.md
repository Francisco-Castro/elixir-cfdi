# cfdi (Calmecalli fork)

The `cfdi` package of [MisaelMa/elixir-cfdi](https://github.com/MisaelMa/elixir-cfdi) with one fix (the tax order
inside a concept) and packaging that lets it be used as a git dependency with `subdir: "packages/cfdi/cfdi"`.
Why, how it was checked and how to update it: [FORK_PROVENANCE.md](FORK_PROVENANCE.md).

Tests: `mix deps.get && mix test` in this directory (some tests read `../../files` of the monorepo checkout).
