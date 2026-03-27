#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "cloudfront.services.k8s.aws_cachepolicies.yaml"
  "cloudfront.services.k8s.aws_distributions.yaml"
  "cloudfront.services.k8s.aws_functions.yaml"
  "cloudfront.services.k8s.aws_originaccesscontrols.yaml"
  "cloudfront.services.k8s.aws_originrequestpolicies.yaml"
  "cloudfront.services.k8s.aws_responseheaderspolicies.yaml"
  "cloudfront.services.k8s.aws_vpcorigins.yaml"
  "services.k8s.aws_fieldexports.yaml"
  "services.k8s.aws_iamroleselectors.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/cloudfront-controller
export VERSION=1.3.2

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/cloudfront-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
