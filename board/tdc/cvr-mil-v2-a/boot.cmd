setenv loadfdt 'fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}'
setenv loadimage 'fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image_file}'
setenv loadinitrd 'fatload mmc ${mmcdev}:${mmcpart} ${initrd_addr} ${initrd_file}'
setenv galcore 'galcore.initgpu3DMinClock=3'
setenv mmcargs 'setenv bootargs console=${console},${baudrate} ${smp} root=${mmcroot} ${display} consoleblank=0 ${galcore} ${extra}'
setenv mmcboot 'echo Booting from mmc ...; run mmcargs; if run loadimage; run loadfdt; then bootz ${loadaddr} - ${fdt_addr}; else echo WARN: Cannot boot from mmc; fi;'
run mmcboot

