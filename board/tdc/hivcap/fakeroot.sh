#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
TAR="tar --ignore-failed-read"

chmod a+x ${TARGET_DIR}/bin/*
chmod a+x ${TARGET_DIR}/etc/init.d/*
chmod a+x ${TARGET_DIR}/sbin/*
chmod a+x ${TARGET_DIR}/usr/bin/*
chmod a+x ${TARGET_DIR}/usr/sbin/*

exit $?

