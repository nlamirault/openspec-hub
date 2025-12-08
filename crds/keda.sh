#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=bundle
export FILES=(
  "cloudeventsources.eventing.keda.sh.yaml"
  "clustercloudeventsources.eventing.keda.sh.yaml"
  "clustertriggerauthentications.keda.sh.yaml"
  "scaledjobs.keda.sh.yaml"
  "scaledobjects.keda.sh.yaml"
  "triggerauthentications.keda.sh.yaml"
)

# renovate: datasource=github-tags depName=kedacore/keda
export VERSION=2.18.2

function generate_url {
  echo "https://github.com/kedacore/keda/releases/download/v${VERSION}/keda-${VERSION}-crds.yaml"
}
