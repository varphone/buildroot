mmc dev 1
tftp ${loadaddr} cvr-mil-v3/images/boot.vfat
mmc write ${loadaddr} 0x5000 0x20000
reset
