#!/bin/sh

FILE=${TARGET_DIR}/etc/os-release
NAME="LONGAN-HI3531"
VERSION="$(git describe --abbrev=7 --tags)"
ID="longan-hi3531"
VERSION_ID=${VERSION}
PRETTY_NAME="${NAME} ${VERSION}"

echo "NAME=${NAME}" > ${FILE}
echo "VERSION=${VERSION}" >> ${FILE}
echo "ID=${ID}" >> ${FILE}
echo "VERSION_ID=${VERSION_ID}" >> ${FILE}
echo "PRETTY_NAME=${PRETTY_NAME}" >> ${FILE}

