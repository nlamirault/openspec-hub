#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "networkfirewall.services.k8s.aws_firewallpolicies.yaml"
  "networkfirewall.services.k8s.aws_firewalls.yaml"
  "networkfirewall.services.k8s.aws_rulegroups.yaml"
  "services.k8s.aws_fieldexports.yaml"
  "services.k8s.aws_iamroleselectors.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/networkfirewall-controller
export VERSION=1.2.2

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/networkfirewall-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
