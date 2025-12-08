#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=bundle
export FILES=(
  "dragonflies.dragonflydb.io.yaml"
)

# renovate: datasource=github-tags depName=dragonflydb/dragonfly-operator
export VERSION=1.3.1

function generate_url {
  echo "https://raw.githubusercontent.com/dragonflydb/dragonfly-operator/refs/tags/v${VERSION}/manifests/crd.yaml"
}
