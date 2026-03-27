# How to use yaml-language-server

The `yaml-language-server` directive is a comment you add to the top of any YAML file to bind it to a specific schema. It works in any editor that supports the YAML language server protocol — VSCode, Neovim, Emacs, and others.

---

## Add a schema to a single file

Place this comment on the first line of your YAML file:

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{api-group}/{kind}_{version}.json
```

Example for an ArgoCD Application:

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/argoproj.io/application_v1alpha1.json
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app
```

---

## Common schema directives

Copy the relevant comment into your YAML file:

### GitOps

```yaml
# ArgoCD Application
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/argoproj.io/application_v1alpha1.json

# Flux Kustomization
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/kustomize.toolkit.fluxcd.io/kustomization_v1.json

# Flux HelmRelease
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/helm.toolkit.fluxcd.io/helmrelease_v2.json
```

### Observability

```yaml
# Prometheus
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/monitoring.coreos.com/prometheus_v1.json

# PrometheusRule
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/monitoring.coreos.com/prometheusrule_v1.json

# OpenTelemetry Collector
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/opentelemetry.io/opentelemetrycollector_v1beta1.json
```

### Security

```yaml
# ExternalSecret
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/external-secrets.io/externalsecret_v1beta1.json

# SecretStore
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/external-secrets.io/secretstore_v1beta1.json
```

### Databases

```yaml
# CloudnativePG Cluster
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/postgresql.cnpg.io/cluster_v1.json
```

---

## Construct a schema URL

All schema URLs follow the same pattern:

```
https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{api-group}/{kind}_{version}.json
```

- `{api-group}` — the Kubernetes API group, e.g. `argoproj.io`
- `{kind}` — the resource kind in lowercase, e.g. `application`
- `{version}` — the API version, e.g. `v1alpha1`

See the [Supported schemas reference](../reference/schemas.md) for the full list of available schemas.

---

## Neovim (nvim-lspconfig)

If you use `nvim-lspconfig` with `yamlls`, the `yaml-language-server` comment directive works out of the box with no additional configuration. The language server reads it automatically when it opens the file.
