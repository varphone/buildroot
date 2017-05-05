#!/bin/sh

FILE=${TARGET_DIR}/etc/os-release
NAME="CVR-MIL-V3"
VERSION="$(git describe --abbrev=0 --tags)"
ID="cvr-mil-v3"
VERSION_ID=${VERSION}
PRETTY_NAME="${NAME} ${VERSION}"

echo "NAME=${NAME}" > ${FILE}
echo "VERSION=${VERSION}" >> ${FILE}
echo "ID=${ID}" >> ${FILE}
echo "VERSION_ID=${VERSION_ID}" >> ${FILE}
echo "PRETTY_NAME=${PRETTY_NAME}" >> ${FILE}

