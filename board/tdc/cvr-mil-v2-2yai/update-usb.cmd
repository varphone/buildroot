usb start
if fatload usb 0:1 ${loadaddr} CVR-MIL-V2/u-boot.imx; then echo "Found u-boot.imx, flashing ..."; sf probe 1; sf erase 0 0x200000; sf write ${loadaddr} 0x400 0x80000; fi
if fatload usb 0:1 ${loadaddr} CVR-MIL-V2/boot.vfat; then echo "Found boot.vfat, flashing ..."; mmc dev ${mmcdev}; mmc write ${loadaddr} 0x5000 0x20000; fi
if fatload usb 0:1 ${loadaddr} CVR-MIL-V2/rootfs.squashfs; then echo "Found rootfs.squashfs, flashing ..."; mmc dev ${mmcdev}; mmc write ${loadaddr} 0x25000 0x80000; fi
reset

