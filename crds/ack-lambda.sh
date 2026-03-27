#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "lambda.services.k8s.aws_aliases.yaml"
  "lambda.services.k8s.aws_codesigningconfigs.yaml"
  "lambda.services.k8s.aws_eventsourcemappings.yaml"
  "lambda.services.k8s.aws_functions.yaml"
  "lambda.services.k8s.aws_functionurlconfigs.yaml"
  "lambda.services.k8s.aws_layerversions.yaml"
  "lambda.services.k8s.aws_versions.yaml"
  "services.k8s.aws_fieldexports.yaml"
  "services.k8s.aws_iamroleselectors.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/lambda-controller
export VERSION=1.11.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/lambda-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
