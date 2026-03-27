# Tutorial: Your first schema validation

In this tutorial you will set up OpenSpec Hub schema validation in your editor and validate a real Kubernetes manifest against a CRD schema. By the end you will have live validation and autocomplete for any supported resource in your YAML files.

**What you will accomplish**: install the YAML extension in VSCode, point it at an ArgoCD `Application` schema, and see inline errors for a misconfigured manifest.

---

## Prerequisites

- [VSCode](https://code.visualstudio.com/) installed
- The [YAML extension by Red Hat](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) installed
- `curl` available in your shell (to verify schema access)

---

## Step 1 — Verify the schema is reachable

Before configuring your editor, confirm the schema you want to use is available.

```bash
curl -s https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/argoproj.io/application_v1alpha1.json | head -5
```

You should see the beginning of a JSON Schema document. If you get a 404, check the [Supported schemas reference](../reference/schemas.md) for the correct path.

---

## Step 2 — Create a test manifest

Create a file `my-app.yaml` with this minimal ArgoCD Application:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/myorg/myrepo
    targetRevision: HEAD
    path: manifests
  destination:
    server: https://kubernetes.default.svc
    namespace: production
```

---

## Step 3 — Add a schema hint to the file

Add this comment at the very top of `my-app.yaml`:

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/argoproj.io/application_v1alpha1.json
apiVersion: argoproj.io/v1alpha1
kind: Application
# ...
```

Save the file. VSCode will now validate it against the ArgoCD Application schema.

---

## Step 4 — Trigger a validation error

Introduce a deliberate error to confirm validation is working. Change `repoURL` to `repo_url`:

```yaml
  source:
    repo_url: https://github.com/myorg/myrepo   # wrong field name
```

You should see a red underline or a warning in the Problems panel. Hover over it — VSCode will describe the schema violation.

Revert the change. The error disappears.

---

## Step 5 — Try autocomplete

Place your cursor inside the `spec:` block and press `Ctrl+Space` (or `Cmd+Space` on macOS). VSCode will suggest valid fields from the schema — `syncPolicy`, `ignoreDifferences`, `revisionHistoryLimit`, and so on.

---

## What you learned

- Schemas are served directly from GitHub raw content at `https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{api-group}/{kind}_{version}.json`.
- The `yaml-language-server: $schema=` comment enables per-file validation without global editor configuration.
- Schema validation catches typos and invalid fields before you apply a manifest.

## Next steps

- Configure VSCode globally for multiple resource types: [How to configure VSCode](../how-to/howto-vscode.md).
- Apply schemas to all files of a given type: [How to use yaml-language-server](../how-to/howto-yaml-language-server.md).
- See all supported operators and API groups: [Supported schemas reference](../reference/schemas.md).
