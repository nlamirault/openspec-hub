#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "karpenter.azure.com_aksnodeclasses.yaml"
)

# renovate: datasource=github-tags depName=Azure/karpenter-provider-azure
export VERSION=1.7.2

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/Azure/karpenter-provider-azure/v${VERSION}/charts/karpenter-crd/templates/${crd_file}"
}
