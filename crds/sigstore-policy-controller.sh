#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "policy.sigstore.dev_clusterimagepolicies.yaml"
  "policy.sigstore.dev_trustroots.yaml"
)

# renovate: datasource=github-tags depName=sigstore/policy-controller
export VERSION=0.9.0

function generate_url {
  local crd_file=$1
  local name
  if [[ "${crd_file}" == *"clusterimagepolicies"* ]]; then
    name="300-clusterimagepolicy.yaml"
  else
    name="300-trustroot.yaml"
  fi
  echo "https://raw.githubusercontent.com/sigstore/policy-controller/refs/tags/v${VERSION}/config/${name}"
}
