#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "services.k8s.aws_fieldexports.yaml"
  "sns.services.k8s.aws_platformapplications.yaml"
  "sns.services.k8s.aws_platformendpoints.yaml"
  "sns.services.k8s.aws_subscriptions.yaml"
  "sns.services.k8s.aws_topics.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/sns-controller
export VERSION=1.3.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/sns-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
