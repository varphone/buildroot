################################################################################
#
# imx-lib-3.0.35-4.0.0
#
################################################################################

IMX_LIB_3_0_35_4_0_0_VERSION = 3.0.35-4.0.0
IMX_LIB_3_0_35_4_0_0_SOURCE = imx-lib-$(IMX_GPU_VIV_BIN_3_0_35_4_0_0_VERSION).tar.gz
IMX_LIB_3_0_35_4_0_0_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master
IMX_LIB_3_0_35_4_0_0_LICENSE = LGPLv2.1+
IMX_LIB_3_0_35_4_0_0_LICENSE_FILES = COPYING-LGPL-2.1

IMX_LIB_3_0_35_4_0_0_INSTALL_STAGING = YES

# imx-lib-3.0.35-4.0.0 needs access to imx-specific kernel headers
IMX_LIB_3_0_35_4_0_0_DEPENDENCIES += linux
IMX_LIB_3_0_35_4_0_0_INCLUDE = \
	-I$(LINUX_DIR)/drivers/mxc/security/rng/include \
	-I$(LINUX_DIR)/drivers/mxc/security/sahara2/include \
	-idirafter $(LINUX_DIR)/include/uapi

IMX_LIB_3_0_35_4_0_0_MAKE_ENV = \
	$(TARGET_MAKE_ENV) \
	$(TARGET_CONFIGURE_OPTS) \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	PLATFORM=$(BR2_PACKAGE_FREESCALE_IMX_PLATFORM) \
	INCLUDE="$(IMX_LIB_3_0_35_4_0_0_INCLUDE)"

define IMX_LIB_3_0_35_4_0_0_BUILD_CMDS
	$(IMX_LIB_3_0_35_4_0_0_MAKE_ENV) $(MAKE1) -C $(@D)
endef

define IMX_LIB_3_0_35_4_0_0_INSTALL_STAGING_CMDS
	$(IMX_LIB_3_0_35_4_0_0_MAKE_ENV) $(MAKE1) -C $(@D) DEST_DIR=$(STAGING_DIR) install
endef

define IMX_LIB_3_0_35_4_0_0_INSTALL_TARGET_CMDS
	$(IMX_LIB_3_0_35_4_0_0_MAKE_ENV) $(MAKE1) -C $(@D) DEST_DIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
