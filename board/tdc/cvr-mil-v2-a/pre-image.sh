#!/bin/bash

# Reduce the rootfs
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
