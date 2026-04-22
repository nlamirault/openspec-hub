# CRD script format reference

Each file in `crds/` is a Bash script that describes how to download and process the CRDs for one application. The `scripts/schema-store.sh` driver sources these scripts and uses the variables and functions they define.

---

## Required variables

### `choice`

Controls how CRDs are downloaded.

| Value        | Meaning                                                                     |
| ------------ | --------------------------------------------------------------------------- |
| `individual` | Each CRD is a separate YAML file fetched individually                       |
| `bundle`     | All CRDs are in a single concatenated YAML file, split with `kubectl slice` |
| `kustomize`  | CRDs are assembled from a kustomize URL, then split with `kubectl slice`    |
| `swagger`    | CRDs are derived from a Swagger/OpenAPI 2.0 spec                            |

```bash
export choice=individual
```

### `FILES`

Array of YAML filenames.

- For `individual`: the upstream filenames to download.
- For `bundle` and `kustomize`: the filenames that `kubectl slice` produces from the bundle.
- For `swagger`: not used (leave empty or omit).

```bash
export FILES=(
  "myoperator.io_foos.yaml"
  "myoperator.io_bars.yaml"
)
```

### `VERSION`

The upstream version tag to fetch. Must be preceded by a Renovate comment so that automated version bump PRs are generated.

```bash
# renovate: datasource=github-tags depName=org/repo
export VERSION=1.2.3
```

The version string is used verbatim inside `generate_url`. Some upstreams prefix tags with `v`; others do not. Match the upstream convention in your `generate_url` implementation.

---

## Required function

### `generate_url`

Returns the URL from which to download the CRD content. The argument and return value depend on the `choice` mode.

#### For `individual` mode

Receives the filename and returns the full URL for that file:

```bash
function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/org/repo/v${VERSION}/config/crd/bases/${crd_file}"
}
```

#### For `bundle` mode

Receives no arguments and returns the URL of the bundle file:

```bash
function generate_url {
  echo "https://raw.githubusercontent.com/org/repo/v${VERSION}/deploy/crds/bundle.yaml"
}
```

#### For `kustomize` mode

Receives no arguments and returns the kustomize-compatible URL:

```bash
function generate_url {
  echo "https://github.com/org/repo//config/crd?ref=v${VERSION}"
}
```

#### For `swagger` mode

Receives no arguments and returns the path to the Swagger spec file (local or remote):

```bash
function generate_url {
  echo "https://raw.githubusercontent.com/org/repo/v${VERSION}/api/swagger.json"
}
```

---

## Full example

```bash
#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

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

---

## Naming convention

Script filenames use kebab-case and match the project name (not the API group):

| Script                | Project            |
| --------------------- | ------------------ |
| `argo-cd.sh`          | Argo CD            |
| `external-secrets.sh` | External Secrets   |
| `cloudnative-pg.sh`   | CloudnativePG      |
| `ack-ec2.sh`          | ACK EC2 controller |

When a vendor has multiple controllers (e.g., ACK), prefix each with the vendor abbreviation: `ack-ec2.sh`, `ack-rds.sh`, etc.
