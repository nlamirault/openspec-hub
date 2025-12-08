# CRD Schema Store

A collection of JSON schemas extracted from Kubernetes Custom Resource Definitions (CRDs) for popular cloud-native applications and operators.

## Supported Applications & Operators

### AWS Controllers for Kubernetes (ACK)

- **Bedrock Agent** - AI agent management
- **DynamoDB** - NoSQL database service
- **EC2** - Compute instances and networking
- **ECR** - Container registry
- **ECS** - Container service
- **EKS** - Kubernetes service
- **EventBridge** - Event-driven architectures
- **IAM** - Identity and access management
- **Kafka (MSK)** - Managed streaming for Apache Kafka
- **KMS** - Key management service
- **RDS** - Relational database service
- **S3** - Object storage
- **Secrets Manager** - Secret storage and rotation
- **SNS** - Notification service
- **SQS** - Message queuing service

### Google Cloud

- **GCP Config Connector** - Google Cloud resource management

### Azure

- **Azure Service Operator** - 250+ Azure services management

### Databases

- **Clickhouse Operator** - ClickHouse database cluster management
- **Cloudnative PG** - PostgreSQL database operator for Kubernetes
- **Dragonfly Operator** - Dragonfly in-memory datastore management
- **MariaDB Operator** - MariaDB database deployment and management
- **MySQL Operator** - MySQL database cluster orchestration

### GitOps & Deployment

- **Argo CD** - GitOps continuous delivery
- **Argo Events** - Event-driven workflow automation
- **Argo Rollouts** - Progressive delivery and blue-green deployments
- **Argo Workflows** - Container-native workflow engine
- **Flux** - GitOps toolkit for Kubernetes
- **Kargo** - GitOps promotion engine

### Infrastructure & Autoscaling

- **Kubernetes** - Core Kubernetes API
- **KEDA** - Event-driven autoscaling for Kubernetes workloads
- **Karpenter AWS** - Node autoscaling for Amazon EKS
- **Karpenter Azure** - Node autoscaling for Azure AKS
- **VPA (Vertical Pod Autoscaler)** - Automatic resource scaling

### Observability

- **Grafana Operator** - Grafana instance management
- **OpenTelemetry Operator** - OpenTelemetry instrumentation and data collection
- **Prometheus Operator** - Monitoring and alerting
- **OpenReports** - Standardized reports (findings, policy results, etc.)

### Security & Secrets

- **External Secrets** - External secret management integration

### Networking & Service Mesh

- **Gateway API** - Next-generation ingress and traffic management
- **Istio** - Service mesh for secure, fast, and reliable service-to-service communication
- **KGateway** - Envoy-based API gateway for Kubernetes
- **Envoy Gateway** - Envoy Proxy as a Kubernetes API Gateway

### Feature Management & Configuration

- **Open Feature Operator** - Standardizing Feature Flagging

## Schema Organization

Schemas are organized by API group and follow the naming convention:

```
schemas/{api-group}/{kind}_{version}.json
```

For example:

- `schemas/argoproj.io/application_v1alpha1.json`
- `schemas/external-secrets.io/externalsecret_v1alpha1.json`
- `schemas/monitoring.coreos.com/prometheus_v1.json`

## Usage

### IDE Integration

#### VSCode

Add the following to your VSCode `settings.json`:

```json
{
  "yaml.schemas": {
    "https://raw.githubusercontent.com/nlamirault/crd-schema-store/main/schemas/argoproj.io/application_v1alpha1.json": [
      "*/applications/*.yaml",
      "*/applications/*.yml"
    ],
    "https://raw.githubusercontent.com/nlamirault/crd-schema-store/main/schemas/monitoring.coreos.com/prometheus_v1.json": [
      "*/prometheus/*.yaml",
      "*/prometheus/*.yml"
    ]
  }
}
```

#### yaml-language-server

For file-specific schema validation, add a comment at the top of your YAML files:

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/crd-schema-store/main/schemas/argoproj.io/application_v1alpha1.json
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app
# ... rest of your YAML
```

This provides inline validation and autocomplete for the specific CRD schema without global IDE configuration.

### CLI Tools

Use with tools like `yq`, `kubeval`, or custom validation scripts:

```bash
# Validate an ArgoCD Application
curl -s https://raw.githubusercontent.com/nlamirault/crd-schema-store/main/schemas/argoproj.io/application_v1alpha1.json | \
  yq eval 'validate(.)' my-application.yaml
```

## Development

### Prerequisites

- `bash` shell
- `yq` (YAML processor)
- `curl` or `wget`
- `slice` kubectl plugin
- Python 3.8+ with `uv` (for development environment)

### Adding New Applications

1. Create a new script in `crds/` directory following the naming convention `{app-name}.sh`
2. Define the required variables and functions:

```bash
#!/usr/bin/env bash

# 'individual' for separate files
# 'bundle' for single file,
# 'kustomize' for kustomize directory
export choice=individual
export FILES=(
  "crd-file1.yaml"
  "crd-file2.yaml"
)

# renovate: datasource=github-tags depName=org/repo
export VERSION=1.0.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/org/repo/v${VERSION}/manifests/${crd_file}"
}
```

3. Build the schemas:

```bash
make build APP=your-app-name
```

### Project Structure

```
├── crds/                   # CRD download scripts
├── schemas/                # Generated JSON schemas (organized by API group)
├── scripts/
│   ├── commons.sh          # Common utility functions
│   └── schema-store.sh     # Main schema generation script
├── Makefile                # Build automation
└── README.md               # This file
```

## Contributing

Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## License

See the [LICENSE](LICENSE) file for details.
