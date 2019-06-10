setenv loadfdt 'fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}'
setenv loadimage 'fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image_file}'
setenv loadinitrd 'fatload mmc ${mmcdev}:${mmcpart} ${initrd_addr} ${initrd_file}'
setenv galcore 'galcore.initgpu3DMinClock=32'
setenv isl7998x 'isl7998x_tvin_mipi.ch1_std=1 isl7998x_tvin_mipi.ch2_std=1 isl7998x_tvin_mipi.ch3_std=1 isl7998x_tvin_mipi.ch4_std=1 isl7998x_tvin_mipi.sync_ch=0'
setenv mmcargs 'setenv bootargs console=${console},${baudrate} ${smp} root=${mmcroot} ${display} consoleblank=0 ${galcore} ${isl7998x} ${extra}'
setenv mmcboot 'echo Booting from mmc ...; run mmcargs; if run loadimage; run loadfdt; then bootz ${loadaddr} - ${fdt_addr}; else echo WARN: Cannot boot from mmc; fi;'
run mmcboot

