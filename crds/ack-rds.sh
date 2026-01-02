#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "rds.services.k8s.aws_dbclusterendpoints.yaml"
  "rds.services.k8s.aws_dbclusterparametergroups.yaml"
  "rds.services.k8s.aws_dbclusters.yaml"
  "rds.services.k8s.aws_dbclustersnapshots.yaml"
  "rds.services.k8s.aws_dbinstances.yaml"
  "rds.services.k8s.aws_dbparametergroups.yaml"
  "rds.services.k8s.aws_dbproxies.yaml"
  "rds.services.k8s.aws_dbsnapshots.yaml"
  "rds.services.k8s.aws_dbsubnetgroups.yaml"
  "rds.services.k8s.aws_globalclusters.yaml"
  "services.k8s.aws_fieldexports.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/rds-controller
export VERSION=1.7.2

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/rds-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
