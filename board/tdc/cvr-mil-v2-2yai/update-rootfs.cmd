mmc dev ${mmcdev}
if tftp ${loadaddr} ${tftproot}rootfs.squashfs; then echo "Rootfs updating ..."; mmc write ${loadaddr} 0x25000 0x80000; fi
reset
