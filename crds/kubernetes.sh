#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=swagger

# renovate: datasource=github-tags depName=kubernetes/kubernetes
export VERSION=1.35.4

function generate_url {
  echo "https://raw.githubusercontent.com/kubernetes/kubernetes/refs/tags/v${VERSION}/api/openapi-spec/swagger.json"
}
