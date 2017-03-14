tftp ${loadaddr} ppmd-v1/images/uImage
nand erase 100000 400000
nand write ${loadaddr} 100000 ${filesize}
setenv kernelsize ${filesize}
tftp ${loadaddr} ppmd-v1/images/initrd.cpio.xz
nand erase 500000 a00000
nand write ${loadaddr} 500000 ${filesize}
setenv initrdsize ${filesize}
tftp ${loadaddr} ppmd-v1/images/rootfs.squashfs
nand erase f00000 1e00000
nand write ${loadaddr} f00000 ${filesize}
setenv rootfssize ${filesize}
setenv bootargs_cmd 'setenv bootargs ${bootargs_base} mtdparts=${mtdparts} ${rootargs} initrd=${initrdaddr},0x${initrdsize}'
setenv bootcmd 'run bootargs_cmd; nand read ${initrdaddr} 500000 0x400000; nand read ${loadaddr} 0x100000 0x400000; bootm ${loadaddr}'
sa

