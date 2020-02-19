#!/bin/bash
mkdir output
./resign.sh asset/WEB-1.4.ipa "iPhone Distribution: Chris Hubbard (5P99T946M7)" -p appbuilder/secrets/app.mobileprovision asset/WEB-1.4-resigned.ipa
aws s3 sync asset s3://cth-dev-aps-artifacts/travis
