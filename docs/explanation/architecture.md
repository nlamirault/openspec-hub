# Architecture of OpenSpec Hub

This document explains _why_ OpenSpec Hub is structured the way it is — the goals, tradeoffs, and decisions behind the project. Read this when you want to understand the system, not when you need to perform a specific task.

---

## The problem: CRD schemas are not discoverable

Kubernetes Custom Resource Definitions embed a JSON Schema (via `openAPIV3Schema`) that `kubectl` and `kube-apiserver` use for server-side validation. That schema is accurate and maintained by each operator's authors.

However, IDEs and YAML editors cannot use CRD schemas directly. They need standalone JSON Schema files served from a known location. Without this, writing a Prometheus `ServiceMonitor` or an ArgoCD `Application` gives you no autocomplete and no validation — even though the schema exists in the cluster.

Several community schema stores (like `datreeio/CRDs-catalog` and `yannh/kubernetes-json-schema`) exist, but they are often incomplete, outdated, or do not cover the operators a given team uses.

OpenSpec Hub fills this gap for a specific, curated set of cloud-native operators.

---

## Design goals

1. **Accuracy**: schemas are extracted directly from upstream CRD manifests, not hand-written or inferred. If the upstream CRD changes, rebuilding the schema produces the correct output.

2. **Freshness**: each `crds/*.sh` script carries a Renovate comment on the `VERSION` line. Renovate opens automated PRs when upstream versions change, keeping schemas up to date with minimal manual effort.

3. **Simplicity**: the pipeline is intentionally thin — Bash scripts download CRDs, `yq` extracts the embedded schema, the result is written as a file. No database, no build server, no complex toolchain.

4. **Discoverability**: schemas follow a predictable URL pattern, making them easy to reference in editor configs or validation tools without consulting any index.

---

## Schema organization

```
schemas/
└── {api-group}/
    └── {kind}_{version}.json
```

The API group comes from `.spec.group` in the CRD. The kind and version come from `.spec.names.kind` and `.spec.versions[0].name`. All values are normalized to lowercase.

This mirrors the Kubernetes API structure. Given any Kubernetes resource (`apiVersion: argoproj.io/v1alpha1`, `kind: Application`), you can derive the schema path: `schemas/argoproj.io/application_v1alpha1.json`.

---

## The processing pipeline

```
crds/{app}.sh          →  defines VERSION, FILES, generate_url()
        │
        ▼
scripts/schema-store.sh
        │
        ├── curl/kustomize  →  downloads raw CRD YAML
        │
        ├── kubectl slice   →  splits bundle files into individual CRDs
        │
        └── yq              →  extracts .spec.versions[].schema.openAPIV3Schema
                                writes to schemas/{api-group}/{kind}_{version}.json
```

The separation between the driver (`schema-store.sh`) and the app-specific scripts (`crds/*.sh`) means adding a new operator requires writing only the app-specific logic — the download, split, and extraction steps are handled by the driver.

---

## The web application

The project includes an Astro-based web application that serves as a browsable catalog of all available schemas. It is built as a static site and deployed to Cloudflare Workers.

The catalog is a generated artifact (`public/data/catalog.json`) produced by `scripts/generate-catalog.py`, which walks the `schemas/` directory. The web app is a consumer of the schemas, not part of the schema generation pipeline.

---

## What OpenSpec Hub does not do

- **Serve schemas from a custom domain**: schemas are accessed directly from GitHub raw content. No custom hosting is required.
- **Validate clusters**: OpenSpec Hub produces schemas for editor and CI validation. It does not connect to a Kubernetes cluster.
- **Generate CRDs**: schemas are extracted from existing upstream CRDs. OpenSpec Hub does not author or modify them.
- **Cover all operators**: the project is curated. If an operator is not listed, it has not been added yet — see [How to add a new CRD](../how-to/howto-add-crd.md).

---

## Further reading

- [Schema extraction](schema-extraction.md) — how the `openAPIV3Schema` extraction works in detail
- [CRD script format reference](../reference/crd-scripts.md) — the contract between app scripts and the driver
