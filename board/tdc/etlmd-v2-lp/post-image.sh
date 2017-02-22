#!/bin/bash

BUILD_LIVEUSB=y
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

# Make os-release file
${SCRIPT_DIR}/mk-os-release.sh

if [[ "${BUILD_LIVEUSB}" = "y" ]]; then
	echo "### Cleanup liveusb if exists"
	rm -rf "${BINARIES_DIR}/liveusb"
	mkdir -p "${BINARIES_DIR}/liveusb"
	pushd "${SCRIPT_DIR}/boot"
	${TAR} -cf - -T "${BOOT_T_LIST}" -X "${BOOT_X_LIST}" | tar -xf - -C"${LIVEUSB_DIR}"
	popd
	pushd "${SCRIPT_DIR}/liveusb"
	${TAR} -cf - -T "${LIVEUSB_T_LIST}" -X "${LIVEUSB_X_LIST}" | tar -xf - -C"${LIVEUSB_DIR}"
	popd
	cp -ap "${BINARIES_DIR}/bzImage" "${LIVEUSB_DIR}/boot/"
	cp -ap "${BINARIES_DIR}/initrd.cpio.gz" "${LIVEUSB_DIR}/boot/"
	cp -ap "${BINARIES_DIR}/rootfs.ext2" "${LIVEUSB_DIR}/dist/system.ext2"
	pushd "${LIVEUSB_DIR}"
	tar -zcf dist/boot.tgz boot EFI
	tar -zcf "${BINARIES_DIR}/liveusb.tgz" *
	popd
	#rm -rf "${BINARIES_DIR}/liveusb"
fi

exit $?
