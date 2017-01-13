################################################################################
#
# mpp-lib
#
################################################################################

MPP_LIB_VERSION := $(call qstrip,$(BR2_PACKAGE_HISILICON_PLATFORM))_SDK_$(call qstrip,$(BR2_PACKAGE_HISILICON_SDK_VERSION))
MPP_LIB_SOURCE = mpp-lib-$(MPP_LIB_VERSION).tar.xz
#MPP_LIB_SITE = https://10.0.2.2/cgit/rdst/binaries-release.git/plain
MPP_LIB_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master
MPP_LIB_STRIP_COMPONENTS = 1
MPP_LIB_INSTALL_STAGING = YES
MPP_LIB_LICENSE = GPLv2
MPP_LIB_LICENSE_FILES = COPYING

define MPP_LIB_BUILD_CMDS
	$(ECHO) "Nothing to build."
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

#$(eval $(kernel-module))
$(eval $(generic-package))
