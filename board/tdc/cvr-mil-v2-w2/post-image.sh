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
PAGE_SIZE=131072

# Add aligned padding
# $1 file path
# $2 aligned size
AlignedPadding()
{
        file=$1
        aligned=$2
        filesize=$(stat -c "%s" "${file}")
        if [ $((filesize % aligned)) -ne 0 ]; then
                newsize=$(((filesize / aligned + 1) * aligned))
                padcount=$((newsize - filesize))
		echo "Aligned pad file: ${file} with ${padcount} bytes"
                dd if=/dev/zero of="${file}" bs=1 count=${padcount} oflag=append conv=notrunc
        fi
}

# Build u-boot scripts
# $1 input plain text file
# $2 output u-boot image file
BuildScript()
{
	if [ -r "$1" ]; then
		tput setaf 3
		echo "`tput bold`### Make u-boot script: $2`tput sgr0`"
		tput setaf 6
		"${HOST_DIR}/usr/bin/mkimage" -C none -A arm -T script -d "$1" "$2"
		tput sgr0
	fi
}

if [ -w "${BINARIES_DIR}/uImage" ]; then
	AlignedPadding "${BINARIES_DIR}/uImage" ${PAGE_SIZE}
fi

if [ -w "${BINARIES_DIR}/initrd.cpio.gz" ]; then
	AlignedPadding "${BINARIES_DIR}/initrd.cpio.gz" ${PAGE_SIZE}
fi

if [ -w "${BINARIES_DIR}/initrd.cpio.lzo" ]; then
	AlignedPadding "${BINARIES_DIR}/initrd.cpio.lzo" ${PAGE_SIZE}
fi

if [ -w "${BINARIES_DIR}/initrd.cpio.xz" ]; then
	AlignedPadding "${BINARIES_DIR}/initrd.cpio.xz" ${PAGE_SIZE}
fi

if [ -w "${BINARIES_DIR}/rootfs.cramfs" ]; then
	AlignedPadding "${BINARIES_DIR}/rootfs.cramfs" ${PAGE_SIZE}
fi

if [ -w "${BINARIES_DIR}/rootfs.squashfs" ]; then
	AlignedPadding "${BINARIES_DIR}/rootfs.squashfs" ${PAGE_SIZE}
fi

if [ -w "${BINARIES_DIR}/rootfs.ubifs" ]; then
	AlignedPadding "${BINARIES_DIR}/rootfs.ubifs" ${PAGE_SIZE}
fi

if [ -w "${BINARIES_DIR}/rootfs.yaffs2" ]; then
	AlignedPadding "${BINARIES_DIR}/rootfs.yaffs2" ${PAGE_SIZE}
fi

BuildScript "${SCRIPT_DIR}/boot.cmd" "${BINARIES_DIR}/boot.scr"
BuildScript "${SCRIPT_DIR}/boot-nfs.cmd" "${BINARIES_DIR}/boot-nfs.scr"
BuildScript "${SCRIPT_DIR}/boot-tftp.cmd" "${BINARIES_DIR}/boot-tftp.scr"
BuildScript "${SCRIPT_DIR}/boot-usb.cmd" "${BINARIES_DIR}/boot-usb.scr"
BuildScript "${SCRIPT_DIR}/update.cmd" "${BINARIES_DIR}/update.scr"
BuildScript "${SCRIPT_DIR}/update-boot.cmd" "${BINARIES_DIR}/update-boot.scr"
BuildScript "${SCRIPT_DIR}/update-rootfs.cmd" "${BINARIES_DIR}/update-rootfs.scr"
BuildScript "${SCRIPT_DIR}/update-uboot.cmd" "${BINARIES_DIR}/update-uboot.scr"
BuildScript "${SCRIPT_DIR}/update-usb.cmd" "${BINARIES_DIR}/update-usb.scr"

# Gen boot.vfat image
GENIMAGE_CFG="${SCRIPT_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

if [ -r "${GENIMAGE_CFG}" ]; then
	rm -rf "${GENIMAGE_TMP}"

	tput setaf 3
	echo "`tput bold`### Make boot vfat image ...`tput sgr0`"
	tput setaf 6

	genimage \
		--rootpath "${TARGET_DIR}" \
		--tmppath "${GENIMAGE_TMP}" \
		--inputpath "${BINARIES_DIR}" \
		--outputpath "${BINARIES_DIR}" \
		--config "${GENIMAGE_CFG}"

	tput sgr0
fi

exit $?

