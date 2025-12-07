#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  # Compute
  "compute_v1beta1_computeaddress.yaml"
  "compute_v1beta1_computedisk.yaml"
  "compute_v1beta1_computefirewall.yaml"
  "compute_v1beta1_computeinstance.yaml"
  "compute_v1beta1_computenetwork.yaml"
  "compute_v1beta1_computesubnetwork.yaml"
  
  # Storage
  "storage_v1beta1_storagebucket.yaml"
  "storage_v1beta1_storagebucketiammember.yaml"
  
  # IAM
  "iam_v1beta1_iamserviceaccount.yaml"
  "iam_v1beta1_iamserviceaccountkey.yaml"
  "iam_v1beta1_iampolicy.yaml"
  
  # Container (GKE)
  "container_v1beta1_containercluster.yaml"
  "container_v1beta1_containernodepool.yaml"
  
  # BigQuery
  "bigquery_v1beta1_bigquerydataset.yaml"
  "bigquery_v1beta1_bigquerytable.yaml"
  
  # Cloud SQL
  "sql_v1beta1_sqlinstance.yaml"
  "sql_v1beta1_sqldatabase.yaml"
  "sql_v1beta1_sqluser.yaml"
  
  # KMS
  "kms_v1beta1_kmskeyring.yaml"
  "kms_v1beta1_kmscryptokey.yaml"
  
  # Cloud Functions
  "cloudfunctions_v1beta1_cloudfunction.yaml"
  
  # Pub/Sub
  "pubsub_v1beta1_pubsubtopic.yaml"
  "pubsub_v1beta1_pubsubsubscription.yaml"
  
  # Cloud Run
  "run_v1beta1_runservice.yaml"
  
  # Monitoring
  "monitoring_v1beta1_monitoringalertpolicy.yaml"
  "monitoring_v1beta1_monitoringnotificationchannel.yaml"
  
  # Logging
  "logging_v1beta1_logginglogsink.yaml"
  "logging_v1beta1_logginglogmetric.yaml"
  
  # DNS
  "dns_v1beta1_dnsmanagedzone.yaml"
  "dns_v1beta1_dnsrecordset.yaml"
  
  # Secret Manager
  "secretmanager_v1beta1_secretmanagersecret.yaml"
  
  # Resource Manager
  "resourcemanager_v1beta1_project.yaml"
  "resourcemanager_v1beta1_folder.yaml"
)

# renovate: datasource=github-tags depName=GoogleCloudPlatform/k8s-config-connector
export VERSION=1.140.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/GoogleCloudPlatform/k8s-config-connector/v${VERSION}/crds/${crd_file}"
}