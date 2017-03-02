board/tdc/etlmd-v2-lp
=====================

为电力输电线路监控设备 (V2) 而制作的板型支持。

## Files

File                 | Notes
-------------------- | ------
/boot                | EFI 启动文件目录。
*/boot-t.txt*        | 打包 BOOT 时需要包含的目录及文件列表。
*/boot-x.txt*        | 打包 BOOT 时需要排除的目录及文件列表。
*/device_table.txt*  | 目录权限表。
/initramfs_overlay   | INITRD 覆盖文件。
*/initramfs-t.txt*   | 打包 INITRD 时需要包含的目录及文件列表。
*/initramfs-x.txt*   | 打包 INITRD 时需要排除的目录及文件列表。
/liveusb             | 制作 LiveUSB 用到的文件。
*/liveusb-t.txt*     | 打包 LiveUSB 时需要包含的目录及文件列表。
*/liveusb-x.txt*     | 打包 LiveUSB 时需要排除的目录及文件列表。
/patches             | 项目关联的补丁目录。
*/post-fakeroot.sh*  | ROOTFS 目录准备完成后调用的脚本。
*/post-image.sh*     | 系统镜像创建完成后调用的脚本。
*/pre-image.sh*      | 系统镜像创建之前调用的脚本。
/rootfs_overlay      | 系统根目录覆盖文件。


## Build rootfs:

```sh
make O=/opt/tdc/etlmd-v2-lp tdc_etlmd_v2_lp_defconfig
make O=/opt/tdc/etlmd-v2-lp
```

**Modify the `rootfs_overlay` to change the rootfs**

**Modify the `initramfs_overlay` to change the initramfs**


### Run the emulation with:

**Prepaire network**

```sh
sudo tunctl -u $(whoami)
sudo brctl addif br0 tap0
sudo ip link set dev tap0 up
```

```sh
qemu-system-x86_64 -M pc -kernel /opt/tdc/etlmd-v2/images/bzImage -drive file=/opt/tdc/etlmd-v2-lp/images/rootfs.ext2,if=virtio,format=raw -append root=/dev/vda -net nic,model=virtio -net user -display gtk,gl=on -vga virtio
```

Optionally add -smp N to emulate a SMP system with N CPUs.

The login prompt will appear in the graphical window.

Tested with QEMU 2.5.0

## GnuPG 信息

- 默认标识：`etlmdv2`
- 证书密码：`LZpXk8u8`

## 分区信息

Part     | Size       | Mount                | GUID                                
-------- | ---------- |--------------------- | ------------------------------------
boot     | 200M       | /boot                | 911b2004-9994-11e6-9f33-a24fc0d9649a
recovery | 800M       | /recovery            | 911b2004-9994-11e6-9f33-a24fc0d9649b
misc     | 100M       | /misc                | 911b2004-9994-11e6-9f33-a24fc0d9649c
system   | 1G         | /system              | 911b2004-9994-11e6-9f33-a24fc0d9649d
cache    | *          | /system-overlay      | 911b2004-9994-11e6-9f33-a24fc0d9649e


Part     | Notes
-------- |---------------------------------------------------------------------
boot     | 主要启动分区，存放 EFI、KERNEL、INITRD。
recovery | 第二启动分区，存放系统备份，用户在出现故障时可以恢复系统。
misc     | 杂项分区，此分区数据即使在恢复出厂值时也不会被擦除，可以用来存放有些关键数据。
system   | 系统分区，存放系统文件，默认情况下为了保证系统稳定性，是只读的。
cache    | 数据分区，存放用户数据及设备在出厂后更新的程序或数据。

## FAQ

### 挂载 vfat 镜像

```sh
sudo mount -t vfat -o offset=31744,rw,noexec /tmp/etlmd-v2-2g.raw /mnt
```

- `offset=31744` 是分区起始位置，可以通过 `fdisk -l` 来取得，计算公式为：`N * 512`。


### 制作安装 U 盘

1. 将 `1G` 以上的 U 盘格式化为 `FAT32` 分区格式。
2. 将 U 盘的卷标名设置为：`ETLMDV2`。
3. 下载打包好的 U 盘安装包，位置在 `/opt/tdc/etlmd-v2-lp/images/liveusb.tgz`。
4. 将下载好的 liveusb.tgz 解压到 U 盘的根目录。


### 使用 U 盘安装系统

1. 将已经制作好的 U 盘插入需要安装的设备中。
2. 在 `BIOS` 中选择从 U 盘启动。
3. 在 U 盘启动的引导菜单中选择 `... Recovery` 启动项。
4. 在系统启动后，登录到 shell 中。
5. 执行 `mksysparts /dev/sda` 进行分区、格式化（注意：当设备已经安装过了系统，并且想要保留现有的数据时，此步可以跳过）。
5. 执行 `install-sys /dev/sda` 将系统安装到设备中。


