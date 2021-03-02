tftp ${loadaddr} ${tftproot}u-boot.imx
sf probe 1
sf erase 0 0x200000
sf write ${loadaddr} 0x400 0x80000
reset 
