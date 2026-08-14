#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
CATALOG_PATH="${PROJECT_ROOT}/SnowVillage.docc"

if [[ ! -d "${CATALOG_PATH}" ]]; then
    echo "DocC catalog not found: ${CATALOG_PATH}" >&2
    exit 1
fi

xcrun docc preview "${CATALOG_PATH}" --port 8080
