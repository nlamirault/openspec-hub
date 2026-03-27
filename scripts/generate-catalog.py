import os
import json
import re

def generate_catalog(schemas_dir, output_dir):
    catalog = {"groups": {}}
    titles = {}

    for root, dirs, files in os.walk(schemas_dir):
        for file in files:
            if file.endswith(".json"):
                file_path = os.path.join(root, file)
                rel_path = os.path.relpath(file_path, schemas_dir)

                # Extract group from directory name
                group = os.path.basename(root)

                # Parse Kind and Version from filename (Kind_Version.json)
                match = re.match(r"(.+)_([vV]\w+)\.json", file)
                if match:
                    raw_kind, version = match.groups()
                    # Try to get the proper Kind from the JSON title if possible
                    kind = raw_kind

                    if group not in catalog["groups"]:
                        catalog["groups"][group] = []

                    try:
                        with open(file_path, 'r') as f:
                            content = f.read()
                            decoder = json.JSONDecoder()
                            data, _ = decoder.raw_decode(content)
                            title = data.get("title", "")
                            if title and "." in title:
                                kind = title.split(".")[-1]

                            catalog["groups"][group].append({
                                "kind": kind,
                                "version": version,
                                "file": rel_path,
                                "slug": f"{group}/{version}/{kind}"
                            })

                            # Store title mapping
                            if title:
                                titles[title] = rel_path
                    except Exception as e:
                        print(f"Error parsing {file_path} for metadata: {e}")

    # Sort groups and resources
    sorted_catalog = {"groups": {}}
    for group in sorted(catalog["groups"].keys()):
        resources = sorted(catalog["groups"][group], key=lambda x: (x["kind"], x["version"]))
        sorted_catalog["groups"][group] = resources

    # Create output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)

    with open(os.path.join(output_dir, "catalog.json"), "w") as f:
        json.dump(sorted_catalog, f, indent=2)

    with open(os.path.join(output_dir, "titles.json"), "w") as f:
        json.dump(titles, f, indent=2)

    print(f"Catalog generated in {output_dir}")

if __name__ == "__main__":
    generate_catalog("schemas", "public/data")
