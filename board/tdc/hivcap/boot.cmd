setenv loadaddr 0x82000000
setenv loadkernel 'nand read ${loadaddr} 0x300000 0x400000'
setenv bootargs_base console=ttyAMA0,115200 mem=128M panic=5
setenv mtdparts mtdparts=hinand:1M(boot),2M(reserved),4M(kernel),-(ubifs)
setenv netargs stmmac.hitoe=1
setenv rootargs ubi.mtd=3 root=ubi0:rootfs rw rootfstype=ubifs
setenv setmac 'setenv mac eth0.mac=${ethaddr} eth1.mac=${eth1addr}'
setenv setbootargs 'setenv bootargs ${bootargs_base} ${mtdparts} ${netargs} ${rootargs} ${mac}'
setenv bootcmd 'run setmac; run setbootargs; run loadkernel; bootm ${loadaddr}'
run bootcmd;
