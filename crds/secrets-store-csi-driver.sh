#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "secrets-store.csi.x-k8s.io_secretproviderclasses.yaml"
  "secrets-store.csi.x-k8s.io_secretproviderclasspodstatuses.yaml"
)

# renovate: datasource=github-tags depName=kubernetes-sigs/secrets-store-csi-driver
export VERSION=1.5.6

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/refs/tags/v${VERSION}/charts/secrets-store-csi-driver/crds/${crd_file}"
}
