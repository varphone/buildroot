################################################################################
#
# libmal
#
################################################################################

ifeq ($(BR2_PACKAGE_LIBMAL_CUSTOM_VERSION),y)
LIBMAL_VERSION = $(call qstrip, $(BR2_PACKAGE_LIBMAL_CUSTOM_VERSION_VALUE))
else
LIBMAL_VERSION = 1.0.4
endif
LIBMAL_SOURCE = libmal-$(LIBMAL_VERSION).tar.bz2
LIBMAL_SITE = https://10.0.2.2/cgit/rdst/libmal.git/snapshot
LIBMAL_STRIP_COMPONENTS = 1
LIBMAL_INSTALL_STAGING = YES
LIBMAL_LICENSE = GPLv2
LIBMAL_LICENSE_FILES =
LIBMAL_DEPENDENCIES = freetype xpr mpp-lib

LIBMAL_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)
LIBMAL_CXXFLAGS = $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)

LIBMAL_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS)\
 CC="$(TARGET_CC)"\
 CXX="$(TARGET_CXX)"\
 CFLAGS="$(TARGET_CFLAGS)"\
 CXXFLAGS="$(TARGET_CXXFLAGS)"\
 LDFLAGS="$(TARGET_LDFLAGS)"\
 PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)"

define LIBMAL_CONFIGURE_CMDS
	$(MAKE1) $(LIBMAL_MAKE_ENV) -C $(@D) clean
endef

define LIBMAL_BUILD_CMDS
	$(MAKE1) $(LIBMAL_MAKE_ENV) -C $(@D) clean all
endef

define LIBMAL_INSTALL_STAGING_CMDS
	$(MAKE1) $(LIBMAL_MAKE_ENV) -C $(@D) install DESTDIR=$(STAGING_DIR) PREFIX=/usr
endef

define LIBMAL_INSTALL_TARGET_CMDS
	$(MAKE1) $(LIBMAL_MAKE_ENV) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
