#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "ec2.services.k8s.aws_capacityreservations.yaml"
  "ec2.services.k8s.aws_dhcpoptions.yaml"
  "ec2.services.k8s.aws_elasticipaddresses.yaml"
  "ec2.services.k8s.aws_flowlogs.yaml"
  "ec2.services.k8s.aws_instances.yaml"
  "ec2.services.k8s.aws_internetgateways.yaml"
  "ec2.services.k8s.aws_launchtemplates.yaml"
  "ec2.services.k8s.aws_natgateways.yaml"
  "ec2.services.k8s.aws_networkacls.yaml"
  "ec2.services.k8s.aws_routetables.yaml"
  "ec2.services.k8s.aws_securitygroups.yaml"
  "ec2.services.k8s.aws_subnets.yaml"
  "ec2.services.k8s.aws_transitgateways.yaml"
  "ec2.services.k8s.aws_transitgatewayvpcattachments.yaml"
  "ec2.services.k8s.aws_vpcendpoints.yaml"
  "ec2.services.k8s.aws_vpcendpointserviceconfigurations.yaml"
  "ec2.services.k8s.aws_vpcpeeringconnections.yaml"
  "ec2.services.k8s.aws_vpcs.yaml"
  "services.k8s.aws_fieldexports.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/ec2-controller
export VERSION=1.10.1

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/ec2-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
