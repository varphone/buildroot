#!/bin/bash
DESTDIR=/opt/tdc/etlmd-v2
KERNEL="-kernel ${DESTDIR}/images/bzImage"
INITRD="-initrd ${DESTDIR}/images/initrd.cpio.gz"
BOOTARGS="-append root=/dev/ram0 -append overlayroot=/dev/sdb4:rw:ext2 -append console=ttyS0,115200"
DISK1="-hda ${DESTDIR}/images/rootfs.ext2"
DISK2="-hdb ${HOME}/workspace/tests/etlmdv2-8g.raw"
DISK3="-usbdevice disk:format=raw:${HOME}/workspace/tests/etlmdv2-2g.raw"
NETIF="-device e1000,netdev=network0,mac=68:22:33:44:55:AF -netdev tap,id=network0,ifname=tap0,script=no,downscript=no"
LANG=en
EXECARGS="${KERNEL} ${INITRD} ${BOOTARGS} ${DISK1} ${DISK2} ${DISK3} ${NETIF}"
EXEC="qemu-system-x86_64 -M pc -m 1024M -nographic ${EXECARGS}"

echo ${EXEC}
${EXEC}
#qemu-system-x86_64 -M pc -m 1024M -append 'root=/dev/sdb4 overlayroot=/dev/sdb5:rw:ext2 console=ttyS0,115200' -nographic  
