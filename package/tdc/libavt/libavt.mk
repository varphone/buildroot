################################################################################
#
# libavt
#
################################################################################

ifeq ($(BR2_PACKAGE_LIBAVT_CUSTOM_VERSION),y)
LIBAVT_VERSION = $(call qstrip, $(BR2_PACKAGE_LIBAVT_CUSTOM_VERSION_VALUE))
else
LIBAVT_VERSION = 1.0.3
endif
LIBAVT_SOURCE = libavt-$(LIBAVT_VERSION).tar.bz2
LIBAVT_SITE = https://10.0.2.2/cgit/rdst/libavt.git/snapshot
LIBAVT_STRIP_COMPONENTS = 1
LIBAVT_INSTALL_STAGING = YES
LIBAVT_LICENSE = GPLv2
LIBAVT_LICENSE_FILES =
LIBAVT_DEPENDENCIES = libserial-ppmd libir370

LIBAVT_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)
LIBAVT_CXXFLAGS = $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)

LIBAVT_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS)\
 CC="$(TARGET_CC)"\
 CXX="$(TARGET_CXX)"\
 CFLAGS="$(TARGET_CFLAGS)"\
 CXXFLAGS="$(TARGET_CXXFLAGS)"\
 LDFLAGS="$(TARGET_LDFLAGS)"\
 PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)"

define LIBAVT_CONFIGURE_CMDS
	$(MAKE1) $(LIBAVT_MAKE_ENV) -C $(@D) clean
endef

define LIBAVT_BUILD_CMDS
	$(MAKE1) $(LIBAVT_MAKE_ENV) -C $(@D) clean all
endef

define LIBAVT_INSTALL_STAGING_CMDS
	$(MAKE1) $(LIBAVT_MAKE_ENV) -C $(@D) install DESTDIR=$(STAGING_DIR) PREFIX=/usr
endef

define LIBAVT_INSTALL_TARGET_CMDS
	$(MAKE1) $(LIBAVT_MAKE_ENV) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
