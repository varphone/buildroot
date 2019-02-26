#!/bin/bash

# Reduce the rootfs
if [ -n "${TARGET_DIR}" ]; then
	echo "!!! Reducing the target filesystem: \"${TARGET_DIR}\" ..."
	pushd "${TARGET_DIR}" && {
		rm -rf usr/share/OpenCV
		popd
	}
fi

