#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "ciliumbgpadvertisements.yaml"
  "ciliumbgpclusterconfigs.yaml"
  "ciliumbgpnodeconfigoverrides.yaml"
  "ciliumbgpnodeconfigs.yaml"
  "ciliumbgppeerconfigs.yaml"
  "ciliumcidrgroups.yaml"
  "ciliumclusterwideenvoyconfigs.yaml"
  "ciliumclusterwidenetworkpolicies.yaml"
  "ciliumegressgatewaypolicies.yaml"
  "ciliumendpoints.yaml"
  "ciliumenvoyconfigs.yaml"
  "ciliumidentities.yaml"
  "ciliumloadbalancerippools.yaml"
  "ciliumlocalredirectpolicies.yaml"
  "ciliumnetworkpolicies.yaml"
  "ciliumnodeconfigs.yaml"
  "ciliumnodes.yaml"
  "ciliumendpointslices.yaml"
  "ciliumgatewayclassconfigs.yaml"
  "ciliuml2announcementpolicies.yaml"
  "ciliumpodippools.yaml"
)

# renovate: datasource=github-tags depName=cilium/cilium
export VERSION=v1.19.3

function generate_url {
  local crd_file=$1
  local subdir
  case "${crd_file}" in
    ciliumendpointslices.yaml | ciliumgatewayclassconfigs.yaml | ciliuml2announcementpolicies.yaml | ciliumpodippools.yaml)
      subdir="v2alpha1"
      ;;
    *)
      subdir="v2"
      ;;
  esac
  echo "https://raw.githubusercontent.com/cilium/cilium/v${VERSION}/pkg/k8s/apis/cilium.io/client/crds/${subdir}/${crd_file}"
}
