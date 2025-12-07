#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "services.k8s.aws_fieldexports.yaml"
  "sqs.services.k8s.aws_queues.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/sqs-controller
export VERSION=1.3.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/sqs-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
