#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
INITRAMFS_DIR="${BINARIES_DIR}/initramfs"
INITRAMFS_T_LIST="${SCRIPT_DIR}/initramfs-t.txt"
INITRAMFS_X_LIST="${SCRIPT_DIR}/initramfs-x.txt"
INITRAMFS_OVERLAY="${SCRIPT_DIR}/initramfs_overlay"
TAR="tar --ignore-failed-read"

BUILD_INITRD=y

chmod a+x ${TARGET_DIR}/bin/*
chmod a+x ${TARGET_DIR}/etc/init.d/*
chmod a+x ${TARGET_DIR}/sbin/*
chmod a+x ${TARGET_DIR}/usr/bin/*
chmod a+x ${TARGET_DIR}/usr/sbin/*

# Make os-release file
${SCRIPT_DIR}/mk-os-release.sh

if [[ "${BUILD_INITRD}" = "y" ]]; then
	echo "### Cleanup initramfs if exists"
	rm -f "${BINARIES_DIR}/initrd.cpio"
	rm -f "${BINARIES_DIR}/initrd.cpio.gz"
	rm -rf "${BINARIES_DIR}/initramfs"
	mkdir -p "${BINARIES_DIR}/initramfs"

	echo "### Copy initramfs files ..."
	pushd "${TARGET_DIR}" || exit 1
	${TAR} -cf - -T "${INITRAMFS_T_LIST}" -X "${INITRAMFS_X_LIST}" | tar -xf - -C"${INITRAMFS_DIR}/"
	popd

	echo "### Overlay with ${INITRAMFS_OVERLAY} ..."
	pushd "${INITRAMFS_OVERLAY}" || exit 1
	${TAR} -cf - * | tar -xf - -C"${INITRAMFS_DIR}"
	popd

	echo "### Make cpio ..."
	pushd "${INITRAMFS_DIR}" || exit 1
	find . | cpio -o -H newc -R 0:0 > "${BINARIES_DIR}/initrd.cpio"
	popd

	echo "### Compress with gzip ..."
	gzip -c "${BINARIES_DIR}/initrd.cpio" > "${BINARIES_DIR}/initrd.cpio.gz"

	echo "### Make u-boot image ..."
	mkimage -A arm -O linux -T ramdisk -a 13000000 -e 13000000 -n "Ramdisk Image" -d "${BINARIES_DIR}/initrd.cpio.gz" "${BINARIES_DIR}/initrd.img"

	#echo "### Install to target/boot ..."
	#cp -apv "${BINARIES_DIR}/initrd.cpio" "${TARGET_DIR}/boot/"
	#cp -apv "${BINARIES_DIR}/initrd.cpio.gz" "${TARGET_DIR}/boot/"

	#rm -rf "${BINARIES_DIR}/initramfs"
fi

# Reduce the rootfs
if [ -n "${TARGET_DIR}" ]; then
	tput setaf 3
	tput bold
	echo "!!! Reducing the target filesystem: \"${TARGET_DIR}\" ..."
	tput sgr0
	pushd "${TARGET_DIR}" || exit 1
	#rm -f usr/lib/libGAL.fb.so
	#rm -f usr/lib/libVIVANTE.fb.so
	#rm -rf usr/share/examples
	#rm -rf usr/share/ffmpeg/examples
	#rm -rf usr/share/imx-mm
	#rm -rf usr/lib/fonts
	# Disable some services
	#mv etc/init.d/S20modules etc/init.d/D20modules
	#mv etc/init.d/S40network etc/init.d/D40network
	#mv etc/init.d/S50sshd etc/init.d/D50sshd
	popd
fi

exit $?

