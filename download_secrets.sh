#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p "${DIR}/appbuilder/secrets"
aws s3 sync "${APPBUILDER_SECRETS_PATH}" "${DIR}/appbuilder/secrets"
