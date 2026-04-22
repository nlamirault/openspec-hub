# OpenSpec Hub

[![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

A collection of JSON schemas extracted from Kubernetes Custom Resource Definitions (CRDs) for popular cloud-native operators and controllers.

## Overview

OpenSpec Hub provides ready-to-use JSON Schema files for Kubernetes CRDs. Use them in your IDE or CI pipeline to get validation and autocomplete for resources like ArgoCD Applications, Flux Kustomizations, Prometheus rules, External Secrets, and 70+ more.

Schemas are served directly from GitHub:

```
https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{api-group}/{kind}_{version}.json
```

## Documentation

Documentation follows the [Diátaxis](https://diataxis.fr/) framework — see [`docs/`](docs/) for the full index.

| Type              | Documents                                                                                                                                                                                                                |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Tutorials**     | [Your first schema validation](docs/tutorials/getting-started.md)                                                                                                                                                        |
| **How-to guides** | [Configure VSCode](docs/how-to/howto-vscode.md) · [yaml-language-server](docs/how-to/howto-yaml-language-server.md) · [Validate with CLI](docs/how-to/howto-validate.md) · [Add a new CRD](docs/how-to/howto-add-crd.md) |
| **Reference**     | [Supported schemas](docs/reference/schemas.md) · [CRD script format](docs/reference/crd-scripts.md) ·                                                                                                                    |
| **Explanation**   | [Architecture](docs/explanation/architecture.md) · [Schema extraction](docs/explanation/schema-extraction.md)                                                                                                            |

## Supported applications

See the [supported schemas reference](docs/reference/schemas.md) for the full list with API groups.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

See [LICENSE](LICENSE).
