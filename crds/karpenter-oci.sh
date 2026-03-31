#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "oci.oraclecloud.com_ocinodeclasses.yaml"
)

# renovate: datasource=github-commits depName=oracle/karpenter-provider-oci
export VERSION=8e6946f85cc307e9789efc04dfb0198ecc9bd263

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/oracle/karpenter-provider-oci/${VERSION}/pkg/apis/crds/${crd_file}"
}
