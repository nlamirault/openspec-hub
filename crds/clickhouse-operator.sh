#!/usr/bin/env bash

export choice=individual
export FILES=(
  "CustomResourceDefinition-clickhouseinstallations.clickhouse.altinity.com.yaml"
  "CustomResourceDefinition-clickhouseinstallationtemplates.clickhouse.altinity.com.yaml"
  "CustomResourceDefinition-clickhousekeeperinstallations.clickhouse-keeper.altinity.com.yaml"
  "CustomResourceDefinition-clickhouseoperatorconfigurations.clickhouse.altinity.com.yaml"
)

# renovate: datasource=github-tags depName=Altinity/clickhouse-operator
export VERSION=0.25.5

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/Altinity/clickhouse-operator/refs/tags/release-${VERSION}/deploy/helm/clickhouse-operator/crds/${crd_file}"
}
