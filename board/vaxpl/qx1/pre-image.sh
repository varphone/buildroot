#!/bin/sh

# Rename the u-boot loader
if [ -f ${BINARIES_DIR}/u-boot-hi3559av100.bin ]; then
	mv ${BINARIES_DIR}/u-boot-hi3559av100.bin ${BINARIES_DIR}/u-boot-hi3559av100-multi-core.bin
fi

# Remove unused kernel image
if [ -f ${BINARIES_DIR}/uImage ]; then
	rm -f ${BINARIES_DIR}/uImage
fi

exit $?

