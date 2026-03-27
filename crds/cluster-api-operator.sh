#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "operator.cluster.x-k8s.io_addonproviders.yaml"
  "operator.cluster.x-k8s.io_bootstrapproviders.yaml"
  "operator.cluster.x-k8s.io_controlplaneproviders.yaml"
  "operator.cluster.x-k8s.io_coreproviders.yaml"
  "operator.cluster.x-k8s.io_infrastructureproviders.yaml"
  "operator.cluster.x-k8s.io_ipamproviders.yaml"
  "operator.cluster.x-k8s.io_runtimeextensionproviders.yaml"
)

# renovate: datasource=github-tags depName=kubernetes-sigs/cluster-api-operator
export VERSION=0.26.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/kubernetes-sigs/cluster-api-operator/refs/tags/v${VERSION}/config/crd/bases/${crd_file}"
}
