# How to validate manifests with CLI tools

Use these approaches when you want to validate Kubernetes manifests outside an IDE — in CI pipelines, pre-commit hooks, or one-off checks.

---

## Prerequisites

- `curl` or `wget`
- One of: `yq`, `kubeval`, or `kubeconform`

---

## Validate with yq

`yq` can validate a YAML document against a JSON Schema using the `validate` expression.

```bash
# Fetch schema and validate a manifest
curl -s https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/argoproj.io/application_v1alpha1.json \
  | yq eval-all 'select(fileIndex == 0) as $schema | select(fileIndex == 1) | validate($schema)' - my-application.yaml
```

If the manifest is valid, the command exits with code 0 and no output. If it is invalid, yq prints the schema violations.

---

## Validate with kubeconform

[kubeconform](https://github.com/yannh/kubeconform) is a fast Kubernetes manifest validator. It supports custom schema locations via the `-schema-location` flag.

```bash
kubeconform \
  -schema-location default \
  -schema-location 'https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json' \
  my-application.yaml
```

The `{{.Group}}`, `{{.ResourceKind}}`, and `{{.ResourceAPIVersion}}` placeholders are replaced by kubeconform using the resource's `apiVersion` and `kind` fields.

### Validate a directory

```bash
kubeconform \
  -schema-location 'https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json' \
  -recursive \
  manifests/
```

### Use in CI (GitHub Actions)

```yaml
- name: Validate manifests
  run: |
    kubeconform \
      -schema-location 'https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json' \
      -recursive \
      -summary \
      manifests/
```

---

## Download a schema locally

If you are in a restricted network environment or want to avoid repeated remote fetches:

```bash
# Create local schema directory
mkdir -p .schemas/argoproj.io

# Download specific schema
curl -s https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/argoproj.io/application_v1alpha1.json \
  -o .schemas/argoproj.io/application_v1alpha1.json
```

Then point your tools at the local path instead of the remote URL.

---

## Find the schema URL for a resource

Schema URLs follow this pattern:

```
https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{api-group}/{kind}_{version}.json
```

All values are lowercase. See the [Supported schemas reference](../reference/schemas.md) for the full list.
