#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "apiextensions.crossplane.io_compositeresourcedefinitions.yaml"
  "apiextensions.crossplane.io_compositionrevisions.yaml"
  "apiextensions.crossplane.io_compositions.yaml"
  "apiextensions.crossplane.io_environmentconfigs.yaml"
  "apiextensions.crossplane.io_managedresourceactivationpolicies.yaml"
  "apiextensions.crossplane.io_managedresourcedefinitions.yaml"
  "apiextensions.crossplane.io_usages.yaml"
  "ops.crossplane.io_cronoperations.yaml"
  "ops.crossplane.io_operations.yaml"
  "ops.crossplane.io_watchoperations.yaml"
  "pkg.crossplane.io_configurationrevisions.yaml"
  "pkg.crossplane.io_configurations.yaml"
  "pkg.crossplane.io_deploymentruntimeconfigs.yaml"
  "pkg.crossplane.io_functionrevisions.yaml"
  "pkg.crossplane.io_functions.yaml"
  "pkg.crossplane.io_imageconfigs.yaml"
  "pkg.crossplane.io_locks.yaml"
  "pkg.crossplane.io_providerrevisions.yaml"
  "pkg.crossplane.io_providers.yaml"
  "protection.crossplane.io_clusterusages.yaml"
  "protection.crossplane.io_usages.yaml"
)

# renovate: datasource=github-tags depName=crossplane/crossplane
export VERSION=v2.2.1

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/crossplane/crossplane/${VERSION}/cluster/crds/${crd_file}"
}
