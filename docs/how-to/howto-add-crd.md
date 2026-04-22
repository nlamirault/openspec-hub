# How to add a new CRD

Follow these steps to add schemas for a new Kubernetes operator or controller.

---

## Prerequisites

- `bash` shell
- `yq` (YAML processor)
- `curl`
- `kubectl` with the `slice` plugin (for bundle and kustomize modes)
- Python 3.8+ with `uv` (for regenerating the web catalog)

---

## Step 1 — Create a script in crds/

Create a new file `crds/{app-name}.sh`. The filename (without `.sh`) becomes the identifier you pass to `make build`.

Use one of three modes depending on how the upstream project publishes its CRDs:

### `individual` — one file per CRD

Use when each CRD is a separate YAML file in the upstream repository.

```bash
#!/usr/bin/env bash

export choice=individual
export FILES=(
  "myoperator.io_foos.yaml"
  "myoperator.io_bars.yaml"
)

# renovate: datasource=github-tags depName=myorg/myoperator
export VERSION=1.2.3

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/myorg/myoperator/v${VERSION}/config/crd/bases/${crd_file}"
}
```

### `bundle` — all CRDs in a single file

Use when the upstream project ships a single YAML file containing all CRDs concatenated with `---` separators.

```bash
#!/usr/bin/env bash

export choice=bundle
export FILES=(
  "foos.myoperator.io.yaml"
  "bars.myoperator.io.yaml"
)

# renovate: datasource=github-tags depName=myorg/myoperator
export VERSION=1.2.3

function generate_url {
  echo "https://raw.githubusercontent.com/myorg/myoperator/v${VERSION}/deploy/crds/bundle.yaml"
}
```

The `FILES` array must list the individual filenames that `kubectl slice` will produce from the bundle.

### `kustomize` — CRDs assembled via Kustomize

Use when the upstream project provides a kustomize overlay that builds the CRDs.

```bash
#!/usr/bin/env bash

export choice=kustomize
export FILES=(
  "foos.myoperator.io.yaml"
)

# renovate: datasource=github-tags depName=myorg/myoperator
export VERSION=1.2.3

function generate_url {
  echo "https://github.com/myorg/myoperator//config/crd?ref=v${VERSION}"
}
```

---

## Step 2 — Build the schemas

```bash
make build CRD=crds/my-operator.sh
```

The script will:
1. Download the CRD YAML files from the upstream URL.
2. Extract the `openAPIV3Schema` from each CRD.
3. Write JSON Schema files to `schemas/{api-group}/{kind}_{version}.json`.

Check the output directory to confirm schemas were generated:

```bash
ls schemas/myoperator.io/
```

---

## Step 3 — Verify a generated schema

Inspect one of the generated schemas to confirm it is valid JSON and contains the expected fields:

```bash
cat schemas/myoperator.io/foo_v1alpha1.json | python3 -m json.tool | head -30
```

---

## Step 4 — Regenerate the web catalog

The web application reads from `public/data/catalog.json`. Regenerate it after adding new schemas:

```bash
make catalog
```

---

## Step 5 — Submit a pull request

1. Commit the new script and the generated schemas.
2. Open a pull request with a description of the operator and a link to its upstream repository.

The `VERSION` line must include the Renovate comment so that version bumps are automated:

```bash
# renovate: datasource=github-tags depName=org/repo
export VERSION=x.y.z
```

---

## Naming conventions

- Script filename: `crds/{app-name}.sh` — use kebab-case, e.g. `argo-rollouts.sh`, `cloudnative-pg.sh`
- The script name should match the project name, not the API group

See the [CRD script format reference](../reference/crd-scripts.md) for the full variable and function specification.
