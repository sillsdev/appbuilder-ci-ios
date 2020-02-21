#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# import certificate
mkdir -p "${DIR}/appbuilder/secrets"
aws s3 sync s3://sil-stg-aps-secrets/travis/build "${DIR}/appbuilder/secrets"
security create-keychain -p $KEYCHAIN_PASSWORD "${DIR}/appbuilder/appbuilder.keychain"
security import "${DIR}/appbuilder/secrets/Certificates.p12" -t agg -k "${DIR}/appbuilder/appbuilder.keychain" -P $CERTIFICATE_PASSWORD -A

# set keychain
security list-keychains -s "${DIR}/appbuilder/appbuilder.keychain"
security default-keychain -s "${DIR}/appbuilder/appbuilder.keychain"
security unlock-keychain -p "${KEYCHAIN_PASSWORD}" "${DIR}/appbuilder/appbuilder.keychain"

# download asset
mkdir asset
aws s3 sync s3://cth-dev-aps-artifacts/travis asset

# resign app
./resign.sh asset/WEB-1.4.ipa "iPhone Distribution: Chris Hubbard (5P99T946M7)" -p "${DIR}/appbuilder/secrets/app.mobileprovision" asset/WEB-1.4-resigned.ipa

# upload result
aws s3 sync asset s3://cth-dev-aps-artifacts/travis
