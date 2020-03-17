#!/bin/bash

mkdir builder && cd builder && unzip ../asset/builder.zip
mkdir -p builder/HTML && cd builder/HTML && unzip ../../asset/html.zip
find builder -print
