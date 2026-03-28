#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "secrets.doppler.com_dopplersecrets.yaml"
)

# renovate: datasource=github-tags depName=DopplerHQ/kubernetes-operator
export VERSION=1.7.1

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/DopplerHQ/kubernetes-operator/refs/tags/v${VERSION}/config/crd/bases/${crd_file}"
}
