setenv loadfdt 'fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}'
setenv loadimage 'fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image_file}'
setenv loadinitrd 'fatload mmc ${mmcdev}:${mmcpart} ${initrd_addr} ${initrd_file}'
setenv isl7998x 'isl7998x_tvin_mipi.ch1_std=1 isl7998x_tvin_mipi.ch2_std=1 isl7998x_tvin_mipi.ch3_std=1 isl7998x_tvin_mipi.ch4_std=1 isl7998x_tvin_mipi.sync_ch=3'
setenv mmcargs 'setenv bootargs console=${console},${baudrate} ${smp} root=${mmcroot} ${display} consoleblank=0 ${extra} ${isl7998x} galcore.initgpu3DMinClock=3'
setenv mmcboot 'echo Booting from mmc ...; run mmcargs; if run loadimage; run loadfdt; then bootz ${loadaddr} - ${fdt_addr}; else echo WARN: Cannot boot from mmc; fi;'
run mmcboot

