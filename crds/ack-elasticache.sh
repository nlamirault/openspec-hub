#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "elasticache.services.k8s.aws_cacheclusters.yaml"
  "elasticache.services.k8s.aws_cacheparametergroups.yaml"
  "elasticache.services.k8s.aws_cachesubnetgroups.yaml"
  "elasticache.services.k8s.aws_replicationgroups.yaml"
  "elasticache.services.k8s.aws_serverlesscaches.yaml"
  "elasticache.services.k8s.aws_serverlesscachesnapshots.yaml"
  "elasticache.services.k8s.aws_snapshots.yaml"
  "elasticache.services.k8s.aws_usergroups.yaml"
  "elasticache.services.k8s.aws_users.yaml"
  "services.k8s.aws_fieldexports.yaml"
  "services.k8s.aws_iamroleselectors.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/elasticache-controller
export VERSION=1.3.4

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/elasticache-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
