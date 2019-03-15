#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
TAR="tar --ignore-failed-read"

FULL_BUILD=n
MINI_BUILD=y

while true; do
	case "$1" in
		-f | --full ) FULL_BUILD=y MINI_BUILD=n; shift ;;
		-m | --mini ) FULL_BUILD=n MINI_BUILD=y; shift ;;
		-- ) shift; break ;;
		* ) break ;;
	esac
done

# /var/log if mount for sda1 on target rootfs
if [ -L "${TARGET_DIR}/var/log" ]; then
	rm -rf "${TARGET_DIR}/var/log"
	mkdir -p "${TARGET_DIR}/var/log"
fi

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

# Reduce the rootfs
if [ -n "${TARGET_DIR}" -a "x${MINI_BUILD}" == "xy" ]; then
	tput setaf 3
	tput bold
	echo "!!! Reducing the target filesystem: \"${TARGET_DIR}\" ..."
	tput sgr0
	pushd "${TARGET_DIR}" || exit 1
	rm -f bin/chattr
	rm -f bin/lsattr
	rm -f sbin/badblocks
	rm -f sbin/logsave
	rm -f usr/bin/bunzip2
	rm -f usr/bin/bz*
	rm -f usr/lib/libaec.so
	rm -f usr/lib/libanr.so
	rm -f usr/lib/libjpeg.so
	rm -f usr/lib/libjpeg6b.so
	rm -f usr/lib/libmem.so
	rm -f usr/lib/libmpi.so
	rm -f usr/lib/libresampler.so
	rm -f usr/lib/libtde.so
	rm -f usr/lib/libVoiceEngine.so
	rm -f usr/lib/libvqev2.so
	# Remove unused timezone
	rm -rf usr/share/zoneinfo/uclibc/Africa
	rm -rf usr/share/zoneinfo/uclibc/America
	rm -rf usr/share/zoneinfo/uclibc/Antarctica
	rm -rf usr/share/zoneinfo/uclibc/Arctic
	rm -rf usr/share/zoneinfo/uclibc/Atlantic
	rm -rf usr/share/zoneinfo/uclibc/Australia
	rm -rf usr/share/zoneinfo/uclibc/Brazil
	rm -rf usr/share/zoneinfo/uclibc/Canada
	rm -rf usr/share/zoneinfo/uclibc/Chile
	rm -rf usr/share/zoneinfo/uclibc/Etc
	rm -rf usr/share/zoneinfo/uclibc/Europe
	rm -rf usr/share/zoneinfo/uclibc/Indian
	rm -rf usr/share/zoneinfo/uclibc/Mexico
	rm -rf usr/share/zoneinfo/uclibc/Pacific
	rm -rf usr/share/zoneinfo/uclibc/US
	pushd usr/share/zoneinfo/uclibc/Asia || exit 1
	find . -type f ! -name Chongqing ! -name Shanghai -delete
	popd
	# Remove unused live555 progs
	rm -f usr/bin/live555MediaServer
	rm -f usr/bin/live555ProxyServer
	rm -f usr/bin/MPEG2TransportStreamIndexer
	rm -f usr/bin/openRTSP
	rm -f usr/bin/playSIP
	rm -f usr/bin/registerRTSPStream
	rm -f usr/bin/sapWatch
	rm -f usr/bin/testAMRAudioStreamer
	rm -f usr/bin/testDVVideoStreamer
	rm -f usr/bin/testH264VideoStreamer
	rm -f usr/bin/testH264VideoToTransportStream
	rm -f usr/bin/testH265VideoStreamer
	rm -f usr/bin/testH265VideoToTransportStream
	rm -f usr/bin/testMKVStreamer
	rm -f usr/bin/testMP3Receiver
	rm -f usr/bin/testMP3Streamer
	rm -f usr/bin/testMPEG1or2AudioVideoStreamer
	rm -f usr/bin/testMPEG1or2ProgramToTransportStream
	rm -f usr/bin/testMPEG1or2Splitter
	rm -f usr/bin/testMPEG1or2VideoReceiver
	rm -f usr/bin/testMPEG1or2VideoStreamer
	rm -f usr/bin/testMPEG2TransportReceiver
	rm -f usr/bin/testMPEG2TransportStreamer
	rm -f usr/bin/testMPEG2TransportStreamTrickPlay
	rm -f usr/bin/testMPEG4VideoStreamer
	rm -f usr/bin/testOggStreamer
	rm -f usr/bin/testOnDemandRTSPServer
	rm -f usr/bin/testRelay
	rm -f usr/bin/testReplicator
	rm -f usr/bin/testRTSPClient
	rm -f usr/bin/testWAVAudioStreamer
	rm -f usr/bin/vobStreamer
	popd
fi

