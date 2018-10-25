################################################################################
#
# xpr
#
################################################################################

ifeq ($(BR2_PACKAGE_XPR_CUSTOM_VERSION),y)
XPR_VERSION = $(call qstrip, $(BR2_PACKAGE_XPR_CUSTOM_VERSION_VALUE))
else
XPR_VERSION = 2.1.5
endif
XPR_SOURCE = xpr-$(XPR_VERSION).tar.bz2
XPR_SITE = https://10.0.2.2/cgit/rdst/xpr.git/snapshot
XPR_STRIP_COMPONENTS = 1
XPR_INSTALL_STAGING = YES
XPR_DEPENDENCIES = live555
XPR_LICENSE = GPLv2
XPR_LICENSE_FILES =

XPR_MAKE_ENV = \
 CROSS_COMPILER_PREFIX=$(TARGET_CROSS)\
 BUILD_DOCS=n\
 BUILD_EXAMPLES=n\
 BUILD_TESTS=n

ifneq ($(BR2_SHARED_LIBS),y)
XPR_MAKE_ENV += BUILD_STATIC=y BUILD_SHARED=n XPR_PLUGIN=n
define XPR_INSTALL_A
	$(INSTALL) -D -m 0644 $(@D)/lib/libxpr.a $(1)/usr/lib
endef
endif

ifneq ($(BR2_STATIC_LIBS),y)
XPR_MAKE_ENV += BUILD_STATIC=n BUILD_SHARED=y
define XPR_INSTALL_SO
	$(INSTALL) -D -m 0755 $(@D)/lib/libxpr.so $(1)/usr/lib
endef
endif

define XPR_CONFIGURE_CMDS
endef

define XPR_BUILD_CMDS
	$(MAKE1) $(XPR_MAKE_ENV) -C $(@D) clean all
endef

define XPR_INSTALL_STAGING_CMDS
	$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/xpr
	$(INSTALL) -D -m 0644 $(@D)/include/xpr/*.h $(STAGING_DIR)/usr/include/xpr
	$(call XPR_INSTALL_A,$(STAGING_DIR))
	$(call XPR_INSTALL_SO,$(STAGING_DIR))
endef

define XPR_INSTALL_TARGET_CMDS
	$(call XPR_INSTALL_SO,$(TARGET_DIR))
endef

$(eval $(generic-package))
