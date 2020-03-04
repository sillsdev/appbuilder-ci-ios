#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# import certificate
CERTIFICATE_PASSWORD="$(cat "${DIR}/appbuilder/secrets/cert.txt")"
security create-keychain -p $KEYCHAIN_PASSWORD "${DIR}/appbuilder/appbuilder.keychain"
security import "${DIR}/appbuilder/secrets/cert.p12" -t agg -k "${DIR}/appbuilder/appbuilder.keychain" -P $CERTIFICATE_PASSWORD -A

# set keychain
security list-keychains -s "${DIR}/appbuilder/appbuilder.keychain"
security default-keychain -s "${DIR}/appbuilder/appbuilder.keychain"
security unlock-keychain -p "${KEYCHAIN_PASSWORD}" "${DIR}/appbuilder/appbuilder.keychain"
SIGNING_IDENTITY=$(security find-identity -p codesigning -v | grep "^  \d)" | cut -d\" -f2)

# resign app
mkdir -p "${DIR}/result"
EXT="${APPBUILDER_ASSET##*.}"
APPBUILDER_APPSTORE_RESULT="${APPBUILDER_ASSET%.*}-appstore.${EXT}"
APPBUILDER_ADHOC_RESULT="${APPBUILDER_ASSET%.*}-adhoc.${EXT}"
./resign.sh "${DIR}/asset/${APPBUILDER_ASSET}" "${SIGNING_IDENTITY}" -p "${DIR}/appbuilder/secrets/appstore.mobileprovision" "${DIR}/result/${APPBUILDER_APPSTORE_RESULT}"
./resign.sh "${DIR}/asset/${APPBUILDER_ASSET}" "${SIGNING_IDENTITY}" -p "${DIR}/appbuilder/secrets/adhoc.mobileprovision" "${DIR}/result/${APPBUILDER_ADHOC_RESULT}"

