#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "grafana.integreatly.org_grafanaalertrulegroups.yaml"
  "grafana.integreatly.org_grafanacontactpoints.yaml"
  "grafana.integreatly.org_grafanadashboards.yaml"
  "grafana.integreatly.org_grafanadatasources.yaml"
  "grafana.integreatly.org_grafanafolders.yaml"
  "grafana.integreatly.org_grafananotificationpolicies.yaml"
  "grafana.integreatly.org_grafanas.yaml"
)

# renovate: datasource=github-tags depName=grafana/grafana-operator
export VERSION=5.22.2

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/grafana/grafana-operator/refs/tags/v${VERSION}/deploy/helm/grafana-operator/files/crds/${crd_file}"
}
