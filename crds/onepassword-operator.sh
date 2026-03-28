#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "onepassword.com_onepassworditems.yaml"
)

# renovate: datasource=github-tags depName=1Password/onepassword-operator
export VERSION=1.12.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/1Password/onepassword-operator/refs/tags/v${VERSION}/config/crd/bases/${crd_file}"
}
