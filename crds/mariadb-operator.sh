#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=kustomize
export FILES=(
  "backups.k8s.mariadb.com.yaml"
  "connections.k8s.mariadb.com.yaml"
  "databases.k8s.mariadb.com.yaml"
  "externalmariadbs.k8s.mariadb.com.yaml"
  "grants.k8s.mariadb.com.yaml"
  "mariadbs.k8s.mariadb.com.yaml"
  "maxscales.k8s.mariadb.com.yaml"
  "physicalbackups.k8s.mariadb.com.yaml"
  "restores.k8s.mariadb.com.yaml"
  "sqljobs.k8s.mariadb.com.yaml"
  "users.k8s.mariadb.com.yaml"
)

# renovate: datasource=github-tags depName=mariadb-operator/mariadb-operator
export VERSION=v25.10.4

function generate_url {
  echo "https://github.com/mariadb-operator/mariadb-operator/config/crd?ref=v${VERSION}"
}
