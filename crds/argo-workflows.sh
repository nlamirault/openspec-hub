#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "argoproj.io_clusterworkflowtemplates.yaml"
  "argoproj.io_cronworkflows.yaml"
  "argoproj.io_workflowartifactgctasks.yaml"
  "argoproj.io_workfloweventbindings.yaml"
  "argoproj.io_workflows.yaml"
  "argoproj.io_workflowtaskresults.yaml"
  "argoproj.io_workflowtasksets.yaml"
  "argoproj.io_workflowtemplates.yaml"
)

# renovate: datasource=github-tags depName=argoproj/argo-workflows
export VERSION=3.7.14

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/argoproj/argo-workflows/refs/tags/v${VERSION}/manifests/base/crds/full/${crd_file}"
}
