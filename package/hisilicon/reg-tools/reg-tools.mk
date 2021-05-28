################################################################################
#
# reg-tools
#
################################################################################

ifeq ($(BR2_PACKAGE_REG_TOOLS_CUSTOM_VERSION),y)
REG_TOOLS_VERSION := $(call qstrip,$(BR2_PACKAGE_REG_TOOLS_CUSTOM_VERSION_VALUE))
else
ifeq ($(HISILICON_CHIP),hi3520dv100)
REG_TOOLS_VERSION := 1.0.0-Hi3520D_V1.0.5.0
endif
ifeq ($(HISILICON_CHIP),hi331v100)
REG_TOOLS_VERSION := 1.0.0-Hi3531_V1.0.D.0
endif
ifeq ($(HISILICON_CHIP),hi3559av100)
REG_TOOLS_VERSION := 1.0.0-Hi3559AV100_V2.0.3.1
endif
REG_TOOLS_VERSION ?= 1.0.0-Hi3559AV100_V2.0.3.1
endif
REG_TOOLS_SOURCE = reg-tools-$(REG_TOOLS_VERSION).tar.gz
REG_TOOLS_SITE = https://cgit.vaxpl.com/rdst/reg-tools/snapshot
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

ifeq ($(HISILICON_CHIP),hi3559av100)
REG_TOOLS_BIN_PATH = $(@D)/bin/btools
REG_TOOLS_BIN_ALIAS = i2c_read i2c_write ssp_read ssp_write
else
REG_TOOLS_BIN_PATH = $(@D)/btools
REG_TOOLS_BIN_ALIAS = hier hiew hil2s
endif

REG_TOOLS_BIN_ALIAS += hiddrs himc himd himd.l himm

define REG_TOOLS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(REG_TOOLS_BIN_PATH) $(TARGET_DIR)/usr/bin/
	for a in $(REG_TOOLS_BIN_ALIAS); do \
		$(LN) btools $(TARGET_DIR)/usr/bin/$${a} ; \
	done
endef

$(eval $(generic-package))
