#!/usr/bin/env python3

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

"""Rewrite broken #/definitions/$ref pointers in split Kubernetes API schema files.

When manage_swagger_file splits the monolithic kubernetes swagger.json into
individual per-type files, internal $ref values like:
  "#/definitions/io.k8s.api.admissionregistration.v1.ValidatingWebhookConfiguration"
become broken because each file has no 'definitions' section.

This script rewrites them to relative file paths, e.g.:
  "ValidatingWebhookConfiguration_v1.json"            (same group)
  "../meta.api.k8s.io/ListMeta_v1.json"               (different group)
"""

import json
import os
import sys


def def_name_to_path(def_name: str) -> tuple[str, str]:
    """Parse a Kubernetes swagger definition name into (dir_name, file_name).

    Examples:
      io.k8s.api.admissionregistration.v1.ValidatingWebhookConfiguration
        -> admissionregistration.api.k8s.io/ValidatingWebhookConfiguration_v1.json
      io.k8s.apimachinery.pkg.apis.meta.v1.ListMeta
        -> meta.api.k8s.io/ListMeta_v1.json
      io.k8s.apimachinery.pkg.api.resource.Quantity
        -> api.api.k8s.io/Quantity_resource.json
    """
    parts = def_name.split(".")
    kind = parts[-1]
    version = parts[-2]
    group = parts[-3]
    return f"{group}.api.k8s.io", f"{kind}_{version}.json"


def fix_refs(obj: object, source_dir: str, schemas_dir: str) -> object:
    if isinstance(obj, dict):
        result = {}
        for k, v in obj.items():
            if k == "$ref" and isinstance(v, str) and v.startswith("#/definitions/"):
                def_name = v[len("#/definitions/"):]
                target_dir, target_file = def_name_to_path(def_name)
                target_path = os.path.join(schemas_dir, target_dir, target_file)
                if os.path.exists(target_path):
                    result[k] = os.path.relpath(target_path, source_dir)
                else:
                    result[k] = v  # leave unchanged if target file not found
            else:
                result[k] = fix_refs(v, source_dir, schemas_dir)
        return result
    elif isinstance(obj, list):
        return [fix_refs(item, source_dir, schemas_dir) for item in obj]
    return obj


def main(schemas_dir: str) -> None:
    schemas_dir = os.path.abspath(schemas_dir)
    fixed = 0
    skipped = 0

    for root, _, files in os.walk(schemas_dir):
        for fname in sorted(files):
            if not fname.endswith(".json"):
                continue
            fpath = os.path.join(root, fname)
            with open(fpath) as f:
                try:
                    schema = json.load(f)
                except json.JSONDecodeError:
                    skipped += 1
                    continue

            new_schema = fix_refs(schema, root, schemas_dir)
            if new_schema != schema:
                with open(fpath, "w") as f:
                    json.dump(new_schema, f, indent=2)
                    f.write("\n")
                fixed += 1

    print(f"Fixed $ref pointers in {fixed} schema files ({skipped} skipped)")


if __name__ == "__main__":
    schemas_dir = sys.argv[1] if len(sys.argv) > 1 else "schemas"
    main(schemas_dir)
