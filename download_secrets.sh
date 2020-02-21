#!/bin/bash
mkdir -p "${DIR}/appbuilder/secrets"
aws s3 sync s3://sil-stg-aps-secrets/travis/build "${DIR}/appbuilder/secrets"
