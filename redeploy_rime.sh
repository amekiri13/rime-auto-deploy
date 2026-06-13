#!/usr/bin/env bash
set -euo pipefail

SQUIRREL_APP="/Library/Input Methods/Squirrel.app"
RIME_DIR="${HOME}/Library/Rime"
SHARED_DIR="${SQUIRREL_APP}/Contents/SharedSupport"
DEPLOYER="${SQUIRREL_APP}/Contents/MacOS/rime_deployer"
SQUIRREL="${SQUIRREL_APP}/Contents/MacOS/Squirrel"
SCHEMA="${RIME_DIR}/rime_ice.schema.yaml"
BUILD_DIR="${RIME_DIR}/build"

if [[ ! -x "${DEPLOYER}" ]]; then
  echo "rime_deployer not found: ${DEPLOYER}" >&2
  exit 1
fi

if [[ ! -x "${SQUIRREL}" ]]; then
  echo "Squirrel not found: ${SQUIRREL}" >&2
  exit 1
fi

if [[ ! -f "${SCHEMA}" ]]; then
  echo "Schema not found: ${SCHEMA}" >&2
  exit 1
fi

mkdir -p "${BUILD_DIR}"

echo "Compiling Rime schema..."
"${DEPLOYER}" --compile "${SCHEMA}" "${RIME_DIR}" "${SHARED_DIR}" "${BUILD_DIR}"

echo "Reloading Squirrel..."
"${SQUIRREL}" --reload

echo "Rime redeployed."
