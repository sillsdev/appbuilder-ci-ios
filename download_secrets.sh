#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p "${DIR}/appbuilder/secrets"
aws s3 sync s3://sil-stg-aps-secrets/travis/build "${DIR}/appbuilder/secrets"
