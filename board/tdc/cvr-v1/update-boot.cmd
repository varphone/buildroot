tftp ${loadaddr} cvr-v1/images/uImage
nand erase 0x300000 0x400000
nand write ${loadaddr} 0x300000 ${filesize}
setenv kernelsize ${filesize}
tftp ${loadaddr} cvr-v1/images/initrd.cpio.xz
nand erase 0x700000 0xa00000
nand write ${loadaddr} 0x700000 ${filesize}
setenv initrdsize ${filesize}
sa
