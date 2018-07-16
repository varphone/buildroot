#!/bin/bash

BUILD_INITRD=y
SCRIPT_DIR=$(dirname $(readlink -f "$0"))
INITRAMFS_DIR="${BINARIES_DIR}/initramfs"
INITRAMFS_T_LIST="${SCRIPT_DIR}/initramfs-t.txt"
INITRAMFS_X_LIST="${SCRIPT_DIR}/initramfs-x.txt"
INITRAMFS_OVERLAY="${SCRIPT_DIR}/initramfs_overlay"
TAR="tar --ignore-failed-read"

chmod a+x ${TARGET_DIR}/bin/*
chmod a+x ${TARGET_DIR}/etc/init.d/*
chmod a+x ${TARGET_DIR}/sbin/*
chmod a+x ${TARGET_DIR}/usr/bin/*
chmod a+x ${TARGET_DIR}/usr/sbin/*

# Make os-release file
${SCRIPT_DIR}/mk-os-release.sh

if [[ "${BUILD_INITRD}" = "y" ]]; then
	echo "### Cleanup initramfs if exists"
	rm "${BINARIES_DIR}/initrd.cpio"
	rm "${BINARIES_DIR}/initrd.cpio.gz"
	rm "${BINARIES_DIR}/initrd.cpio.lz4"
	rm "${BINARIES_DIR}/initrd.cpio.lzo"
	rm "${BINARIES_DIR}/initrd.cpio.xz"
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
	find . | cpio -o -H newc -R 0:0 > "${BINARIES_DIR}/initrd.cpio"
	popd

	echo "### Compress with gzip ..."
	gzip -c "${BINARIES_DIR}/initrd.cpio" > "${BINARIES_DIR}/initrd.cpio.gz"

	echo "### Compress with lz4 ..."
	lz4 -9 -f "${BINARIES_DIR}/initrd.cpio" "${BINARIES_DIR}/initrd.cpio.lz4"

	echo "### Compress with lzo ..."
	lzop -9 -o "${BINARIES_DIR}/initrd.cpio.lzo" "${BINARIES_DIR}/initrd.cpio"

	echo "### Compress with xz ..."
	xz -z -k -f --check=crc32 "${BINARIES_DIR}/initrd.cpio"

	#echo "### Install to target/boot ..."
	#cp -apv "${BINARIES_DIR}/initrd.cpio" "${TARGET_DIR}/boot/"
	#cp -apv "${BINARIES_DIR}/initrd.cpio.gz" "${TARGET_DIR}/boot/"
fi

exit $?

