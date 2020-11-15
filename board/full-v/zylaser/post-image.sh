#!/bin/sh

# By default U-Boot loads DTB from a file named "devicetree.dtb", so
# let's use a symlink with that name that points to the *first*
# devicetree listed in the config.

set -e

BOARD_DIR="$( dirname "${0}" )"
MKIMAGE="${HOST_DIR}/bin/mkimage"
BOOTGEN="${HOST_DIR}/bin/bootgen"
BOOT_BIF=boot.bif
BOOT_BIN=BOOT.BIN
BOOT_QSPI_BIF=boot-qspi.bif
BOOT_QSPI_BIN=BOOT-QSPI.BIN
IMAGE_ITS=image.its
IMAGE_ITB=image.ub
FIRST_DT=$(sed -n \
           's/^BR2_LINUX_KERNEL_INTREE_DTS_NAME="\([a-z0-9\-]*\).*"$/\1/p' \
           ${BR2_CONFIG})

[ -z "${FIRST_DT}" ] || ln -fs ${FIRST_DT}.dtb ${BINARIES_DIR}/devicetree.dtb

# Make FIT Image for U-Boot
cp "${BOARD_DIR}/${IMAGE_ITS}" "${BINARIES_DIR}"
(cd "${BINARIES_DIR}" && ${MKIMAGE} -D "-I dts -O dtb -p 2000" -f ${IMAGE_ITS} ${IMAGE_ITB})

# Make boot script for u-Boot
cp "${BOARD_DIR}/boot.scr" "${BINARIES_DIR}/boot.scr"
kernel_size=$(printf "%x" $(stat -c %s "${BINARIES_DIR}/${IMAGE_ITB}"))
sed -i s/^kernel_size=.*/kernel_size=0x${kernel_size}/ "${BINARIES_DIR}/boot.scr"
${MKIMAGE} -c none -A arm -T script -d "${BINARIES_DIR}/boot.scr" "${BINARIES_DIR}/boot.scr.uimg"

# Make BOOT.BIN for Zynq-7000
cp "${BOARD_DIR}/${BOOT_BIF}" "${BINARIES_DIR}"
(cd "${BINARIES_DIR}" && ${BOOTGEN} -arch zynq -image ${BOOT_BIF} -o ${BOOT_BIN} -w)

# Make BOOT-QSPI.BIN for Zynq-7000
cp "${BOARD_DIR}/${BOOT_QSPI_BIF}" "${BINARIES_DIR}"
(cd "${BINARIES_DIR}" && ${BOOTGEN} -arch zynq -image ${BOOT_QSPI_BIF} -o ${BOOT_QSPI_BIN} -w)

# Make Images for Flash
support/scripts/genimage.sh -c ${BOARD_DIR}/genimage.cfg

