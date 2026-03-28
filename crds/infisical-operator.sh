#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "secrets.infisical.com_clustergenerators.yaml"
  "secrets.infisical.com_infisicaldynamicsecrets.yaml"
  "secrets.infisical.com_infisicalpushsecrets.yaml"
  "secrets.infisical.com_infisicalsecrets.yaml"
  "secrets.infisical.com_passwords.yaml"
  "secrets.infisical.com_uuids.yaml"
)

# renovate: datasource=github-tags depName=Infisical/kubernetes-operator
export VERSION=0.10.29

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/Infisical/kubernetes-operator/refs/tags/infisical-k8-operator/v${VERSION}/config/crd/bases/${crd_file}"
}
