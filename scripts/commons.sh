#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

reset_color="\\e[0m"
color_red="\\e[31m"
color_green="\\e[32m"
color_blue="\\e[36m"
color_yellow="\\e[33m"

# Define log levels
LOG_LEVEL_ERROR=0
LOG_LEVEL_WARN=1
LOG_LEVEL_INFO=2
LOG_LEVEL_DEBUG=3
LOG_LEVEL_TRACE=4

# Set default log level (can be overridden by env or arg)
LOG_LEVEL="${LOG_LEVEL:=$LOG_LEVEL_INFO}"

function log_trace { [ "${LOG_LEVEL_TRACE}" -le "${LOG_LEVEL}" ] && echo -e "${color_blue}🟡 $*${reset_color}"; }
function log_debug { [ "${LOG_LEVEL_DEBUG}" -le "${LOG_LEVEL}" ] && echo -e "${color_blue}🔵 $*${reset_color}"; }
function log_info { [ "${LOG_LEVEL_INFO}" -le "${LOG_LEVEL}" ] && echo -e "${color_green}🟢 $*${reset_color}"; }
function log_warn { [ "${LOG_LEVEL_WARN}" -le "${LOG_LEVEL}" ] && echo -e "${color_yellow}🟠 $*${reset_color}"; }
function log_error { [ "${LOG_LEVEL_ERROR}" -le "${LOG_LEVEL}" ] && echo -e "${color_red}🔴 $*${reset_color}"; }

function generate_output_filename {
  local crd_file=$1

  local group=$(yq e '.spec.group' "${crd_file}" 2>/dev/null)
  [[ -z "$group" || "${group}" == "null" ]] && return
  local kind=$(yq e '.spec.names.kind' "${crd_file}" 2>/dev/null)
  local version=$(yq e '.spec.versions[0].name' "${crd_file}" 2>/dev/null)
  [[ -n "$kind" && -n "${version}" ]] && echo "${group}/${kind}_${version}.json" | tr '[:upper:]' '[:lower:]'
}

function generate_json_schema {
  local crd_file=$1
  local json_dir=$2

  log_debug "[io] Generate output filename from ${crd_file}"
  output_file=$(generate_output_filename "${crd_file}")
  group=$(dirname "${output_file}")
  [ "${group}" == "." ] && log_error "Invalid group" && return
  schema=$(basename "${output_file}")
  [ "${schema}" == "." ] && log_error "Invalid schema" && return
  log_info "[crd] Group: ${group} / Schema: ${schema}"
  output_path="${json_dir}/${group}"
  mkdir -p "${output_path}"
  log_info "[openapi] Extract openAPIV3Schema and convert to JSON: ${output_path}"
  yq e '.spec.versions[].schema.openAPIV3Schema' "${crd_file}" -o=json >"${output_path}/${schema}"
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
    [ -f "${crd_dir}/${bundle_file}}" ] && log_error "Bundle file not exists" && exit 1
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
  [ -f "${crd_dir}/${bundle_file}}" ] && log_error "Bundle file not exists" && exit 1
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
  yq e '.kind == "CustomResourceDefinition"' "${crd_file}" &>/dev/null
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
        name: .key,
        schema: {
          "$schema": "http://json-schema.org/draft-07/schema#",
          "title": .key,
          "description": .value.description,
          "type": "object",
          "properties": .value.properties,
          "required": .value.required
        }
      }
  ' swagger.json |
    while IFS= read -r line; do
      name=$(echo "$line" | jq -r '.name')
      schema=$(echo "$line" | jq -r '.schema')
      log_debug "[Swagger] ${name}.json"
      echo "$schema" | jq '.' >"${output_path}/$name.json"
    done
}
