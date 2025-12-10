#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "gateway.networking.k8s.io_gatewayclasses.yaml"
  "gateway.networking.k8s.io_gateways.yaml"
  "gateway.networking.k8s.io_grpcroutes.yaml"
  "gateway.networking.k8s.io_httproutes.yaml"
  "gateway.networking.k8s.io_referencegrants.yaml"
)

# renovate: datasource=github-tags depName=kubernetes-sigs/gateway-api
export VERSION=1.4.1

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v${VERSION}/config/crd/standard/${crd_file}"
}
