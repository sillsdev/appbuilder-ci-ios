#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p "${DIR}/asset"
aws s3 sync "${APPBUILDER_ASSET_DOWNLOAD_PATH}" "${DIR}/asset"
