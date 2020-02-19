#!/bin/bash
security list-keychains -s "${TMPDIR}/appbuilder/appbuilder.keychain"
security default-keychain -s "${TMPDIR}/appbuilder/appbuilder.keychain"
security unlock-keychain -p "${KEYCHAIN_PASSWORD}" "${TMPDIR}/appbuilder/appbuilder.keychain"
