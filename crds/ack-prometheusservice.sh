#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "prometheusservice.services.k8s.aws_alertmanagerdefinitions.yaml"
  "prometheusservice.services.k8s.aws_loggingconfigurations.yaml"
  "prometheusservice.services.k8s.aws_rulegroupsnamespaces.yaml"
  "prometheusservice.services.k8s.aws_workspaces.yaml"
  "services.k8s.aws_fieldexports.yaml"
  "services.k8s.aws_iamroleselectors.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/prometheusservice-controller
export VERSION=1.4.2

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/prometheusservice-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
