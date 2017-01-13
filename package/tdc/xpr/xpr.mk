################################################################################
#
# xpr
#
################################################################################

XPR_VERSION := $(call qstrip, $(BR2_PACKAGE_TDC_XPR_VERSION))
XPR_SOURCE = xpr-$(XPR_VERSION).tar.bz2
#XPR_SITE = https://10.0.2.2/cgit/rdst/binaries-release.git/plain
#XPR_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master
#XPR_SITE = https://10.0.2.2/git/rdst/ppmd-3531/archive
XPR_SITE = https://a000:a000,,100200@10.0.2.2/cgit/rdst/xpr.git/snapshot
XPR_STRIP_COMPONENTS = 1
XPR_INSTALL_STAGING = YES
XPR_LICENSE = GPLv2
XPR_LICENSE_FILES = COPYING

define XPR_CONFIGURE_CMDS
endef

define XPR_BUILD_CMDS
	$(MAKE) -j1 CROSS_COMPILER_PREFIX=$(TARGET_CROSS) BUILD_DOCS=n BUILD_EXAMPLES=n BUILD_TESTS=n -C $(@D) all
endef

define XPR_INSTALL_STAGING_CMDS
	$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/xpr
	$(INSTALL) -D -m 0644 $(@D)/include/xpr/*.h $(STAGING_DIR)/usr/include/xpr
	$(INSTALL) -D -m 0755 $(@D)/lib/libxpr.so $(STAGING_DIR)/usr/lib
endef

define XPR_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/lib/libxpr.so $(TARGET_DIR)/usr/lib
endef

#$(eval $(kernel-module))
$(eval $(generic-package))
