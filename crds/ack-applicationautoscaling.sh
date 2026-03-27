#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "applicationautoscaling.services.k8s.aws_scalabletargets.yaml"
  "applicationautoscaling.services.k8s.aws_scalingpolicies.yaml"
  "services.k8s.aws_fieldexports.yaml"
  "services.k8s.aws_iamroleselectors.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/applicationautoscaling-controller
export VERSION=1.2.2

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/applicationautoscaling-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
