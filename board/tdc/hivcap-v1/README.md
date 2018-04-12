# Board: HIVCAP-V1

高清视频捕捉设备(第一版)，基于 Hi3531 平台构建。

## GnuPG 信息

- 默认标识：`hivcap-v1`
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
- `update.cmd` 通过 TFTP 自动更新 `kernel、misc、rootfs` 的脚本源代码，此源代码会通过 `mkimage` 生产可以在 `u-boot` 中执行的脚本。
- `update-uboot.cmd` 通过 `TFTP` 自动更新 `u-boot` 的脚本源代码，此源代码会通过 `mkimage` 生产可以在 `u-boot` 中执行的脚本。

## NAND FLASH 分区

- `boot` *1M* - 存放 u-boot 镜像。
- `reserved` *2M* - 保留分区，存放启动脚本或者开机图像。
- `kernel` *4M* - 存放 LINUX 内核镜像。
- `ubifs` *(剩余空间)* - 存放 UBIFS 镜像数据。
  - `misc` *8M* - 存放重要的配置文件或其他在恢复出厂设置时都不会被清除的内容。
  - `rootfs` *100M* - 存放根文件系统。

```
0x00000000-0x00100000 : "boot"
0x00100000-0x00300000 : "reserved"
0x00300000-0x00700000 : "kernel"
0x00700000-0x08000000 : "ubifs"
```

### kernel cmdline
```
mtdparts=hinand:1M(boot),2M(reserved),4M(kernel),-(ubifs)
```

### Update kernel

```
tftp ${loadaddr} hivcap-v1/images/uImage
nand erase 0x300000 0x400000
nand write ${loadaddr} 0x300000 ${filesize}
setenv kernelsize ${filesize}
sa
```

### Update ubifs

```
tftp ${loadaddr} hivcap-v1/images/rootfs.ubi
nand erase 0x700000 0x8000000
nand write ${loadaddr} 0x700000 ${filesize}
setenv rootfssize ${filesize}
sa
```

### Boot from tftp

```
tftp ${loadaddr} ${bootfile}
bootm
```

## U-BOOT 参数

```
setenv loadaddr 0x82000000
setenv bootargs_base console=ttyAMA0,115200 mem=128M panic=5
setenv mtdparts mtdparts=hinand:1M(boot),2M(reserved),4M(kernel),-(ubifs)
setenv rootargs ubi.mtd=3 root=ubi0:rootfs rw rootfstype=ubifs
setenv loadkernel 'nand read ${loadaddr} 0x300000 0x400000'
setenv setmac 'setenv mac eth0.mac=${ethaddr} eth1.mac=${eth1addr}'
setenv setbootargs 'setenv bootargs ${bootargs_base} ${mtdparts} ${rootargs} ${mac}'
setenv bootcmd 'run setmac; run setbootargs; run loadinitrd; run loadkernel; bootm ${loadaddr}'
run setbootargs
sa
```

## 使用脚本来升级系统或者 U-BOOT

**升级 kernel, misc, rootfs**

```
tftp 0x80000000 hivcap-v1/images/update.scr
source 0x80000000
```

**升级 u-boot**

```
tftp 0x80000000 hivcap-v1/images/update-uboot.scr
source 0x80000000
```

> **注意：**这些脚本内部均使用 `tftp` 来下载文件，默认的网络配置是：
> `ipaddr` `192.168.1.10`
> `netmask` `255.255.0.0`
> `serverip` `192.168.0.7`

