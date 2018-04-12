#!/bin/sh

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
TAR="tar --ignore-failed-read"

# Gen misc ubifs image
MISC_FS="${SCRIPT_DIR}/misc_fs"
MISC_UBIFS="${BINARIES_DIR}/misc.ubifs"

if [ -d "${MISC_FS}" ]; then
	tput setaf 3
	echo "`tput bold`### Make misc ubifs image ...`tput sgr0`"
	tput setaf 6

	# 64 LEBs = 8MB
	mkfs.ubifs -F -m 2048 -e 126976 -c 64 -U \
		-r "${MISC_FS}" \
		"${MISC_UBIFS}"

	tput sgr0
fi

