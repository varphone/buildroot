# Board: PPMD-V1

浮台光电监控设备(第一版)，基于 Hi3531 平台构建。

## GnuPG 信息

- 默认标识：`rdst-ppmd-v1`
- 证书密码：`Wg5tBuDM`


## 文件说明

- `initramfs_overlay` `initramfs` 的覆盖目录，这里面的内容会在生成 `initrd` 镜像时覆盖在镜像的目录中。
- `patches` 各个包的补丁目录。
- `rootfs_overlay` `rootfs` 的覆盖目录，这里面的内容会在生成 `rootfs` 镜像时覆盖在镜像的目录中。
- `device_table.txt` 设备文件权限列表，在生产镜像时会根据列表中的条目来设定对应文件或目录的权限属性。
- `fakeroot.sh` 当所有包都编译完成后运行的附加脚本，你可以在次脚本中调整一些 `target` 目录中的文件或目录。
- `initramfs-t.txt` `initramfs` 镜像中所能包含的文件列表。
- `initramfs-x.txt` `initramfs` 镜像中所需排除的文件列表。
- `linux-3.0.8.config` `linux` 内核配置文件。
- `mk-os-release.sh` 生成板子发行信息的脚本，生产的信息会存放在板子的 `/etc/os-release` 目录中。
- `post-image.sh` 生成各个镜像后执行的脚本，你可以通过此脚本对生成的镜像进行额外的处理，例如发行、打包等等。
- `pre-image.sh` 生成各个镜像前执行的脚本，你可以通过次脚本进行最后的镜像内容调整。
- `reg_info_930_310_620_dd0_dd1_slow.bin` `Hi3531` 板子的硬件配置文件，此文件会与通过代码编译出来的 `u-boot.bin` 合并生成 `Hi3531` 专用的 `u-boot.bin`。
- `update.cmd` 通过 TFTP 自动更新 `kernel、initrd、rootfs` 的脚本源代码，此源代码会通过 `mkimage` 生产可以在 `u-boot` 中执行的脚本。
- `update-uboot.cmd` 通过 `TFTP` 自动更新 `u-boot` 的脚本源代码，此源代码会通过 `mkimage` 生产可以在 `u-boot` 中执行的脚本。

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
#tftp ${loadaddr} ppmd-v1/images/initrd.cpio.gz
#tftp ${loadaddr} ppmd-v1/images/initrd.cpio.lzo
tftp ${loadaddr} ppmd-v1/images/initrd.cpio.xz
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

## U-BOOT 参数

```
setenv initrdaddr 0x81000000
setenv loadaddr 0x82000000
setenv bootargs_base console=ttyAMA0,115200 mem=128M
setenv mtdparts hinand:1M(boot),4M(kernel),10M(initrd),30M(rootfs),8M(misc),-(cache)
setenv rootargs root=/dev/mtdblock3 rootfstype=squashfs overlayroot=/dev/ubi1_0:rw:ubifs
setenv bootargs_cmd '${bootargs_base} mtdparts=${mtdparts} ${rootargs} initrd=${initrdaddr},0x${initrdsize}'
setenv bootcmd 'run bootargs_cmd; nand read ${initrdaddr} 500000 0x400000; nand read ${loadaddr} 0x100000 0x400000; bootm ${loadaddr}'
```

## 使用脚本来升级系统或者 U-BOOT

**升级 kernel, initrd, rootfs**

```
tftp 0x80000000 ppmd-v1/images/update.scr
source 0x80000000
```

**升级 u-boot**

```
tftp 0x80000000 ppmd-v1/images/update-uboot.scr
source 0x80000000
```

> **注意：**这些脚本内部均使用 `tftp` 来下载文件，默认的网络配置是：
> `ipaddr` `192.168.1.10`
> `netmask` `255.255.0.0`
> `serverip` `192.168.0.7`


