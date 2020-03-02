#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

aws s3 sync "${DIR}/result" "${APPBUILDER_ASSET_RESULT_PATH}"
