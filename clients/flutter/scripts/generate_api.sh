#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$DIR/.."
API_SPEC="$PROJECT_ROOT/../../openapi/OMSA.yaml"
OUTPUT_DIR="$PROJECT_ROOT/packages/omsa_api"

echo "Generating Dart OMSA package from $API_SPEC..."

mkdir -p "$OUTPUT_DIR"

# Generate Dart package
npx -y @openapitools/openapi-generator-cli generate \
  -i "$API_SPEC" \
  -g dart \
  -o "$OUTPUT_DIR" \
  --additional-properties=pubName=omsa_api,pubVersion=1.0.0,pubDescription=OMSA_Dart_Client \
  --enable-post-process-file

echo "Running pub get in generated package..."
cd "$OUTPUT_DIR"
flutter pub get
flutter format . || true 

echo "Done generating Dart OMSA package at $OUTPUT_DIR"
