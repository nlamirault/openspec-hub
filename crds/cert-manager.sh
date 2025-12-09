#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "acme.cert-manager.io_challenges.yaml"
  "acme.cert-manager.io_orders.yaml"
  "cert-manager.io_certificaterequests.yaml"
  "cert-manager.io_certificates.yaml"
  "cert-manager.io_clusterissuers.yaml"
  "cert-manager.io_issuers.yaml"
)

# renovate: datasource=github-tags depName=cert-manager/cert-manager
export VERSION=1.19.2

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/cert-manager/cert-manager/refs/tags/v${VERSION}/deploy/crds/${crd_file}"
}
