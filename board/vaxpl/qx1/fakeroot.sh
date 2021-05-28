#!/bin/sh

EXT4FS_SIZE=160M
EXT4FS_IMAGE=rootfs-hi3559av100-multi-core-${EXT4FS_SIZE}.ext4

# Building sparse ext4 image
make_ext4fs -l ${EXT4FS_SIZE} -s ${BINARIES_DIR}/${EXT4FS_IMAGE} ${TARGET_DIR}

exit $?

