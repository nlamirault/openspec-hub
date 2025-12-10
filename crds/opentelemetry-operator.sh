#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=kustomize
export FILES=(
  "instrumentations.opentelemetry.io.yaml"
  "opampbridges.opentelemetry.io.yaml"
  "opentelemetrycollectors.opentelemetry.io.yaml"
  "targetallocators.opentelemetry.io.yaml"
)

# renovate: datasource=github-tags depName=open-telemetry/opentelemetry-operator
export VERSION=0.141.0

function generate_url {
  echo "https://github.com/open-telemetry/opentelemetry-operator/config/crd?ref=v${VERSION}"
}
