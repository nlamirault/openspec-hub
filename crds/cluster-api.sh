#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "addons.cluster.x-k8s.io_clusterresourcesetbindings.yaml"
  "addons.cluster.x-k8s.io_clusterresourcesets.yaml"
  "bootstrap.cluster.x-k8s.io_kubeadmconfigs.yaml"
  "bootstrap.cluster.x-k8s.io_kubeadmconfigtemplates.yaml"
  "cluster.x-k8s.io_clusterclasses.yaml"
  "cluster.x-k8s.io_clusters.yaml"
  "cluster.x-k8s.io_machinedeployments.yaml"
  "cluster.x-k8s.io_machinedrainrules.yaml"
  "cluster.x-k8s.io_machinehealthchecks.yaml"
  "cluster.x-k8s.io_machinepools.yaml"
  "cluster.x-k8s.io_machines.yaml"
  "cluster.x-k8s.io_machinesets.yaml"
  "clusterctl.cluster.x-k8s.io_metadata.yaml"
  "clusterctl.cluster.x-k8s.io_providers.yaml"
  "controlplane.cluster.x-k8s.io_kubeadmcontrolplanes.yaml"
  "controlplane.cluster.x-k8s.io_kubeadmcontrolplanetemplates.yaml"
  "ipam.cluster.x-k8s.io_ipaddressclaims.yaml"
  "ipam.cluster.x-k8s.io_ipaddresses.yaml"
  "runtime.cluster.x-k8s.io_extensionconfigs.yaml"
)

# renovate: datasource=github-tags depName=kubernetes-sigs/cluster-api
export VERSION=1.13.0

function generate_url {
  local crd_file=$1
  local base_url="https://raw.githubusercontent.com/kubernetes-sigs/cluster-api/refs/tags/v${VERSION}"

  case "${crd_file}" in
    bootstrap.*)
      echo "${base_url}/bootstrap/kubeadm/config/crd/bases/${crd_file}"
      ;;
    controlplane.*)
      echo "${base_url}/controlplane/kubeadm/config/crd/bases/${crd_file}"
      ;;
    clusterctl.*)
      echo "${base_url}/cmd/clusterctl/config/crd/bases/${crd_file}"
      ;;
    *)
      echo "${base_url}/config/crd/bases/${crd_file}"
      ;;
  esac
}
