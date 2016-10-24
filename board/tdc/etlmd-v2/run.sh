#!/bin/bash
DESTDIR=/opt/tdc/etlmd-v2
BOOTARGS="-append 'root=/dev/ram0 overlayroot=/dev/sdb4:rw:ext2 console=ttyS0,115200'"
UDISK="-usbdevice disk:format=raw:/tmp/etlmd-v2-2g.raw"
echo "BOOTARGS ${BOOTARGS}"
LC_ALL=C qemu-system-x86_64 -M pc -m 1024M -kernel ${DESTDIR}/images/bzImage -initrd ${DESTDIR}/images/initrd.cpio.gz -hda ${DESTDIR}/images/rootfs.ext2 -hdb /tmp/etlmd-v2-8g.raw -device e1000,netdev=network0,mac=68:22:33:44:55:AF -netdev tap,id=network0,ifname=tap0,script=no,downscript=no ${UDISK} -append 'root=/dev/ram0 overlayroot=/dev/sdb4:rw:ext2 console=ttyS0,115200' -nographic  
