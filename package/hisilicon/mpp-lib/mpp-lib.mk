################################################################################
#
# mpp-lib
#
################################################################################

MPP_LIB_VERSION := $(call qstrip,$(BR2_PACKAGE_HISILICON_PLATFORM))_SDK_$(call qstrip,$(BR2_PACKAGE_HISILICON_SDK_VERSION))
MPP_LIB_SOURCE = mpp-lib-$(MPP_LIB_VERSION).tar.xz
#MPP_LIB_SITE = https://cgit.vaxpl.com/rdst/binaries-release/plain
MPP_LIB_SITE = https://192.168.0.2/git/rdst/binaries-release/raw/master
MPP_LIB_STRIP_COMPONENTS = 1
MPP_LIB_INSTALL_STAGING = YES
MPP_LIB_LICENSE = GPLv2
MPP_LIB_LICENSE_FILES =

define MPP_LIB_BUILD_CMDS
endef

define MPP_LIB_INSTALL_STAGING_CMDS
	$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/mkp
	$(INSTALL) -D -m 0644 $(@D)/include/mkp/*.* $(STAGING_DIR)/usr/include/mkp
	$(INSTALL) -D -m 0644 $(@D)/include/*.* $(STAGING_DIR)/usr/include
	$(INSTALL) -D -m 0644 $(@D)/lib/*.* $(STAGING_DIR)/usr/lib
endef

define MPP_LIB_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/lib/*.so* $(TARGET_DIR)/usr/lib
endef

$(eval $(generic-package))
