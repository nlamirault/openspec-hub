#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "argoproj.io_eventbus.yaml"
  "argoproj.io_eventsources.yaml"
  "argoproj.io_sensors.yaml"
)

# renovate: datasource=github-tags depName=argoproj/argo-events
export VERSION=1.9.9

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/argoproj/argo-events/refs/tags/v${VERSION}/manifests/base/crds/${crd_file}"
}
