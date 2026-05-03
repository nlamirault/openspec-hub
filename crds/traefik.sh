#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=bundle
export FILES=(
  "ingressroutes.traefik.io.yaml"
  "ingressroutetcps.traefik.io.yaml"
  "ingressrouteudps.traefik.io.yaml"
  "middlewares.traefik.io.yaml"
  "middlewaretcps.traefik.io.yaml"
  "serverstransports.traefik.io.yaml"
  "serverstransporttcps.traefik.io.yaml"
  "tlsoptions.traefik.io.yaml"
  "tlsstores.traefik.io.yaml"
  "traefikservices.traefik.io.yaml"
)

# renovate: datasource=github-tags depName=traefik/traefik
export VERSION=3.6.15

function generate_url {
  echo "https://raw.githubusercontent.com/traefik/traefik/v${VERSION}/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml"
}
