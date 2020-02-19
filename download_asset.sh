#!/bin/bash
mkdir asset
aws s3 sync s3://cth-dev-aps-artifacts/travis asset
