# OpenSpec Hub Documentation

**OpenSpec Hub** is a collection of JSON schemas extracted from Kubernetes Custom Resource Definitions (CRDs) for popular cloud-native operators and controllers.

This documentation follows the [Diátaxis](https://diataxis.fr/) framework, organized into four types based on what you need.

---

## Tutorials — learning by doing

Start here if you are new to OpenSpec Hub.

| Document | Description |
| -------- | ----------- |
| [Your first schema validation](tutorials/getting-started.md) | Set up IDE integration and validate your first Kubernetes manifest |

---

## How-to guides — solving specific problems

Use these when you know what you want to accomplish and need the steps.

| Document | Description |
| -------- | ----------- |
| [Configure VSCode](how-to/howto-vscode.md) | Set up YAML schema validation in VSCode |
| [Use yaml-language-server](how-to/howto-yaml-language-server.md) | Add per-file schema hints with yaml-language-server |
| [Validate with CLI tools](how-to/howto-validate.md) | Validate manifests from the command line |
| [Add a new CRD](how-to/howto-add-crd.md) | Contribute a new operator or controller |

---

## Reference — technical specifications

Look these up when you need accurate, factual information.

| Document | Description |
| -------- | ----------- |
| [Supported schemas](reference/schemas.md) | Full list of supported applications and API groups |
| [CRD script format](reference/crd-scripts.md) | Variables and functions required in each `crds/*.sh` script |

---

## Explanation — understanding the design

Read these to deepen your understanding of how and why OpenSpec Hub works the way it does.

| Document | Description |
| -------- | ----------- |
| [Architecture](explanation/architecture.md) | Project goals, design decisions, and schema organization |
| [Schema extraction](explanation/schema-extraction.md) | How CRDs are downloaded, parsed, and converted to JSON Schema |
