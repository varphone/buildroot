################################################################################
#
# imx-gpu-viv-bin-3.0.35-4.0.0
#
################################################################################

IMX_GPU_VIV_BIN_3_0_35_4_0_0_VERSION = 3.0.35-4.0.0 
IMX_GPU_VIV_BIN_3_0_35_4_0_0_SOURCE = imx-gpu-viv-bin-$(IMX_GPU_VIV_BIN_3_0_35_4_0_0_VERSION).tar.xz
IMX_GPU_VIV_BIN_3_0_35_4_0_0_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master
IMX_GPU_VIV_BIN_3_0_35_4_0_0_STRIP_COMPONENTS = 1
IMX_GPU_VIV_BIN_3_0_35_4_0_0_LICENSE = GPLv2
IMX_GPU_VIV_BIN_3_0_35_4_0_0_LICENSE_FILES = LICENSE
IMX_GPU_VIV_BIN_3_0_35_4_0_0_INSTALL_STAGING = YES

IMX_GPU_VIV_BIN_3_0_35_4_0_0_DEPENDENCIES +=

define IMX_GPU_VIV_BIN_3_0_35_4_0_0_BUILD_CMDS
endef

define IMX_GPU_VIV_BIN_3_0_35_4_0_0_INSTALL_TARGET_CMDS
	cp -dpfr $(@D)/usr/lib/* $(TARGET_DIR)/usr/lib/
endef

define IMX_GPU_VIV_BIN_3_0_35_4_0_0_INSTALL_INIT_SYSV
endef

define IMX_GPU_VIV_BIN_3_0_35_4_0_0_INSTALL_INIT_SYSTEMD
endef

define IMX_GPU_VIV_BIN_3_0_35_4_0_0_INSTALL_STAGING_CMDS
	cp -dpfr $(@D)/usr/* $(STAGING_DIR)/usr/
endef

$(eval $(generic-package))
