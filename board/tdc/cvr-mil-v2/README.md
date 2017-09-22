# Board: CVR-MIL-V2

军用行车记录仪(第二版)，基于 IMX6Q 平台构建。

## GnuPG 信息

- 默认标识：`cvr-mil-v2`
- 证书密码：`v8drDzYx`

## eMMC 分区

- `boot` *64M* - 存放 kernel, initrd, dtb 等。
- `rootfs` *256M* - 存放只读的根文件系统。
- `misc` *256M* - 存放重要的配置文件或其他在恢复出厂设置时都不会被清除的内容。
- `extd` *(剩余空间)* 扩展分区（MBR格式只支持最大 4 个主分区，所以需要采用扩展分区）。
  - `cache` *256M,逻辑分区* - 存放可变的文件或设备在出厂后安装的程序或更新，通过 overlayfs 覆盖在只读的 rootfs 之上。
  - `dcim` *(剩余空间),逻辑分区* - 存放录像文件。


起始扇区 | 结束扇区 | 扇区总数 | 分区名称
---------|----------|----------|---------
20480    | 151551   | 131072   | boot
151552   | 675839   | 524288   | rootfs
675840   | 1200127  | 524288   | misc
1200128  | 30777344 | 29577216 | extd
1200129  | 1724416  | 524287   | cache
1724417  | 30777344 | 29052927 | dcim


### Update u-boot

```
tftp ${loadaddr} ${tftproot}u-boot.imx
sf probe 1
sf erase 0 0x200000
sf write ${loadaddr} 0x400 0x80000
reset 
```

### Update boot

```
mmc dev 1
tftp ${loadaddr} ${tftproot}boot.vfat
mmc write ${loadaddr} 0x5000 0x20000
reset
```

### Update rootfs

```
tftp ${loadaddr} ${tftproot}rootfs.squashfs
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

## 更新 BOOT 文件

由于最终产品并没有网络接口，因此在开发、测试需要更新 `BOOT` 分区中的文件时，会有些不便。

目前支持的更新方式有两种：

1. 使用 `MFG` 工具书写 `BOOT` 分区。
2. 使用 `g_mass_storage` 将 `BOOT` 分区虚拟为一个移动磁盘，然后在此盘中更新文件。

方式 1 请参照 IMX MFG 工具的使用手册。

方式 2 请参照以下步骤来实施：

1. 在设备 shell 中运行以下命令：

```sh
modprobe g_mass_storage file=/dev/mmcblk3p1 stall=0 removable=1
```

2. 使用 `USB` 连接线将 `USB OTG` 口连接到电脑上。
3. 当 `USB` 连接到电脑上时，你会看到一个可移动磁盘。
4. 将需要更新的文件复制到移动磁盘中。
5. 弹出移动磁盘。
6. 在设备的 `shell` 中执行 `sync` 命令。
7. 重启设备以便生效。

