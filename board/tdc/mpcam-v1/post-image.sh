#!/bin/sh

# Copy the uEnv.txt to images dir.
UENV_TXT=$(realpath board/tdc/mpcam-v1/uEnv.txt)
cp ${UENV_TXT} ${BINARIES_DIR}/uEnv.txt

# Copy the fpga.bin to images dir.
FPGA_BIN=$(realpath board/tdc/mpcam-v1/rootsf_overlay/lib/firmware/fpga.bin)
cp ${FPGA_BIN} ${BINARIES_DIR}/fpga.bin

# Make FIT Image
IMAGE_ITS=$(realpath board/tdc/mpcam-v1/image.its)

# Copy the image.its to images dir to fix the relative path bugs.
cp ${IMAGE_ITS} ${BINARIES_DIR}/image.its

# Change to images dir and make fit image.
(cd ${BINARIES_DIR}; mkimage -f image.its image.itb)

support/scripts/genimage.sh -c board/tdc/mpcam-v1/genimage.cfg
