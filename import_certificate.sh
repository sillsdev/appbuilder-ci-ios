#!/bin/bash
mkdir -p "${TMPDIR}/appbuilder/secrets"
aws s3 sync s3://sil-stg-aps-secrets/travis/build/* "${TMPDIR}/appbuilder/secrets"
security create-keychain -p $KEYCHAIN_PASSWORD "${TMPDIR}/appbuilder/appbuilder.keychain"
security import $TMPDIR/appbuilder/secrets/Certificates.p12 -t agg -k "${TMPDIR}/appbuilder/appbuilder.keychain" -P $CERTIFICATE_PASSWORD -A
