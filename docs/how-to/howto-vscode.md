# How to configure VSCode for schema validation

## Prerequisites

- VSCode with the [YAML extension by Red Hat](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) installed

---

## Associate schemas with file patterns

Open your VSCode `settings.json` (`Ctrl+Shift+P` → "Open User Settings (JSON)") and add a `yaml.schemas` block.

Each entry maps a schema URL to one or more glob patterns:

```json
{
  "yaml.schemas": {
    "https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/argoproj.io/application_v1alpha1.json": [
      "*/applications/*.yaml",
      "*/applications/*.yml"
    ],
    "https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/monitoring.coreos.com/prometheus_v1.json": [
      "*/prometheus/*.yaml",
      "*/prometheus/*.yml"
    ],
    "https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/external-secrets.io/externalsecret_v1beta1.json": [
      "*/external-secrets/*.yaml"
    ]
  }
}
```

VSCode will apply the correct schema to every matching file automatically.

---

## Workspace-level configuration

For project-specific settings, add the same block to `.vscode/settings.json` at the root of your repository. This scopes the schema associations to that project only and can be committed to version control.

```json
{
  "yaml.schemas": {
    "https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/kustomize.toolkit.fluxcd.io/kustomization_v1.json": [
      "clusters/**/*.yaml"
    ]
  }
}
```

---

## Override schema for a single file

If a file does not match any glob pattern, add a comment at the top of the file:

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/argoproj.io/application_v1alpha1.json
apiVersion: argoproj.io/v1alpha1
kind: Application
```

This takes precedence over any global or workspace setting for that file.

---

## Find the schema URL for a resource

Schema URLs follow the pattern:

```
https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{api-group}/{kind}_{version}.json
```

All values are lowercase. For example:

| Resource | URL path |
| -------- | -------- |
| ArgoCD Application v1alpha1 | `schemas/argoproj.io/application_v1alpha1.json` |
| External Secret v1beta1 | `schemas/external-secrets.io/externalsecret_v1beta1.json` |
| Prometheus v1 | `schemas/monitoring.coreos.com/prometheus_v1.json` |
| Flux Kustomization v1 | `schemas/kustomize.toolkit.fluxcd.io/kustomization_v1.json` |

See the full list in the [Supported schemas reference](../reference/schemas.md).
