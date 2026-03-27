# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

BANNER = O P E N S P E C   H U B

SHELL = /bin/bash -o pipefail

DIR = $(shell pwd)

NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m
INFO_COLOR=\033[36m
WHITE_COLOR=\033[1m

MAKE_COLOR=\033[33;01m%-20s\033[0m

.DEFAULT_GOAL := help

DEBUG=[🔵]
INFO=[🟢]
WARN=[🟠]
ERROR=[🔴]

.PHONY: help
help:
	@echo -e "$(OK_COLOR)               $(BANNER)$(NO_COLOR)"
	@echo "------------------------------------------------------------------"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make ${INFO_COLOR}<target>${NO_COLOR}\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  ${INFO_COLOR}%-25s${NO_COLOR} %s\n", $$1, $$2 } /^##@/ { printf "\n${WHITE_COLOR}%s${NO_COLOR}\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""

guard-%:
	@if [ "${${*}}" = "" ]; then \
		echo -e "$(ERROR_COLOR)Environment variable $* not set$(NO_COLOR)"; \
		exit 1; \
	fi

check-%:
	@if $$(hash $* 2> /dev/null); then \
		echo -e "$(OK_COLOR)$(INFO)$(NO_COLOR) $*"; \
	else \
		echo -e "$(ERROR_COLOR)$(ERROR)$(NO_COLOR) $*"; \
	fi

##@ Development

.PHONY: init
init: ## Initialize environment
	uv venv && uv pip install

.PHONY: build
build: guard-CRD ## Update CRD for an application
	@scripts/schema-store.sh $$(basename "${CRD}" .sh)
