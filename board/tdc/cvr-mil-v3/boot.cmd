setenv loadfdt 'fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}'
setenv loadimage 'fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image_file}'
setenv loadinitrd 'fatload mmc ${mmcdev}:${mmcpart} ${initrd_addr} ${initrd_file}'
setenv mmcargs 'run set_disp; setenv bootargs console=${console},${baudrate} ${smp} cma=320M root=${mmcroot} ${disp_args}'
setenv mmcboot 'echo Booting from mmc ...; run mmcargs; if run loadimage; run loadinitrd; run loadfdt; then bootz ${loadaddr} ${initrd_addr}:${initrd_size} ${fdt_addr}; else echo WARN: Cannot boot from mmc; fi;'
run mmcboot

