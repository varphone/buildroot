if tftp ${loadaddr} ${tftproot}u-boot.imx; then sf probe 1; sf erase 0 0x200000; sf write ${loadaddr} 0x400 0x80000; fi
if tftp ${loadaddr} ${tftproot}boot.vfat; then mmc dev ${mmcdev}; mmc write ${loadaddr} 0x5000 0x20000; fi
if tftp ${loadaddr} ${tftproot}rootfs.squashfs; then mmc dev ${mmcdev}; mmc write ${loadaddr} 0x25000 0x80000; fi
reset

