#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=bundle
export FILES=(
  "alertmanagerconfigs.monitoring.coreos.com.yaml"
  "alertmanagers.monitoring.coreos.com.yaml"
  "podmonitors.monitoring.coreos.com.yaml"
  "probes.monitoring.coreos.com.yaml"
  "prometheusagents.monitoring.coreos.com.yaml"
  "prometheuses.monitoring.coreos.com.yaml"
  "prometheusrules.monitoring.coreos.com.yaml"
  "scrapeconfigs.monitoring.coreos.com.yaml"
  "servicemonitors.monitoring.coreos.com.yaml"
  "thanosrulers.monitoring.coreos.com.yaml"
)

# renovate: datasource=github-tags depName=external-secrets/external-secrets
VERSION=v1.3.2

function generate_url {
  echo "https://github.com/prometheus-operator/prometheus-operator/releases/download/v${VERSION}/bundle.yaml"
}
