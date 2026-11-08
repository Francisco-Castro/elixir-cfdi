# Fork provenance — `cfdi` as Calmecalli consumes it

This directory is the `cfdi` package of [MisaelMa/elixir-cfdi](https://github.com/MisaelMa/elixir-cfdi), MIT, kept in
[Francisco-Castro/elixir-cfdi](https://github.com/Francisco-Castro/elixir-cfdi) on the branch `calmecalli/cfdi-4.0.8`.
Consumers pin a full commit SHA and this subdirectory:

```elixir
{:cfdi, git: "https://github.com/Francisco-Castro/elixir-cfdi.git", ref: "<full 40-character SHA>",
 subdir: "packages/cfdi/cfdi"}
```

## Base

- Upstream commit `d584e008fcb2ed59d02647f56a5d5308d39531e9`. Its `packages/cfdi/cfdi/lib` (16 files) is byte-identical
  to the Hex release `cfdi` 4.0.8 — tarball `cfdi-4.0.8.tar`, sha256
  `326c36e5fb4923f112b1975eb50a1de8c5ed9ef53762d5b4873b3fcd6d197803`. Manifest of those 16 files at the end.

## What this branch adds, one commit each

1. `bd0788b` — the fix: inside `cfdi:Concepto`, `Traslados` before `Retenciones` (`cfdv40.xsd`); the comprobante-level
   order unchanged. Regression in `test/cfdi_child_order_test.exs` (red on the base, green here). Offered upstream as
   PR #2. Only `lib/cfdi.ex` changes in `lib/`.
2. `0fb1315` — packaging: version `4.0.8+calmecalli.1`; no `build_path`, `deps_path` or `lockfile` (the project
   stands alone); `releaser` removed; the seven sibling packages from Hex with the requirements of Hex's 4.0.8 release
   (`~> 4.0`, `saxon_he ~> 12.5`) instead of `path:`; the MIT `LICENSE` copied here.
3. `ec9ae90` — a package-local `mix.lock` for this project's own tests (a consumer's lock decides what it runs): the
   graph Calmecalli's stories 2 and 3 tested, 12 packages byte-identical to the tarballs kept then, except `saxy`
   1.7.0 instead of 1.6.1 — 1.6.1 carries EEF-CVE-2026-66293, -66294 and -66295 (Saxy's encoder; this graph only
   parses with Saxy).
4. This file and the README (documentation only; the probes below ran on `ec9ae90`).

## Probes (2026-11-07, Elixir 1.18.4 / OTP 27.3.4, `hexpm/elixir:1.18.4-erlang-27.3.4-debian-bookworm-20250929-slim`
plus git, arm64, isolated containers; the eight of the fork research)

| Probe | Result |
|---|---|
| P1 base and delta | 16/16 library files equal Hex 4.0.8 at the base; the fix changes `lib/cfdi.ex` only; the compiled app reads `4.0.8+calmecalli.1` |
| P2 source selection | SHA + subdir: `cfdi` from git, the other 13 packages from Hex. The fix alone (sibling `path:`) takes 8 from the checkout, version 4.0.7. No subdir: refused («App cfdi lists itself as a dependency»). `sparse` + subdir fails to compile (not used) |
| P3 directories | as a dependency it compiles into the consumer's `_build`, nothing written into the checkout; standalone, `deps` and `_build` stay in this directory with this lock |
| P4 lock | a moved branch does not move a SHA pin, nor a branch pin with its lock (only `deps.update` does); a missing SHA fails («reference is not a tree»); `--check-locked` refuses a lock without `cfdi` and passes the full one |
| P5 an application's graph | Calmecalli's lock gains 12 entries and changes none; `--check-locked` passes |
| P6 compile and release | 124 tests offline; without the fix only «dentro de cfdi:Concepto, Traslados va antes que Retenciones» fails; a prod release carries `cfdi` and its 13 packages, `sat_xsd`'s `priv/` whole, and builds the concept-taxes CFDI in the fixed order |
| P7 recovery | fresh volume, no network: this branch from a git bundle (`url.insteadOf` maps the GitHub URL), packages from 13 archived tarballs **plus Hex's registry cache** (offline Hex refuses with tarballs alone: «the registry entry for package decimal is not cached locally»); a corrupted tarball is refused («doesn't match the registry checksum») |
| P8 an upstream update | upstream accepts the fix and releases 4.0.9 with another change in `cfdi.ex`: the packaging commits rebased on it, the fix drops out (no duplicate), one conflict on the version line → `4.0.9+calmecalli.1`, only `LICENSE`, `mix.exs`, `mix.lock` differ from upstream, 124 tests offline |

## Updating

Rebase the packaging commits on the new upstream; drop the fix once upstream carries it; version
`<upstream version>+calmecalli.<n>`; re-resolve the package-local lock deliberately (review its diff); rerun the probes
above that the change can affect; consumers move only by changing their pinned SHA.

## Base manifest (sha256 of Hex 4.0.8's `lib/`, equal to the base commit's)

```
35e09cb4e69607fd27f07a5e36c32649fe95748dba94b1d5432aa2231d2d29a3  lib/cfdi.ex
47a6cfc0b46549a33b0e6aaf93f4af7500fc9410cc9a21fa4a2385912b755d92  lib/cfdi/complemento.ex
e5100d7bfa482596210e013f50f9bf4571d398326140eb219151b3341e5379f4  lib/cfdi/comprobante.ex
cc6208c16a51912e4fa6006d145242159b7d4ec005dadeb7391f0854c9ac370e  lib/cfdi/concepto.ex
641dd11d5f8b9cc6fbc938e6117650033466ce54b2e7854202b7e69a9e0dbf6d  lib/cfdi/concepto/a_cuenta_terceros.ex
cb66741fd8ba4ecb21d1615994ee8ebc3c2d44cf171133c28f4b17320f2b97da  lib/cfdi/concepto/complemento.ex
bfdebc6087aad02f930ff67fdde552a7e0528d7e70cce5f071857e1078a33644  lib/cfdi/concepto/cuenta_predial.ex
9e82c526a21be9dbfa87ca054b77df1134923ee3154ce89649daf58e15a8eec2  lib/cfdi/concepto/informacion_aduanera.ex
e7b16164a78749982ae7e37156f159f838dd1c90e984945c7f1910194595baf1  lib/cfdi/concepto/parte.ex
6b9a575ae5a27cb7dc9918493abb42460185a4f3cf5ae26ac9919226871e8b89  lib/cfdi/decoder.ex
c8c0f09f08103506cfc024f5103a24eb378e5c63e82d2b098939f3cd6341ca02  lib/cfdi/emisor.ex
935c0d4c43213d4abb69240ba0627e9109127c3e17cc53bec8ee7199044bd7e2  lib/cfdi/impuestos.ex
c1817c6c21aca31e98247e00acb409b812ab88b71e141ad628b80895421cf428  lib/cfdi/informacion_global.ex
bba13213d093ef9b2036d7ba70d9e61d1919b1b30a3153eea0a83103b0b26066  lib/cfdi/receptor.ex
a64f33905745ff656b28ef9a07d002df3984b85fc22e79c65850468d6d005e67  lib/cfdi/relacionado.ex
47937d6569f946b995622c05d0d25fd1afa257db6b6fdc691c10cb65a6826188  lib/cfdi/relacionado/cfdi_relacionado.ex
```
