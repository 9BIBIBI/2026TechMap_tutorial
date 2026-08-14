#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
CATALOG_PATH="${PROJECT_ROOT}/SnowVillage.docc"
OUTPUT_PATH="${PROJECT_ROOT}/docs"
HOSTING_BASE_PATH="2026TechMap_tutorial"

if [[ ! -d "${CATALOG_PATH}" ]]; then
    echo "DocC catalog not found: ${CATALOG_PATH}" >&2
    exit 1
fi

if [[ "${OUTPUT_PATH}" != "${PROJECT_ROOT}/docs" || -z "${PROJECT_ROOT}" ]]; then
    echo "Unexpected output path: ${OUTPUT_PATH}" >&2
    exit 1
fi

if [[ -e "${OUTPUT_PATH}" ]]; then
    rm -rf "${OUTPUT_PATH}"
fi

xcrun docc convert "${CATALOG_PATH}" \
    --output-path "${OUTPUT_PATH}" \
    --transform-for-static-hosting \
    --hosting-base-path "${HOSTING_BASE_PATH}" \
    --warnings-as-errors

touch "${OUTPUT_PATH}/.nojekyll"

echo "Built static DocC site: ${OUTPUT_PATH}"
echo "Tutorial route: /${HOSTING_BASE_PATH}/tutorials/snowvillage/"
