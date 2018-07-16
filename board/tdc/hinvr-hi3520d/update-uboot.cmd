nand erase 0 0x100000
mw.b 0x82000000 ff 0x100000
tftp 0x82000000 hivcap-v1s/images/u-boot-hi3531_930MHz.bin
nand write 0x82000000 0 0x100000
reset
