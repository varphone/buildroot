#!/bin/sh

# Fix missing /init
ln -sf /sbin/init ${TARGET_DIR}/init

# Generate the misc.ext2 image
mkdir -p ${BINARIES_DIR}/misc
cp -aprv board/full-v/zylaser/misc_overlay/* ${BINARIES_DIR}/misc/
genext2fs -d ${BINARIES_DIR}/misc -b 4096 ${BINARIES_DIR}/misc.ext2

exit $?

