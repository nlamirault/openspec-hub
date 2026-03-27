#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "sagemaker.services.k8s.aws_apps.yaml"
  "sagemaker.services.k8s.aws_dataqualityjobdefinitions.yaml"
  "sagemaker.services.k8s.aws_domains.yaml"
  "sagemaker.services.k8s.aws_endpointconfigs.yaml"
  "sagemaker.services.k8s.aws_endpoints.yaml"
  "sagemaker.services.k8s.aws_featuregroups.yaml"
  "sagemaker.services.k8s.aws_hyperparametertuningjobs.yaml"
  "sagemaker.services.k8s.aws_inferencecomponents.yaml"
  "sagemaker.services.k8s.aws_labelingjobs.yaml"
  "sagemaker.services.k8s.aws_modelbiasjobdefinitions.yaml"
  "sagemaker.services.k8s.aws_modelexplainabilityjobdefinitions.yaml"
  "sagemaker.services.k8s.aws_modelpackagegroups.yaml"
  "sagemaker.services.k8s.aws_modelpackages.yaml"
  "sagemaker.services.k8s.aws_modelqualityjobdefinitions.yaml"
  "sagemaker.services.k8s.aws_models.yaml"
  "sagemaker.services.k8s.aws_monitoringschedules.yaml"
  "sagemaker.services.k8s.aws_notebookinstancelifecycleconfigs.yaml"
  "sagemaker.services.k8s.aws_notebookinstances.yaml"
  "sagemaker.services.k8s.aws_pipelineexecutions.yaml"
  "sagemaker.services.k8s.aws_pipelines.yaml"
  "sagemaker.services.k8s.aws_processingjobs.yaml"
  "sagemaker.services.k8s.aws_projects.yaml"
  "sagemaker.services.k8s.aws_spaces.yaml"
  "sagemaker.services.k8s.aws_trainingjobs.yaml"
  "sagemaker.services.k8s.aws_transformjobs.yaml"
  "sagemaker.services.k8s.aws_userprofiles.yaml"
  "services.k8s.aws_fieldexports.yaml"
  "services.k8s.aws_iamroleselectors.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/sagemaker-controller
export VERSION=1.7.3

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/sagemaker-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}
