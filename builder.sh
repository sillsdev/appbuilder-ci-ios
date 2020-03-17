#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

(mkdir builder && cd builder && unzip -q "${DIR}/asset/builder.zip")
(mkdir -p builder/HTML && cd builder/HTML && unzip -q "${DIR}/asset/html.zip")

CSC_LINK="${DIR}/appbuilder/secrets/builder.p12"
export CSC_LINK
CSC_KEY_PASSWORD=$(cat "${DIR}/appbuilder/secrets/builder.txt")
export CSC_KEY_PASSWORD

cd builder
npm install
npm run build

cp -r dist/* "${DIR}/result/builder"
