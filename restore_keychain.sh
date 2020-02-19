#!/bin/bash
set -x
security list-keychains -s "~/Library/Keychains/login.keychain"
security default-keychain -s "~/Library/Keychains/login.keychain"
