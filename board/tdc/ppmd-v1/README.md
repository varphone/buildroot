# Board: PPMD-V1

浮台光电监控设备(第一版)，基于 Hi3531 平台构建。

## GnuPG 信息

- 默认标识：`rdst-ppmd-v1`
- 证书密码：`Wg5tBuDM`

## NAND FLASH 分区

- `boot` *1M* - 存放 u-boot 镜像。
- `kernel` *4M* - 存放 LINUX 内核镜像。
- `initrd` *10M* - 存放 LINUX INITRAMFS 镜像。
- `rootfs` *30M* - 存放只读的根文件系统。
- `misc` *8M* - 存放重要的配置文件或其他在恢复出厂设置时都不会被清除的内容。
- `cache` *(剩余空间)* - 存放可变的文件或设备在出厂后安装的程序或更新，通过 overlayfs 覆盖在只读的 rootfs 之上。

```
0x000000000000-0x000000100000 : "boot"
0x000000100000-0x000000500000 : "kernel"
0x000000500000-0x000000f00000 : "initrd"
0x000000f00000-0x000002d00000 : "rootfs"
0x000002d00000-0x000003500000 : "misc"
0x000003500000-0x000008000000 : "cache"
```

### kernel cmdline
```
mtdparts=hinand:1M(boot),4M(kernel),10M(initrd),30M(rootfs),8M(misc),-(cache)
```

### Update kernel

```
tftp ${loadaddr} ppmd-v1/images/uImage
nand erase 100000 400000
nand write ${loadaddr} 100000 ${filesize}
setenv kernelsize ${filesize}
sa
```

### Update initrd

```
tftp ${loadaddr} ppmd-v1/images/initrd.cpio.gz
nand erase 500000 a00000
nand write ${loadaddr} 500000 ${filesize}
setenv initrdsize ${filesize}
sa
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

