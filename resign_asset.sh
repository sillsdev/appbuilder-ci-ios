#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

SIGNING_IDENTITY=$(security find-identity -p codesigning -v | grep Distribution | cut -d\" -f2)

# resign app
mkdir -p "${DIR}/result"
EXT="${APPBUILDER_ASSET##*.}"
APPBUILDER_APPSTORE_RESULT="${APPBUILDER_ASSET%.*}-appstore.${EXT}"
APPBUILDER_ADHOC_RESULT="${APPBUILDER_ASSET%.*}-adhoc.${EXT}"
./resign.sh "${DIR}/asset/${APPBUILDER_ASSET}" "${SIGNING_IDENTITY}" -p "${DIR}/appbuilder/secrets/appstore.mobileprovision" "${DIR}/result/${APPBUILDER_APPSTORE_RESULT}"
./resign.sh "${DIR}/asset/${APPBUILDER_ASSET}" "${SIGNING_IDENTITY}" -p "${DIR}/appbuilder/secrets/adhoc.mobileprovision" "${DIR}/result/${APPBUILDER_ADHOC_RESULT}"

