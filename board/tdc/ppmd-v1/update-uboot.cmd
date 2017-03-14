nand erase 0 100000
mw.b 0x82000000 ff 100000
tftp 0x82000000 u-boot-hi3531_930MHz.bin
nand write 0x82000000 0 100000
reset
