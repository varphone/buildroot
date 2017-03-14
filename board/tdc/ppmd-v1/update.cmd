setenv initrdaddr 0x81000000
setenv loadaddr 0x82000000
setenv bootargs console=ttyAMA0,115200 mem=128M root=/dev/mtdblock4 ro rootfstype=squashfs panic=5
setenv bootargs_base console=ttyAMA0,115200 mem=128M panic=5
setenv mtdparts mtdparts=hinand:1M(boot),2M(reserved),4M(kernel),10M(initrd),30M(rootfs),8M(misc),-(cache)
setenv rootargs root=/dev/mtdblock4 rootfstype=squashfs overlayroot=/dev/ubi1_0:rw:ubifs
tftp ${loadaddr} ppmd-v1/images/uImage
nand erase 0x300000 0x400000
nand write ${loadaddr} 0x300000 ${filesize}
setenv kernelsize ${filesize}
tftp ${loadaddr} ppmd-v1/images/initrd.cpio.xz
nand erase 0x700000 0xa00000
nand write ${loadaddr} 0x700000 ${filesize}
setenv initrdsize ${filesize}
tftp ${loadaddr} ppmd-v1/images/rootfs.squashfs
nand erase 0x1100000 0x1e00000
nand write ${loadaddr} 0x1100000 ${filesize}
setenv rootfssize ${filesize}
setenv bootargs_cmd 'setenv bootargs ${bootargs_base} ${mtdparts} ${rootargs} initrd=${initrdaddr},0x${initrdsize}'
setenv bootcmd 'run bootargs_cmd; nand read ${initrdaddr} 0x700000 0x400000; nand read ${loadaddr} 0x300000 0x400000; bootm ${loadaddr}'
sa

