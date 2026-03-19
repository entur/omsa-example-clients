import os
import re

def fix_generated_models():
    # Script is in clients/flutter/scripts/fix_generated_models.py
    # Package is in clients/flutter/packages/omsa_api
    script_dir = os.path.dirname(os.path.abspath(__file__))
    api_pkg_path = os.path.abspath(os.path.join(script_dir, "../packages/omsa_api"))
    model_path = os.path.join(api_pkg_path, "lib/model")

    if not os.path.exists(model_path):
        print(f"Error: Model path {model_path} not found.")
        return

    # 1. Fix DataType and MetadataOneOf1Value
    for filename in ["data_type.dart", "metadata_one_of1_value.dart"]:
        filepath = os.path.join(model_path, filename)
        if os.path.exists(filepath):
            with open(filepath, 'r') as f:
                content = f.read()

            class_name = filename.replace(".dart", "").replace("_", " ").title().replace(" ", "")
            # Special case for MetadataOneOf1Value casing
            if "metadata_one_of1_value" in filename:
                class_name = "MetadataOneOf1Value"

            print(f"Fixing {filename}...")
            
            # Fix empty constructor
            content = re.sub(
                rf"{class_name}\({{\s*}}\);",
                f"{class_name}();",
                content
            )

            # Fix broken operator == and hashCode
            # The generator produce: 
            # bool operator ==(Object other) => identical(this, other) || other is DataType &&
            # (empty or broken lines)
            
            op_match_str = rf"bool operator ==\(Object other\) => identical\(this, other\) \|\| other is {class_name} &&\s+@override"
            # It's actually more broken than that. Let's use a broader match.
            
            content = re.sub(
                rf"bool operator ==\(Object other\) => identical\(this, other\) \|\| other is {class_name} &&.*?\s+@override",
                f"bool operator ==(Object other) => identical(this, other) || other is {class_name};\n\n  @override",
                content,
                flags=re.DOTALL
            )

            content = re.sub(
                r"int get hashCode =>\s+// ignore: unnecessary_parenthesis\s+@override",
                "int get hashCode => runtimeType.hashCode;\n\n  @override",
                content,
                flags=re.DOTALL
            )
            
            # Final touch for empty constructors if they are multi-line
            content = re.sub(
                rf"{class_name}\({{\s*}}\);",
                f"{class_name}();",
                content,
                flags=re.DOTALL
            )

            with open(filepath, 'w') as f:
                f.write(content)

    # 2. Fix GeoJSON models
    geojson_fixes = {
        "geojson_polygon.dart": {
            "target": r"coordinates: json\[r'coordinates'\] is List\s+\? \(json\[r'coordinates'\] as List\).map\(\(e\) =>\s+List\.listFromJson\(json\[r'coordinates'\]\)\s+\)\.toList\(\)\s+:  const \[\],",
            "replacement": """coordinates: json[r'coordinates'] is List
          ? (json[r'coordinates'] as List).map<List<List<double>>>((e) =>
              (e as List).map<List<double>>((e) =>
                (e as List).cast<double>().toList()
              ).toList()
            ).toList()
          :  const [],"""
        },
        "geojson_feature_geometry.dart": {
            "target": r"coordinates: json\[r'coordinates'\] is List\s+\? \(json\[r'coordinates'\] as List\).map\(\(e\) =>\s+List\.listFromJson\(json\[r'coordinates'\]\)\s+\)\.toList\(\)\s+:  const \[\],",
            "replacement": """coordinates: json[r'coordinates'] is List
          ? (json[r'coordinates'] as List).map<List<List<List<double>>>>((e) =>
              (e as List).map<List<List<double>>>((e) =>
                (e as List).map<List<double>>((e) =>
                  (e as List).cast<double>().toList()
                ).toList()
              ).toList()
            ).toList()
          :  const [],"""
        },
        "geojson_multi_polygon.dart": {
            "target": r"coordinates: json\[r'coordinates'\] is List\s+\? \(json\[r'coordinates'\] as List\).map\(\(e\) =>\s+List\.listFromJson\(json\[r'coordinates'\]\)\s+\)\.toList\(\)\s+:  const \[\],",
            "replacement": """coordinates: json[r'coordinates'] is List
          ? (json[r'coordinates'] as List).map<List<List<List<double>>>>((e) =>
              (e as List).map<List<List<double>>>((e) =>
                (e as List).map<List<double>>((e) =>
                  (e as List).cast<double>().toList()
                ).toList()
              ).toList()
            ).toList()
          :  const [],"""
        }
    }

    for filename, fix in geojson_fixes.items():
        filepath = os.path.join(model_path, filename)
        if os.path.exists(filepath):
            print(f"Fixing {filename}...")
            with open(filepath, 'r') as f:
                content = f.read()
            
            new_content = re.sub(fix["target"], fix["replacement"], content, flags=re.DOTALL)
            
            if new_content == content:
                # Fallback: maybe it was already partially fixed or the generator output changed slightly
                print(f"  Warning: Exact pattern match failed for {filename}, checking fallback for already broken state.")
                # This handles my previous partially broken maps
                item_pattern = r"coordinates: json\[r'coordinates'\] is List.*?const \[\],"
                new_content = re.sub(item_pattern, fix["replacement"], content, flags=re.DOTALL)

            with open(filepath, 'w') as f:
                f.write(new_content)

    # 3. Final cleanup of stale files
    stale_files = ["select_offers_input_selections_inner.dart"]
    for filename in stale_files:
        filepath = os.path.join(model_path, filename)
        if os.path.exists(filepath):
            print(f"Removing stale file {filename}...")
            os.remove(filepath)

if __name__ == "__main__":
    fix_generated_models()
