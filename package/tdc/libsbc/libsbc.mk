################################################################################
#
# libsbc
#
################################################################################

ifeq ($(BR2_PACKAGE_LIBSBC_CUSTOM_VERSION),y)
LIBSBC_VERSION = $(call qstrip, $(BR2_PACKAGE_LIBSBC_CUSTOM_VERSION_VALUE))
else
LIBSBC_VERSION = 1.0.2
endif
LIBSBC_SOURCE = libsbc-$(LIBSBC_VERSION).tar.bz2
LIBSBC_SITE = https://10.0.2.2/cgit/rdst/libsbc.git/snapshot
LIBSBC_STRIP_COMPONENTS = 1
LIBSBC_INSTALL_STAGING = YES
LIBSBC_LICENSE = GPLv2
LIBSBC_LICENSE_FILES =
LIBSBC_DEPENDENCIES = libmodbus

LIBSBC_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)
LIBSBC_CXXFLAGS = $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)

LIBSBC_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS)\
 CC="$(TARGET_CC)"\
 CXX="$(TARGET_CXX)"\
 CFLAGS="$(TARGET_CFLAGS)"\
 CXXFLAGS="$(TARGET_CXXFLAGS)"\
 LDFLAGS="$(TARGET_LDFLAGS)"\
 PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)"

define LIBSBC_CONFIGURE_CMDS
endef

define LIBSBC_BUILD_CMDS
	$(MAKE1) $(LIBSBC_MAKE_ENV) -C $(@D) clean all
endef

define LIBSBC_INSTALL_STAGING_CMDS
	$(MAKE1) $(LIBSBC_MAKE_ENV) -C $(@D) install DESTDIR=$(STAGING_DIR) PREFIX=/usr
endef

define LIBSBC_INSTALL_TARGET_CMDS
	$(MAKE1) $(LIBSBC_MAKE_ENV) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
