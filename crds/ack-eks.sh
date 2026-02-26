#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "eks.services.k8s.aws_accessentries.yaml"
  "eks.services.k8s.aws_addons.yaml"
  "eks.services.k8s.aws_clusters.yaml"
  "eks.services.k8s.aws_fargateprofiles.yaml"
  "eks.services.k8s.aws_identityproviderconfigs.yaml"
  "eks.services.k8s.aws_nodegroups.yaml"
  "eks.services.k8s.aws_podidentityassociations.yaml"
  "services.k8s.aws_fieldexports.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/eks-controller
export VERSION=1.11.2

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/eks-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
