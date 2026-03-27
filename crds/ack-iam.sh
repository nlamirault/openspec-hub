#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "iam.services.k8s.aws_groups.yaml"
  "iam.services.k8s.aws_instanceprofiles.yaml"
  "iam.services.k8s.aws_openidconnectproviders.yaml"
  "iam.services.k8s.aws_policies.yaml"
  "iam.services.k8s.aws_roles.yaml"
  "iam.services.k8s.aws_servicelinkedroles.yaml"
  "iam.services.k8s.aws_users.yaml"
  "services.k8s.aws_fieldexports.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/iam-controller
export VERSION=1.6.2

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/iam-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
