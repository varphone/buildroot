mmc dev ${mmcdev}
if tftp ${loadaddr} ${tftproot}boot.vfat; then echo "Boot updating ..."; mmc write ${loadaddr} 0x5000 0x20000; fi
reset
