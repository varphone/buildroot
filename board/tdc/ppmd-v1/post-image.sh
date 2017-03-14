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

# Make Hi3531 u-boot
if [ -r "${BINARIES_DIR}/u-boot.bin" ]; then
	tput setaf 3
	echo "`tput bold`### Make Hi3531 u-boot.bin ...`tput sgr0`"
	tput setaf 6
	dd if="${BINARIES_DIR}/u-boot.bin" of="${BINARIES_DIR}/fb1" bs=1 count=64
	dd if="${SCRIPT_DIR}/reg_info_930_310_620_ddr0_ddr1_slow.bin" of="${BINARIES_DIR}/fb2" bs=4096 conv=sync
	dd if="${BINARIES_DIR}/u-boot.bin" of="${BINARIES_DIR}/fb3" bs=1 skip=4160
	cat "${BINARIES_DIR}/fb1" "${BINARIES_DIR}/fb2" "${BINARIES_DIR}/fb3" > "${BINARIES_DIR}/u-boot-hi3531_930MHz.bin"
	rm "${BINARIES_DIR}/fb1"
	rm "${BINARIES_DIR}/fb2"
	rm "${BINARIES_DIR}/fb3"
	tput sgr0
fi

# Make update script for u-boot
if [ -r "${SCRIPT_DIR}/update.cmd" ]; then
	tput setaf 3
	echo "`tput bold`### Make Update script for u-boot ...`tput sgr0`"
	tput setaf 6
	"${HOST_DIR}/usr/bin/mkimage" -C none -A arm -T script -d "${SCRIPT_DIR}/update.cmd" "${BINARIES_DIR}/update.scr"
	tput sgr0
fi

# Make update u-boot script for u-boot
if [ -r "${SCRIPT_DIR}/update-uboot.cmd" ]; then
	tput setaf 3
	echo "`tput bold`### Make Update U-Boot script for u-boot ...`tput sgr0`"
	tput setaf 6
	"${HOST_DIR}/usr/bin/mkimage" -C none -A arm -T script -d "${SCRIPT_DIR}/update-uboot.cmd" "${BINARIES_DIR}/update-uboot.scr"
	tput sgr0
fi

exit $?

