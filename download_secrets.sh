#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p "${DIR}/appbuilder/secrets"
aws s3 sync "${APPBUILDER_SECRETS_PATH}" "${DIR}/appbuilder/secrets"

cp "${DIR}/appbuilder/secrets/builder.env" "${HOME}/.env"
cp "${DIR}/appbuilder/secrets/builder.cred.json" "${HOME}/.cred.json"

# create keychain
security create-keychain -p $KEYCHAIN_PASSWORD "${DIR}/appbuilder/appbuilder.keychain"

# import resign certificate
CERTIFICATE_PASSWORD="$(cat "${DIR}/appbuilder/secrets/cert.txt")"
security import "${DIR}/appbuilder/secrets/cert.p12" -t agg -k "${DIR}/appbuilder/appbuilder.keychain" -P $CERTIFICATE_PASSWORD -A

# import builder certificate
CERTIFICATE_PASSWORD="$(cat "${DIR}/appbuilder/secrets/builder.txt")"
security import "${DIR}/appbuilder/secrets/builder.p12" -t agg -k "${DIR}/appbuilder/appbuilder.keychain" -P $CERTIFICATE_PASSWORD -A

# set keychain
security list-keychains -s "${DIR}/appbuilder/appbuilder.keychain"
security default-keychain -s "${DIR}/appbuilder/appbuilder.keychain"
security unlock-keychain -p "${KEYCHAIN_PASSWORD}" "${DIR}/appbuilder/appbuilder.keychain"
