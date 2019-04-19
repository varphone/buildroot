#!/bin/sh

# Defaults
BOARD=myimx6ek200-6s-512m

# Parse the arguments
for i in "$@"; do
	case $i in
		-b=*|--board=*)
			BOARD="${i#*=}"
			shift
			;;
		*)
			;;
	esac
done

# Rename boot.scr to my_environment.scr
if [ -e "${BINARIES_DIR}/boot.scr" ]; then
	mv "${BINARIES_DIR}/boot.scr" "${BINARIES_DIR}/my_environment.scr"
fi

# Rename u-boot.imx with board specs
if [ -e "${BINARIES_DIR}/u-boot.imx" ]; then
	mv "${BINARIES_DIR}/u-boot.imx" "${BINARIES_DIR}/uboot-${BOARD}.imx"
fi

# Rename zImage with board specs
if [ -e "${BINARIES_DIR}/zImage" ]; then
	mv "${BINARIES_DIR}/zImage" "${BINARIES_DIR}/zImage-myimx6a9"
fi

exit $?

