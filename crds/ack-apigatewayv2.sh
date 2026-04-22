#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "apigatewayv2.services.k8s.aws_apimappings.yaml"
  "apigatewayv2.services.k8s.aws_apis.yaml"
  "apigatewayv2.services.k8s.aws_authorizers.yaml"
  "apigatewayv2.services.k8s.aws_deployments.yaml"
  "apigatewayv2.services.k8s.aws_domainnames.yaml"
  "apigatewayv2.services.k8s.aws_integrations.yaml"
  "apigatewayv2.services.k8s.aws_routes.yaml"
  "apigatewayv2.services.k8s.aws_stages.yaml"
  "apigatewayv2.services.k8s.aws_vpclinks.yaml"
  "services.k8s.aws_fieldexports.yaml"
  "services.k8s.aws_iamroleselectors.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/apigatewayv2-controller
export VERSION=1.2.3

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/apigatewayv2-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
