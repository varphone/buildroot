#!/bin/bash

KERNEL_IMAGE=${BINARIES_DIR}/Image.gz
RAMDISK_IMAGE=${BINARIES_DIR}/rootfs.cpio.gz
DTB_IMAGE=${BINARIES_DIR}/qx1_linux.dtb
#DTB_IMAGE=${BINARIES_DIR}/rp-a311d.dtb
OUTPUT_IMAGE=${BINARIES_DIR}/boot.img

# Copy dtb as dtb.img
cp ${DTB_IMAGE} ${BINARIES_DIR}/dtb.img

# Make android legacy boot image
mkbootimg --kernel ${KERNEL_IMAGE} \
	  --base 0x0 \
	  --kernel_offset 0x1080000 \
	  --cmdline "root=/dev/mmcblk0p15 rootfstype=ext4 init=/sbin/init" \
	  --ramdisk ${RAMDISK_IMAGE} \
	  --second ${DTB_IMAGE} \
	  --output ${OUTPUT_IMAGE}

# Convert ext2/3/4 image to spare image
img2simg ${BINARIES_DIR}/rootfs.ext2 ${BINARIES_DIR}/rootfs.ext2.img2simg

# Packing the upgrade image
cp board/vaxpl/qx1/aml_sdc_burn.ini ${BINARIES_DIR}/
cp board/vaxpl/qx1/aml_upgrade_package_emmc.conf ${BINARIES_DIR}/
cp board/vaxpl/qx1/platform.conf ${BINARIES_DIR}/

aml_image_v2_packer_new -r ${BINARIES_DIR}/aml_upgrade_package_emmc.conf \
	${BINARIES_DIR} ${BINARIES_DIR}/aml_upgrade_package_emmc.img

