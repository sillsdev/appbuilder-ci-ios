#!/bin/bash
set -x
security list-keychains -s appbuilder/appbuilder.keychain
security default-keychain -s appbuilder/appbuilder.keychain
security unlock-keychain -p "${KEYCHAIN_PASSWORD}" appbuilder/appbuilder.keychain
