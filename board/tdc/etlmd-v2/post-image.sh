#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
INITRAMFS_DIR="${BINARIES_DIR}/initramfs"
INITRAMFS_T_LIST="${SCRIPT_DIR}/initramfs-t.txt"
INITRAMFS_X_LIST="${SCRIPT_DIR}/initramfs-x.txt"
INITRAMFS_OVERLAY="${SCRIPT_DIR}/initramfs_overlay"
TAR="tar --ignore-failed-read"

echo "### Cleanup initramfs if exists"
rm -rf "${BINARIES_DIR}/initramfs"
mkdir -p "${BINARIES_DIR}/initramfs"

echo "### Copy initramfs files ..."
pushd "${TARGET_DIR}"
${TAR} -cf - -T "${INITRAMFS_T_LIST}" -X "${INITRAMFS_X_LIST}" | tar -xf - -C"${INITRAMFS_DIR}/"
popd

echo "### Overlay with ${INITRAMFS_OVERLAY} ..."
pushd "${INITRAMFS_OVERLAY}"
${TAR} -cf - * | tar -xf - -C"${INITRAMFS_DIR}"
popd

echo "### Make cpio ..."
pushd "${INITRAMFS_DIR}"
find . | cpio --quiet -o -H newc -R 0:0 > "${BINARIES_DIR}/initrd.cpio"
popd

echo "### Compress with gzip ..."
gzip -f -9 "${BINARIES_DIR}/initrd.cpio"
