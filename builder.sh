#!/bin/bash

mkdir builder && cd builder && unzip ../builder.zip
mkdir -p build/HTML && cd builder/HTML && unzip ../../html.zip
find . -print

