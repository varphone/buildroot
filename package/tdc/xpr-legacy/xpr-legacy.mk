################################################################################
#
# xpr-legacy
#
################################################################################

ifeq ($(BR2_PACKAGE_XPR_LEGACY_CUSTOM_VERSION),y)
XPR_LEGACY_VERSION = $(call qstrip, $(BR2_PACKAGE_XPR_LEGACY_CUSTOM_VERSION_VALUE))
else
XPR_LEGACY_VERSION = 1.0-legacy
endif
XPR_LEGACY_SOURCE = xpr-$(XPR_LEGACY_VERSION).tar.bz2
XPR_LEGACY_SITE = https://10.0.2.2/cgit/rdst/xpr.git/snapshot
XPR_LEGACY_STRIP_COMPONENTS = 1
XPR_LEGACY_INSTALL_STAGING = YES
XPR_LEGACY_LICENSE = GPLv2
XPR_LEGACY_LICENSE_FILES = COPYING

XPR_LEGACY_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)
XPR_LEGACY_CXXFLAGS = $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)

XPR_LEGACY_DEPENDENCIES += libav

XPR_LEGACY_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS)\
 CC="$(TARGET_CC)"\
 CXX="$(TARGET_CXX)"\
 CFLAGS="$(TARGET_CFLAGS)"\
 CXXFLAGS="$(TARGET_CXXFLAGS)"\
 LDFLAGS="$(TARGET_LDFLAGS)"

define XPR_LEGACY_CONFIGURE_CMDS
endef

define XPR_LEGACY_BUILD_CMDS
	$(MAKE1) $(XPR_LEGACY_MAKE_ENV) -C $(@D) all
endef

define XPR_LEGACY_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) install DESTDIR=$(STAGING_DIR) PREFIX=/usr
endef

define XPR_LEGACY_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
