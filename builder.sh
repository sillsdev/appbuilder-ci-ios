#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

(mkdir builder && cd builder && unzip "${DIR}/asset/builder.zip")
(mkdir -p builder/HTML && cd builder/HTML && unzip "${DIR}/asset/html.zip")
find builder -print
