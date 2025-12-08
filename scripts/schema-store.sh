#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
[ -z "${SCRIPT_DIR}" ] && log_error "Invalid directory" && exit 1

source "${SCRIPT_DIR}/commons.sh"

APP=$1
source "${SCRIPT_DIR}/../crds/${APP}.sh"
log_info "[application] ${APP}: ${VERSION}"

JSON_SCHEMA_DIR="${SCRIPT_DIR}/../schemas"
CRD_DIR="${SCRIPT_DIR}/crds/${APP}"
mkdir -p "${CRD_DIR}"

case "${choice}" in
individual)
  for crd_file in "${FILES[@]}"; do
    crd_url=$(generate_url "${crd_file}")
    download_crd "${CRD_DIR}" "${crd_file}" "${crd_url}"
  done
  ;;
bundle)
  crd_url=$(generate_url)
  download_crd_bundle "${CRD_DIR}" "${crd_url}"
  ;;
kustomize)
  crd_url=$(generate_url)
  download_crd_kustomize "${CRD_DIR}" "${crd_url}"
  ;;
*)
  log_error "Invalid choice value: ${choice}. Must be 'individual' or 'bundle'."
  exit 1
  ;;
esac

for crd in "${FILES[@]}"; do
  crd_file="${CRD_DIR}/${crd}"
  manage_crd "${crd_file}" "${JSON_SCHEMA_DIR}"
done

rm -fr "${SCRIPT_DIR}/crds"
