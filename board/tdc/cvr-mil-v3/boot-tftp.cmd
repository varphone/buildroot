setenv loadfdt 'tftp ${fdt_addr} ${tftproot}${fdt_file}'
setenv loadimage 'tftp ${loadaddr} ${tftproot}${image_file}'
setenv loadinitrd 'tftp ${initrd_addr} ${tftproot}${initrd_file}'
setenv mmcargs 'run set_disp; setenv bootargs console=${console},${baudrate} ${smp} cma=128M root=${mmcroot} ${disp_args}'
setenv tftpboot 'echo Booting from tftp ...; run mmcargs; if run loadimage; run loadinitrd; run loadfdt; then bootz ${loadaddr} ${initrd_addr}:${initrd_size} ${fdt_addr}; else echo WARN: Cannot boot from tftp; fi;'
run tftpboot

