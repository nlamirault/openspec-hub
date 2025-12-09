#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "karpenter.k8s.aws_ec2nodeclasses.yaml"
)

# renovate: datasource=github-tags depName=aws/karpenter-provider-aws
export VERSION=1.8.1

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${VERSION}/pkg/apis/crds/${crd_file}"
}
