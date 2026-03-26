#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=bundle
export FILES=(
  "acraccesstokens.generators.external-secrets.io.yaml"
  "clusterexternalsecrets.external-secrets.io.yaml"
  "clustersecretstores.external-secrets.io.yaml"
  "ecrauthorizationtokens.generators.external-secrets.io.yaml"
  "externalsecrets.external-secrets.io.yaml"
  "fakes.generators.external-secrets.io.yaml"
  "gcraccesstokens.generators.external-secrets.io.yaml"
  "githubaccesstokens.generators.external-secrets.io.yaml"
  "passwords.generators.external-secrets.io.yaml"
  "pushsecrets.external-secrets.io.yaml"
  "secretstores.external-secrets.io.yaml"
  "uuids.generators.external-secrets.io.yaml"
  "vaultdynamicsecrets.generators.external-secrets.io.yaml"
  "webhooks.generators.external-secrets.io.yaml"
)

# renovate: datasource=github-tags depName=external-secrets/external-secrets
export VERSION=v1.3.2

function generate_url {
  echo "https://raw.githubusercontent.com/external-secrets/external-secrets/${VERSION}/deploy/crds/bundle.yaml"
}
