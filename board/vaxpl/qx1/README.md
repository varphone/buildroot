qx1
===

Manual of the QX1 Firmware build on Hi599AV100 (Multi-Core).

Flash eMMC
----------

### Flash u-boot

```sh
mw.b 0x42000000 0xff 0x100000
tftp 0x42000000 u-boot-hi3559av100-multi-core.bin
mmc write 0 0x42000000 0x0 0x800
```

### Flash linux kernel

```sh
mw.b 0x42000000 0xff 0x1000000
tftp 0x42000000 uImage-hi3559av100-multi-core
mmc write 0 0x42000000 0xC000 0x8000
```

### Flash rootfs.ext4

```sh
mw.b 0x42000000 0xff 0xA000000
tftp 0x42000000 rootfs-hi3559av100-multi-core-160M.ext4
mmc write.ext4sp 0 0x42000000 0x14000 0x50000
```

