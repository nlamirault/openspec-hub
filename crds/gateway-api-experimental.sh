#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "gateway.networking.k8s.io_backendtlspolicies.yaml"
  "gateway.networking.k8s.io_tcproutes.yaml"
  "gateway.networking.k8s.io_tlsroutes.yaml"
  "gateway.networking.k8s.io_udproutes.yaml"
  "gateway.networking.x-k8s.io_xbackendtrafficpolicies.yaml"
  "gateway.networking.x-k8s.io_xlistenersets.yaml"
  "gateway.networking.x-k8s.io_xmeshes.yaml"
)

# renovate: datasource=github-tags depName=kubernetes-sigs/gateway-api
export VERSION=1.4.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v${VERSION}/config/crd/experimental/${crd_file}"
}
