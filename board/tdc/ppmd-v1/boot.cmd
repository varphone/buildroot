setenv initrdaddr 0x81000000
setenv loadaddr 0x82000000
setenv bootargs console=ttyAMA0,115200 mem=128M root=/dev/mtdblock4 ro rootfstype=squashfs panic=5
setenv bootargs_base console=ttyAMA0,115200 mem=128M panic=5
setenv mtdparts mtdparts=hinand:1M(boot),2M(reserved),4M(kernel),10M(initrd),30M(rootfs),8M(misc),-(cache)
setenv netargs stmmac.hitoe=1
setenv loadinitrd 'nand read ${initrdaddr} 0x700000 0x400000'
setenv loadkernel 'nand read ${loadaddr} 0x300000 0x400000'
setenv setmac 'setenv mac eth0.mac=${ethaddr} eth1.mac=${eth1addr}'
setenv setbootargs 'setenv bootargs ${bootargs_base} ${mtdparts} ${netargs} ${rootargs} initrd=${initrdaddr},0x${initrdsize} ${mac}'
setenv bootcmd 'run setmac; run setbootargs; run loadinitrd; run loadkernel; bootm ${loadaddr}'
run bootcmd;
