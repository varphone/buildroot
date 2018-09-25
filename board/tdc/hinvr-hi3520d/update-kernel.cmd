tftp ${loadaddr} hivcap-v1s/images/uImage
nand erase 0x300000 0x400000
nand write ${loadaddr} 0x300000 ${filesize}
setenv kernelsize ${filesize}
sa
