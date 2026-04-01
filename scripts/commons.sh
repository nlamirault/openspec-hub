#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

color_reset="\\e[0m"
color_blue="\\e[36m"
color_green="\\e[32m"
color_yellow="\\e[33m"
# shellcheck disable=SC2034
color_gray="\\e[90m"
color_red="\\e[31m"


# Define log levels
LOG_LEVEL_ERROR=0
LOG_LEVEL_WARN=1
LOG_LEVEL_INFO=2
LOG_LEVEL_DEBUG=3
LOG_LEVEL_TRACE=4

# Set default log level (can be overridden by env or arg)
LOG_LEVEL="${LOG_LEVEL:=$LOG_LEVEL_INFO}"

function log_trace { [ "${LOG_LEVEL_TRACE}" -le "${LOG_LEVEL}" ] && echo -e "${color_reset}⚪ $*${color_reset}" || true; }
function log_debug { [ "${LOG_LEVEL_DEBUG}" -le "${LOG_LEVEL}" ] && echo -e "${color_blue}🔵 $*${color_reset}" || true; }
function log_info { [ "${LOG_LEVEL_INFO}" -le "${LOG_LEVEL}" ] && echo -e "${color_green}🟢 $*${color_reset}" || true; }
function log_warn { [ "${LOG_LEVEL_WARN}" -le "${LOG_LEVEL}" ] && echo -e "${color_yellow}🟡 $*${color_reset}" || true; }
function log_error { [ "${LOG_LEVEL_ERROR}" -le "${LOG_LEVEL}" ] && echo -e "${color_red}🔴 $*${color_reset}" || true; }

function generate_json_schema {
  local crd_file=$1
  local json_dir=$2

  local group
  group=$(yq e '.spec.group' "${crd_file}" 2>/dev/null)
  [[ -z "$group" || "${group}" == "null" ]] && log_error "Invalid group in ${crd_file}" && return
  local kind
  kind=$(yq e '.spec.names.kind' "${crd_file}" 2>/dev/null | tr '[:upper:]' '[:lower:]')
  [[ -z "$kind" || "${kind}" == "null" ]] && log_error "Invalid kind in ${crd_file}" && return

  local output_path="${json_dir}/${group}"
  mkdir -p "${output_path}"

  local version_count
  version_count=$(yq e '.spec.versions | length' "${crd_file}" 2>/dev/null)
  log_debug "[crd] Group: ${group} / Kind: ${kind} / Versions: ${version_count}"

  for ((i = 0; i < version_count; i++)); do
    local version
    version=$(yq e ".spec.versions[${i}].name" "${crd_file}" 2>/dev/null)
    [[ -z "$version" || "${version}" == "null" ]] && continue
    local schema="${kind}_${version}.json"
    log_info "[openapi] Extract openAPIV3Schema: ${output_path}/${schema}"
    yq e ".spec.versions[${i}].schema.openAPIV3Schema" "${crd_file}" -o=json >"${output_path}/${schema}"
  done
}

function download_crd {
  local crd_dir=$1
  local file=$2
  local url=$3

  log_debug "[url] CRD to download: ${url}"
  if ! curl --silent --retry-all-errors --fail --location "${url}" >"${crd_dir}/${file}"; then
    log_error -e "Failed to download ${url}"
  fi
}

function download_crd_bundle {
  local crd_dir=$1
  local url=$2

  local bundle_file="bundle.yaml"
  log_debug "[url] Bundle file: ${url}"
  if ! curl --silent --retry-all-errors --fail --location "${url}" >"${crd_dir}/${bundle_file}"; then
    log_error "Failed to download ${url}"
  else
    [ ! -f "${crd_dir}/${bundle_file}" ] && log_error "Bundle file not exists" && exit 1
    kubectl slice -q -f "${crd_dir}/${bundle_file}" -t "{{.metadata.name}}.yaml" -o "${crd_dir}"
    rm "${crd_dir}/${bundle_file}"
  fi
}

function download_crd_kustomize {
  local crd_dir=$1
  local url=$2

  local bundle_file="bundle.yaml"
  log_debug "[url] Kustomize: ${url}"
  kustomize build "${url}" >"${crd_dir}/${bundle_file}"
  [ ! -f "${crd_dir}/${bundle_file}" ] && log_error "Bundle file not exists" && exit 1
  log_info "[kustomize] ${crd_dir}/${bundle_file}"
  kubectl slice -q -f "${crd_dir}/${bundle_file}" -t "{{.metadata.name}}.yaml" -o "${crd_dir}"
  rm "${crd_dir}/${bundle_file}"
}

function download_swagger {
  local swagger_dir=$1
  local url=$2

  log_debug "[url] Swagger: ${url}"
  curl -sSL "${url}" -o "${swagger_dir}/swagger.json"
}

function manage_crd {
  local crd_file=$1
  local jsonschema_dir=$2

  log_debug "[kubernetes] CRD file: ${crd_file}"
  local kind
  kind=$(yq e '.kind' "${crd_file}" 2>/dev/null)
  if [[ "${kind}" != "CustomResourceDefinition" ]]; then
    log_error "[kubernetes] Not a CRD (kind=${kind}): ${crd_file}"
    return 1
  fi
  generate_json_schema "${crd_file}" "${jsonschema_dir}"
}

function manage_swagger_file {
  local swagger_dir=$1
  local output_path=$2

  log_info "[Swagger] OpenAPI spec file: ${swagger_dir}/swagger.json"
  mkdir -p "${output_path}"

  jq -c '
    .definitions
    | to_entries[]
    | {
        raw_name: .key,
        schema: {
          "$schema": "http://json-schema.org/draft-07/schema#",
          "title": .key,
          "description": (if .value.description == null then empty else .value.description end),
          "type": "object",
          "properties": (if .value.properties == null then empty else .value.properties end),
          "required": (if .value.required == null then empty else .value.required end)
        }
      }
  ' "${swagger_dir}/swagger.json" |
    while IFS= read -r line; do

      raw=$(echo "$line" | jq -r '.raw_name')
      schema=$(echo "$line" | jq -r '.schema')

      IFS='.' read -ra parts <<<"$raw"
      kind="${parts[-1]}"
      version="${parts[-2]}"
      group="${parts[-3]}"
      dir="$output_path/${group}.api.k8s.io"
      mkdir -p "$dir"
      filename="${kind}_${version}.json"
      log_debug "[Swagger] In ${dir} ${filename}"
      echo "${schema}" | jq '.' >"${dir}/${filename}"

    done
}
