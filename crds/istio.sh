#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=bundle
export FILES=(
  "authorizationpolicies.security.istio.io.yaml"
  "destinationrules.networking.istio.io.yaml"
  "envoyfilters.networking.istio.io.yaml"
  "gateways.networking.istio.io.yaml"
  "peerauthentications.security.istio.io.yaml"
  "proxyconfigs.networking.istio.io.yaml"
  "requestauthentications.security.istio.io.yaml"
  "serviceentries.networking.istio.io.yaml"
  "sidecars.networking.istio.io.yaml"
  "telemetries.telemetry.istio.io.yaml"
  "virtualservices.networking.istio.io.yaml"
  "wasmplugins.extensions.istio.io.yaml"
  "workloadentries.networking.istio.io.yaml"
  "workloadgroups.networking.istio.io.yaml"
)

# renovate: datasource=github-tags depName=istio/istio
export VERSION=1.28.2

function generate_url {
  echo "https://raw.githubusercontent.com/istio/istio/refs/tags/${VERSION}/manifests/charts/base/files/crd-all.gen.yaml"
}
