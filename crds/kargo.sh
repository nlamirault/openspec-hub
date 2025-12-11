#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "kargo.akuity.io_clusterconfigs.yaml"
  "kargo.akuity.io_clusterpromotiontasks.yaml"
  "kargo.akuity.io_freights.yaml"
  "kargo.akuity.io_projectconfigs.yaml"
  "kargo.akuity.io_projects.yaml"
  "kargo.akuity.io_promotions.yaml"
  "kargo.akuity.io_promotiontasks.yaml"
  "kargo.akuity.io_stages.yaml"
  "kargo.akuity.io_warehouses.yaml"
)

# renovate: datasource=github-tags depName=akuity/kargo
export VERSION=1.8.4

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/akuity/kargo/v${VERSION}/charts/kargo/resources/crds/${crd_file}"
}