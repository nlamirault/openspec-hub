#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "s3.services.k8s.aws_buckets.yaml"
  "services.k8s.aws_fieldexports.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/s3-controller
export VERSION=1.2.1

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/s3-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
