#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=kustomize
export FILES=(
  "backups.postgresql.cnpg.io.yaml"
  "clusterimagecatalogs.postgresql.cnpg.io.yaml"
  "clusters.postgresql.cnpg.io.yaml"
  "databases.postgresql.cnpg.io.yaml"
  "failoverquorums.postgresql.cnpg.io.yaml"
  "imagecatalogs.postgresql.cnpg.io.yaml"
  "poolers.postgresql.cnpg.io.yaml"
  "publications.postgresql.cnpg.io.yaml"
  "scheduledbackups.postgresql.cnpg.io.yaml"
  "subscriptions.postgresql.cnpg.io.yaml"
)

# renovate: datasource=github-tags depName=cloudnative-pg/cloudnative-pg
export VERSION=1.27.1

function generate_url {
  echo "https://github.com/cloudnative-pg/cloudnative-pg/config/crd?ref=v${VERSION}"
}
