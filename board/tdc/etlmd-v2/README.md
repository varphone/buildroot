board/tdc/etlmd-v2
==================

为电力输电线路监控设备 (V2) 而制作的板型支持。

## Build rootfs:

```
make O=/opt/tdc/etlmd-v2 tdc_etlmd_v2_defconfig
make O=/opt/tdc/etlmd-v2
```

**Modify the `rootfs_overlay` to change the rootfs**

## Build initramfs:

```
make O=/opt/tdc/etlmd-v2 tdc_etlmd_v2_initramfs_defconfig
make O=/opt/tdc/etlmd-v2_initramfs
```

**Modify the `initramfs_overlay` to change the initramfs**


### Run the emulation with:

**Prepaire network**

```
sudo tunctl -u $(whoami)
sudo brctl addif br0 tap0
sudo ip link set dev tap0 up
```

```
qemu-system-x86_64 -M pc -kernel /opt/tdc/etlmd-v2/images/bzImage -drive file=/opt/tdc/etlmd-v2/images/rootfs.ext2,if=virtio,format=raw -append root=/dev/vda -net nic,model=virtio -net user -display gtk,gl=on -vga virtio
```

Optionally add -smp N to emulate a SMP system with N CPUs.

The login prompt will appear in the graphical window.

Tested with QEMU 2.5.0

## GnuPG 信息

- 默认标识 `etlmdv2`
- 证书密码 `LZpXk8u8`

## 分区信息

| Part     | Size       | Mount                | GUID                                 |
| -------- | ---------- |--------------------- | ------------------------------------ |
| boot     | 200M       | /boot                | 911b2004-9994-11e6-9f33-a24fc0d9649a |
| recovery | 800M       | /recovery            | 911b2004-9994-11e6-9f33-a24fc0d9649b |
| misc     | 100M       | /misc                | 911b2004-9994-11e6-9f33-a24fc0d9649c |
| system   | 1G         | /system              | 911b2004-9994-11e6-9f33-a24fc0d9649d |
| cache    | *          | /system-overlay      | 911b2004-9994-11e6-9f33-a24fc0d9649e |

- `boot`	主要启动分区，存放 EFI、KERNEL、INITRD。
- `recovery`	第二启动分区，存放系统备份，用户在出现故障时可以恢复系统。
- `misc`	杂项分区，此分区数据即使在恢复出厂值时也不会被擦除，可以用来存放有些关键数据。
- `system`	系统分区，存放系统文件，默认情况下为了保证系统稳定性，是只读的。
- `cache`	数据分区，存放用户数据及设备在出厂后更新的程序或数据。
