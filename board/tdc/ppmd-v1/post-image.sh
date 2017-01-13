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
PAGE_SIZE=2048

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

exit $?

