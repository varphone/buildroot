#!/bin/sh

# Fix missing /init
ln -sf /sbin/init ${TARGET_DIR}/init

exit $?

