#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
[ -z "${SCRIPT_DIR}" ] && echo "Invalid directory" && exit 1

# shellcheck disable=SC1091
source "${SCRIPT_DIR}/commons.sh"

SCHEMAS_DIR="${SCRIPT_DIR}/../schemas"
DRAFT="${DRAFT:-2020}"

if [[ ! -d "${SCHEMAS_DIR}" ]]; then
  log_error "Schemas directory not found: ${SCHEMAS_DIR}"
  exit 1
fi

if ! command -v jsonschema-cli &>/dev/null; then
  log_error "jsonschema-cli is not installed. Run: cargo install jsonschema-cli"
  exit 1
fi

log_info "[validate] Scanning schemas in: ${SCHEMAS_DIR}"
log_info "[validate] JSON Schema draft: ${DRAFT}"

total=0
failed=0
failed_files=()

while IFS= read -r schema_file; do
  total=$((total + 1))
  filename=$(basename ${schema_file})
  log_info "[schema] Validating: ${filename}"
  if ! jsonschema-cli validate --draft "${DRAFT}" "${schema_file}" 2>/dev/null; then
    log_warn "[schema] Invalid: ${filename} - File: ${schema_file}"
    failed_files+=("${schema_file}")
    failed=$((failed + 1))
    # exit
  fi
done < <(find "${SCHEMAS_DIR}" -name '*.json' -type f | sort)

log_info "[validate] Results: ${total} schemas checked, $((total - failed)) valid, ${failed} invalid"

if [[ "${failed}" -gt 0 ]]; then
  log_error "[validate] ${failed} schema file(s) failed validation:"
  for f in "${failed_files[@]}"; do
    log_error "  - ${f}"
  done
  exit 1
fi

log_info "[validate] All schemas are valid."
