#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
TAR="tar --ignore-failed-read"

# Reduce the rootfs, remove unused files
if [ -n "${TARGET_DIR}" ]; then
	tput setaf 3
	tput bold
	echo "!!! Reducing the target filesystem: \"${TARGET_DIR}\" ..."
	tput sgr0
	pushd "${TARGET_DIR}"
	rm /usr/lib/libVIVANT.fb.so
	rm -rf usr/share/examples
	rm -rf usr/share/ffmpeg/examples
	rm -rf usr/share/imx-mm
	popd
fi

# Gen security ubifs image
SECURITY_FS="${SCRIPT_DIR}/security_fs"
SECURITY_UBIFS="${BINARIES_DIR}/security.ubifs"

if [ -d "${SECURITY_FS}" -a "${SECURITY_FS}" -nt "${SECURITY_UBIFS}" ]; then
	tput setaf 3
	echo "`tput bold`### Make security ubifs image ...`tput sgr0`"
	tput setaf 6

	mkfs.ubifs -F -m 2048 -e 126976 -c 511 \
		-r "${SECURITY_FS}" \
		"${SECURITY_UBIFS}"

	tput sgr0
fi

# Gen data ubifs image
DATA_FS="${SCRIPT_DIR}/data_fs"
DATA_UBIFS="${BINARIES_DIR}/data.ubifs"

if [ -d "${DATA_FS}" -a "${DATA_FS}" -nt "${DATA_UBIFS}" ]; then
	tput setaf 3
	echo "`tput bold`### Make data ubifs image ...`tput sgr0`"
	tput setaf 6

	mkfs.ubifs -F -m 2048 -e 126976 -c 2047 \
		-r "${DATA_FS}" \
		"${DATA_UBIFS}"

	tput sgr0
fi


# Gen cache ubifs image
CACHE_FS="${SCRIPT_DIR}/cache_fs"
CACHE_UBIFS="${BINARIES_DIR}/cache.ubifs"

if [ -d "${CACHE_FS}" -a "${CACHE_FS}" -nt "${CACHE_UBIFS}" ]; then
	tput setaf 3
	echo "`tput bold`### Make cache ubifs image ...`tput sgr0`"
	tput setaf 6

	mkfs.ubifs -F -m 2048 -e 126976 -c 1023 \
		-r "${CACHE_FS}" \
		"${CACHE_UBIFS}"

	tput sgr0
fi

exit $?

