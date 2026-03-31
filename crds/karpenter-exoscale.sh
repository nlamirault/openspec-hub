#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "karpenter.exoscale.com_exoscalenodeclasses.yaml"
)

# renovate: datasource=github-tags depName=exoscale/karpenter-provider-exoscale
export VERSION=1.0.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/exoscale/karpenter-provider-exoscale/v${VERSION}/config/crd/bases/${crd_file}"
}
