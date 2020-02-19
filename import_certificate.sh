#!/bin/bash
set -x
mkdir -p appbuilder/secrets
aws s3 sync s3://sil-stg-aps-secrets/travis/build appbuilder/secrets
ls -l appbuilder/secrets
security create-keychain -p $KEYCHAIN_PASSWORD appbuilder/appbuilder.keychain
security import appbuilder/secrets/Certificates.p12 -t agg -k appbuilder/appbuilder.keychain -P $CERTIFICATE_PASSWORD -A
