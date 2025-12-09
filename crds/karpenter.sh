#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "karpenter.sh_nodeclaims.yaml"
  "karpenter.sh_nodeoverlays.yaml"
  "karpenter.sh_nodepools.yaml"
)

# renovate: datasource=github-tags depName=kubernetes-sigs/karpenter
export VERSION=1.8.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/kubernetes-sigs/karpenter/refs/tags/v${VERSION}/pkg/apis/crds/${crd_file}"
}
