setenv loadaddr 0x82000000
setenv bootargs_base console=ttyAMA0,115200 mem=128M panic=5
setenv mtdparts mtdparts=hinand:1M(boot),2M(reserved),4M(kernel),-(ubifs)
setenv netargs stmmac.hitoe=1
setenv rootargs ubi.mtd=3 root=ubi0:rootfs rw rootfstype=ubifs
tftp ${loadaddr} hivcap-v1/images/uImage
nand erase 0x300000 0x400000
nand write ${loadaddr} 0x300000 ${filesize}
setenv kernelsize ${filesize}
tftp ${loadaddr} hivcap-v1/images/rootfs.ubi
nand erase 0x700000 0x7900000
nand write ${loadaddr} 0x700000 ${filesize}
setenv rootfssize ${filesize}
setenv loadkernel 'nand read ${loadaddr} 0x300000 0x400000'
setenv setmac 'setenv mac eth0.mac=${ethaddr} eth1.mac=${eth1addr}'
setenv setbootargs 'setenv bootargs ${bootargs_base} ${mtdparts} ${netargs} ${rootargs} ${mac}'
setenv bootcmd 'run setmac; run setbootargs; run loadkernel; bootm ${loadaddr}'
run setbootargs
sa

