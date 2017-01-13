################################################################################
#
# reg-tools
#
################################################################################

REG_TOOLS_VERSION := v1.0.0-$(call qstrip,$(BR2_PACKAGE_HISILICON_PLATFORM))_SDK_$(call qstrip,$(BR2_PACKAGE_HISILICON_SDK_VERSION))
REG_TOOLS_SOURCE = $(REG_TOOLS_VERSION).tar.gz
#REG_TOOLS_SITE = https://10.0.2.2/cgit/rdst/binaries-release.git/plain
#REG_TOOLS_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master
REG_TOOLS_SITE = https://10.0.2.2/git/rdst/reg-tools/archive
REG_TOOLS_STRIP_COMPONENTS = 1
REG_TOOLS_INSTALL_STAGING = NO
REG_TOOLS_LICENSE = GPLv2
REG_TOOLS_LICENSE_FILES = COPYING

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
	$(INSTALL) -D -m 0755 $(@D)/hiddrs $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/hier $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/hiew $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/hil2s $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/himc $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/himd $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/himd.l $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/himm $(TARGET_DIR)/usr/bin/
endef

#$(eval $(kernel-module))
$(eval $(generic-package))
