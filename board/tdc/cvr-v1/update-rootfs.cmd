tftp ${loadaddr} cvr-v1/images/rootfs.squashfs
nand erase 0x1100000 0x1e00000
nand write ${loadaddr} 0x1100000 ${filesize}
setenv rootfssize ${filesize}
sa
