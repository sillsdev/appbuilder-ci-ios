#!/bin/bash
set -x

# import certificate
mkdir -p appbuilder/secrets
aws s3 sync s3://sil-stg-aps-secrets/travis/build appbuilder/secrets
ls -l appbuilder/secrets
security create-keychain -p $KEYCHAIN_PASSWORD appbuilder/appbuilder.keychain
security import appbuilder/secrets/Certificates.p12 -t agg -k appbuilder/appbuilder.keychain -P $CERTIFICATE_PASSWORD -A

# set keychain
security list-keychains -s appbuilder/appbuilder.keychain
security default-keychain -s appbuilder/appbuilder.keychain
security unlock-keychain -p \"${KEYCHAIN_PASSWORD}\" appbuilder/appbuilder.keychain

# download asset
mkdir asset
aws s3 sync s3://cth-dev-aps-artifacts/travis asset

# resign app
./resign.sh asset/WEB-1.4.ipa "iPhone Distribution: Chris Hubbard (5P99T946M7)" -p appbuilder/secrets/app.mobileprovision asset/WEB-1.4-resigned.ipa

# upload result
aws s3 sync asset s3://cth-dev-aps-artifacts/travis
