# Schema extraction

This document explains how Kubernetes CRDs are downloaded and converted into JSON Schema files. Read this when you want to understand the mechanics of the pipeline or diagnose an extraction problem.

---

## What is openAPIV3Schema?

Every Kubernetes CRD that uses structural schemas includes a validation section:

```yaml
spec:
  versions:
    - name: v1alpha1
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                # ... field definitions
```

This `openAPIV3Schema` block is a valid JSON Schema (draft 07 subset). It is what `kubectl apply --validate` and `kube-apiserver` use for server-side validation.

OpenSpec Hub extracts this block and writes it as a standalone JSON file.

---

## Extraction command

The extraction is performed by `yq`:

```bash
yq e '.spec.versions[].schema.openAPIV3Schema' "${crd_file}" -o=json > "${output_path}/${schema}"
```

This selects the first version's `openAPIV3Schema` and serializes it as JSON. If a CRD defines multiple versions, only the first version's schema is extracted.

---

## Output filename generation

The output path is derived from the CRD itself, not from the input filename:

```bash
group=$(yq e '.spec.group' "${crd_file}")
kind=$(yq e '.spec.names.kind' "${crd_file}")
version=$(yq e '.spec.versions[0].name' "${crd_file}")
# result: schemas/{group}/{kind}_{version}.json  (lowercased)
```

This ensures the output filename matches the Kubernetes API group, kind, and version — not whatever the upstream project chose to name its CRD YAML files.

---

## Download modes

### individual

Each CRD file is fetched separately with `curl`:

```bash
curl --silent --retry-all-errors --fail --location "${url}" > "${crd_dir}/${file}"
```

Use this when the upstream repository stores one CRD per file.

### bundle

A single bundle file is fetched, then split into individual files using `kubectl slice`:

```bash
curl ... "${bundle_url}" > bundle.yaml
kubectl slice -q -f bundle.yaml -t "{{.metadata.name}}.yaml" -o "${crd_dir}"
```

`kubectl slice` splits multi-document YAML into one file per Kubernetes resource, named by `metadata.name`. The `FILES` array in the script must list the resulting filenames so the driver knows which files to process.

### kustomize

The CRDs are assembled by running `kustomize build` against a remote URL:

```bash
kustomize build "${url}" > bundle.yaml
```

The resulting bundle is then processed the same way as the `bundle` mode.

### swagger

Some Kubernetes API groups publish a Swagger 2.0 spec rather than CRD YAML. The driver downloads the Swagger file and uses `jq` to extract each definition and write it as a JSON Schema file:

```bash
jq -c '.definitions | to_entries[] | ...' swagger.json | while read -r line; do
  # extract group/kind/version from the definition key
  # write to schemas/{group}.api.k8s.io/{kind}_{version}.json
done
```

Swagger-derived schemas use `{group}.api.k8s.io` as the API group directory.

---

## Common extraction problems

### Schema is empty or `null`

If `yq` returns `null` for `.spec.versions[].schema.openAPIV3Schema`, the CRD uses non-structural validation or does not embed a schema. OpenSpec Hub cannot extract a schema for such CRDs.

### Wrong kind or version in filename

The extraction reads `.spec.group`, `.spec.names.kind`, and `.spec.versions[0].name` from the CRD. If any of these fields are missing or have unexpected values, `generate_output_filename` returns an empty string and the file is skipped with an error log.

### Bundle split produces unexpected filenames

`kubectl slice` names output files after `metadata.name`, which may differ from what you expect. After running the bundle download step, inspect the `scripts/crds/{app}/` directory to see the actual filenames, then update the `FILES` array accordingly.

---

## Further reading

- [Architecture](architecture.md) — the goals and design decisions behind OpenSpec Hub
- [CRD script format reference](../reference/crd-scripts.md) — the `choice`, `FILES`, and `generate_url` contract
- [How to add a new CRD](../how-to/howto-add-crd.md) — step-by-step guide
