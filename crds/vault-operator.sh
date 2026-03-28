#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "secrets.hashicorp.com_csisecrets.yaml"
  "secrets.hashicorp.com_hcpauths.yaml"
  "secrets.hashicorp.com_hcpvaultsecretsapps.yaml"
  "secrets.hashicorp.com_secrettransformations.yaml"
  "secrets.hashicorp.com_vaultauthglobals.yaml"
  "secrets.hashicorp.com_vaultauths.yaml"
  "secrets.hashicorp.com_vaultconnections.yaml"
  "secrets.hashicorp.com_vaultdynamicsecrets.yaml"
  "secrets.hashicorp.com_vaultpkisecrets.yaml"
  "secrets.hashicorp.com_vaultstaticsecrets.yaml"
)

# renovate: datasource=github-tags depName=hashicorp/vault-secrets-operator
export VERSION=1.3.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/hashicorp/vault-secrets-operator/refs/tags/v${VERSION}/chart/crds/${crd_file}"
}
