################################################################################
#
# libpwc
#
################################################################################

ifeq ($(BR2_PACKAGE_LIBPWC_CUSTOM_VERSION),y)
LIBPWC_VERSION = $(call qstrip, $(BR2_PACKAGE_LIBPWC_CUSTOM_VERSION_VALUE))
else
LIBPWC_VERSION = 1.0.2
endif
LIBPWC_SOURCE = libpwc-$(LIBPWC_VERSION).tar.bz2
LIBPWC_SITE = https://10.0.2.2/cgit/rdst/libpwc.git/snapshot
LIBPWC_STRIP_COMPONENTS = 1
LIBPWC_INSTALL_STAGING = YES
LIBPWC_LICENSE = GPLv2
LIBPWC_LICENSE_FILES =
LIBPWC_DEPENDENCIES = libmodbus

LIBPWC_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)
LIBPWC_CXXFLAGS = $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)

LIBPWC_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS)\
 CC="$(TARGET_CC)"\
 CXX="$(TARGET_CXX)"\
 CFLAGS="$(TARGET_CFLAGS)"\
 CXXFLAGS="$(TARGET_CXXFLAGS)"\
 LDFLAGS="$(TARGET_LDFLAGS)"\
 PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)"

define LIBPWC_CONFIGURE_CMDS
endef

define LIBPWC_BUILD_CMDS
	$(MAKE1) $(LIBPWC_MAKE_ENV) -C $(@D) all
endef

define LIBPWC_INSTALL_STAGING_CMDS
	$(MAKE1) $(LIBPWC_MAKE_ENV) -C $(@D) install DESTDIR=$(STAGING_DIR) PREFIX=/usr
endef

define LIBPWC_INSTALL_TARGET_CMDS
	$(MAKE1) $(LIBPWC_MAKE_ENV) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
