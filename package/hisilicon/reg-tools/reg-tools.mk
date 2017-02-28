################################################################################
#
# reg-tools
#
################################################################################

ifeq ($(BR2_PACKAGE_REG_TOOLS_CUSTOM_VERSION),y)
REG_TOOLS_VERSION := $(call qstrip,$(BR2_PACKAGE_REG_TOOLS_CUSTOM_VERSION_VALUE))
else
REG_TOOLS_VERSION := 1.0.0-$(call qstrip,$(BR2_PACKAGE_HISILICON_PLATFORM))_SDK_$(call qstrip,$(BR2_PACKAGE_HISILICON_SDK_VERSION))
endif
REG_TOOLS_SOURCE = reg-tools-$(REG_TOOLS_VERSION).tar.gz
REG_TOOLS_SITE =https://10.0.2.2/cgit/rdst/reg-tools.git/snapshot
REG_TOOLS_STRIP_COMPONENTS = 1
REG_TOOLS_INSTALL_STAGING = NO
REG_TOOLS_LICENSE = GPLv2
REG_TOOLS_LICENSE_FILES =

LN = ln -sf

ifeq ($(BR2_PACKAGE_HISILICON_REG_TOOLS_GPIO_I2C),y)
TARGET_CONFIGURE_OPTS += CONFIG_GPIO_I2C=Y
endif

define REG_TOOLS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define REG_TOOLS_INSTALL_STAGING_CMDS
endef

define REG_TOOLS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/btools $(TARGET_DIR)/usr/bin/
	$(LN) btools $(TARGET_DIR)/usr/bin/hiddrs
	$(LN) btools $(TARGET_DIR)/usr/bin/hier
	$(LN) btools $(TARGET_DIR)/usr/bin/hiew
	$(LN) btools $(TARGET_DIR)/usr/bin/hil2s
	$(LN) btools $(TARGET_DIR)/usr/bin/himc
	$(LN) btools $(TARGET_DIR)/usr/bin/himd
	$(LN) btools $(TARGET_DIR)/usr/bin/himd.l
	$(LN) btools $(TARGET_DIR)/usr/bin/himm
endef

$(eval $(generic-package))
