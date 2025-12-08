#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=kustomize
export FILES=(
  "backuppolicies.moco.cybozu.com.yaml"
  "mysqlclusters.moco.cybozu.com.yaml"
)

# renovate: datasource=github-tags depName=cybozu-go/moco
export VERSION=0.30.0

function generate_url {
  echo "https://github.com/cybozu-go/moco/config/crd?ref=v${VERSION}"
}
