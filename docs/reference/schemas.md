# Supported schemas reference

All schemas are served from:

```
https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{api-group}/{kind}_{version}.json
```

All path components are lowercase.

---

## AWS Controllers for Kubernetes (ACK)

| Application     | API group                         |
| --------------- | --------------------------------- |
| Bedrock Agent   | `bedrockagent.services.k8s.aws`   |
| DynamoDB        | `dynamodb.services.k8s.aws`       |
| EC2             | `ec2.services.k8s.aws`            |
| ECR             | `ecr.services.k8s.aws`            |
| ECS             | `ecs.services.k8s.aws`            |
| EKS             | `eks.services.k8s.aws`            |
| EventBridge     | `eventbridge.services.k8s.aws`    |
| IAM             | `iam.services.k8s.aws`            |
| Kafka (MSK)     | `kafka.services.k8s.aws`          |
| KMS             | `kms.services.k8s.aws`            |
| RDS             | `rds.services.k8s.aws`            |
| S3              | `s3.services.k8s.aws`             |
| Secrets Manager | `secretsmanager.services.k8s.aws` |
| SNS             | `sns.services.k8s.aws`            |
| SQS             | `sqs.services.k8s.aws`            |

Shared ACK types (field exports, IAM role selectors) are in `services.k8s.aws`.

---

## Google Cloud

| Application      | API group                 |
| ---------------- | ------------------------- |
| Config Connector | `*.cnrm.cloud.google.com` |

---

## Azure

| Application            | API group     |
| ---------------------- | ------------- |
| Azure Service Operator | `*.azure.com` |

---

## GitOps & Deployment

| Application    | API group             |
| -------------- | --------------------- |
| Argo CD        | `argoproj.io`         |
| Argo Events    | `argoproj.io`         |
| Argo Rollouts  | `argoproj.io`         |
| Argo Workflows | `argoproj.io`         |
| Flux           | `*.toolkit.fluxcd.io` |
| Kargo          | `kargo.akuity.io`     |

---

## Infrastructure & Autoscaling

| Application             | API group                            |
| ----------------------- | ------------------------------------ |
| Kubernetes core         | `*.k8s.io`                           |
| KEDA                    | `keda.sh`                            |
| Karpenter (AWS)         | `karpenter.k8s.aws` / `karpenter.sh` |
| Karpenter (Azure)       | `karpenter.azure.com`                |
| Cluster API             | `cluster.x-k8s.io`                   |
| Vertical Pod Autoscaler | `autoscaling.k8s.io`                 |

---

## Databases

| Application         | API group                 |
| ------------------- | ------------------------- |
| ClickHouse Operator | `clickhouse.altinity.com` |
| CloudnativePG       | `postgresql.cnpg.io`      |
| Dragonfly Operator  | `dragonflydb.io`          |
| MariaDB Operator    | `k8s.mariadb.com`         |
| MySQL Operator      | `mysql.oracle.com`        |

---

## Observability

| Application            | API group                             |
| ---------------------- | ------------------------------------- |
| Grafana Operator       | `grafana.integreatly.org`             |
| OpenTelemetry Operator | `opentelemetry.io`                    |
| Prometheus Operator    | `monitoring.coreos.com`               |
| OpenReports            | `wgpolicyk8s.io` / `reports.x-k8s.io` |

---

## Security & Secrets

| Application      | API group                                                |
| ---------------- | -------------------------------------------------------- |
| External Secrets | `external-secrets.io` / `generators.external-secrets.io` |

---

## Networking & Service Mesh

| Application   | API group                          |
| ------------- | ---------------------------------- |
| Gateway API   | `gateway.networking.k8s.io`        |
| Istio         | `*.istio.io`                       |
| KGateway      | `gateway.solo.io` / `kgateway.dev` |
| Envoy Gateway | `gateway.envoyproxy.io`            |

---

## Feature Management

| Application           | API group              |
| --------------------- | ---------------------- |
| Open Feature Operator | `core.openfeature.dev` |

---

## Upbound & Crossplane

| Application       | API group                                           |
| ----------------- | --------------------------------------------------- |
| Crossplane        | `pkg.crossplane.io` / `apiextensions.crossplane.io` |
| Upbound providers | `*.upbound.io`                                      |

---

## Schema naming convention

```
schemas/{api-group}/{kind}_{version}.json
```

Examples:

| Resource                    | Schema path                                                 |
| --------------------------- | ----------------------------------------------------------- |
| ArgoCD Application v1alpha1 | `schemas/argoproj.io/application_v1alpha1.json`             |
| External Secret v1beta1     | `schemas/external-secrets.io/externalsecret_v1beta1.json`   |
| Prometheus v1               | `schemas/monitoring.coreos.com/prometheus_v1.json`          |
| Flux Kustomization v1       | `schemas/kustomize.toolkit.fluxcd.io/kustomization_v1.json` |
| CNPG Cluster v1             | `schemas/postgresql.cnpg.io/cluster_v1.json`                |
| KEDA ScaledObject v1alpha1  | `schemas/keda.sh/scaledobject_v1alpha1.json`                |

All `kind` and `version` values are normalized to lowercase in the filename.
