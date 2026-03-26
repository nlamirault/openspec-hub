#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=kustomize
export FILES=(
  # "core.openfeature.dev_featureflagconfigurations.yaml"
  # "core.openfeature.dev_featureflags.yaml"
  # "core.openfeature.dev_featureflagsources.yaml"
  # "core.openfeature.dev_flagds.yaml"
  # "core.openfeature.dev_flagsourceconfigurations.yaml"
  # "core.openfeature.dev_inprocessconfigurations.yaml"
  "featureflags.core.openfeature.dev.yaml"
  "featureflagsources.core.openfeature.dev.yaml"
  "flagds.core.openfeature.dev.yaml"
  "inprocessconfigurations.core.openfeature.dev.yaml"
)

# renovate: datasource=github-tags depName=open-feature/open-feature-operator
export VERSION=0.8.9

function generate_url {
  echo "https://github.com/open-feature/open-feature-operator/config/crd?ref=v${VERSION}"
  # echo "https://github.com/open-telemetry/opentelemetry-operator/config/crd?ref=v${VERSION}"
}
