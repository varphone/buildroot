#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
INITRAMFS_DIR="${BINARIES_DIR}/initramfs"
INITRAMFS_T_LIST="${SCRIPT_DIR}/initramfs-t.txt"
INITRAMFS_X_LIST="${SCRIPT_DIR}/initramfs-x.txt"
INITRAMFS_OVERLAY="${SCRIPT_DIR}/initramfs_overlay"
LIVEUSB_DIR="${BINARIES_DIR}/liveusb"
LIVEUSB_T_LIST="${SCRIPT_DIR}/liveusb-t.txt"
LIVEUSB_X_LIST="${SCRIPT_DIR}/liveusb-x.txt"
BOOT_T_LIST="${SCRIPT_DIR}/boot-t.txt"
BOOT_X_LIST="${SCRIPT_DIR}/boot-x.txt"
TAR="tar --ignore-failed-read"

if [[ "${BUILD_INITRD}" = "y" ]]; then
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
	echo "### Install to target/boot ..."
fi

exit $?

