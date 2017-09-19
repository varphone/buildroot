#!/bin/sh

FILE=${TARGET_DIR}/etc/os-release
NAME="LCDS-500-II"
VERSION="$(git describe --abbrev=0 --tags)"
ID="lcds-500-ii"
VERSION_ID=${VERSION}
PRETTY_NAME="${NAME} ${VERSION}"

echo "NAME=${NAME}" > ${FILE}
echo "VERSION=${VERSION}" >> ${FILE}
echo "ID=${ID}" >> ${FILE}
echo "VERSION_ID=${VERSION_ID}" >> ${FILE}
echo "PRETTY_NAME=${PRETTY_NAME}" >> ${FILE}

