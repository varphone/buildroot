# Board: CVR-MIL-V3

军用行车记录仪(第三版)，基于 IMX6S 平台构建。

## GnuPG 信息

- 默认标识：`rdst-ppmd-v1`
- 证书密码：`Wg5tBuDM`

## eMMC 分区

- `boot` *64M* - 存放 kernel, initrd, dtb 等。
- `rootfs` *256M* - 存放只读的根文件系统。
- `misc` *384M* - 存放重要的配置文件或其他在恢复出厂设置时都不会被清除的内容。
- `cache` *(剩余空间)* - 存放可变的文件或设备在出厂后安装的程序或更新，通过 overlayfs 覆盖在只读的 rootfs 之上。


起始扇区 | 结束扇区 | 扇区总数 | 分区名称
---------|----------|----------|---------
20480    | 151551   | 131072   | boot
151552   | 675839   | 524288   | rootfs
675840   | 1462271  | 786432   | misc
1462272  | 7733248  | 6270976  | cache

### Update u-boot

```
tftp ${loadaddr} cvr-mil-v3/images/u-boot.imx
sf probe 1
sf erase 0 0x200000
sf write ${loadaddr} 0x400 0x80000
reset 
```

### Update boot

```
mmc dev 1
tftp ${loadaddr} cvr-mil-v3/images/boot.vfat
mmc write ${loadaddr} 0x5000 0x20000
reset
```

### Update rootfs

```
tftp ${loadaddr} ppmd-v1/images/rootfs.squashfs
nand erase f00000 1e00000
nand write ${loadaddr} f00000 ${filesize}
setenv rootfssize ${filesize}
sa
```

### Boot from tftp

```
nand read 81000000 500000 ${initrdsize}
tftp ${loadaddr} ${bootfile}
bootm
```

