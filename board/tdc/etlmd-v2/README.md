Build rootfs:

  make O=/opt/tdc/etlmd-v2 tdc_etlmd_v2_defconfig
  make O=/opt/tdc/etlmd-v2

**Modify the <rootfs_overlay> to change the rootfs

Build initramfs:

  make O=/opt/tdc/etlmd-v2 tdc_etlmd_v2_initramfs_defconfig
  make O=/opt/tdc/etlmd-v2_initramfs

**Modify the <initramfs_overlay> to change the initramfs

Initialize GnuPG2:

gpg-agent --daemon --enforce-passphrase-constraints --min-passphrase-len 8 --min-passphrase-nonalpha 4 --check-passphrase-pattern mypasswords

Run the emulation with:

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

## GnuPG Informations

- Default identity `etlmdv2`
- Password `LZpXk8u8`

