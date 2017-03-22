################################################################################
#
# libxd_muxer
#
################################################################################

ifeq ($(BR2_PACKAGE_LIBXD_MUXER_CUSTOM_VERSION),y)
LIBXD_MUXER_VERSION = $(call qstrip, $(BR2_PACKAGE_LIBXD_MUXER_CUSTOM_VERSION_VALUE))
else
LIBXD_MUXER_VERSION = 1.0.0
endif
LIBXD_MUXER_SOURCE = libxd_muxer-$(LIBXD_MUXER_VERSION).tar.xz
LIBXD_MUXER_SITE = https://10.0.2.2/cgit/rdst/libxd_muxer.git/snapshot
LIBXD_MUXER_STRIP_COMPONENTS = 1
LIBXD_MUXER_INSTALL_STAGING = YES
LIBXD_MUXER_LICENSE = GPLv2
LIBXD_MUXER_LICENSE_FILES =
LIBXD_MUXER_DEPENDENCIES = libxd_stream

LIBXD_MUXER_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)
LIBXD_MUXER_CXXFLAGS = $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)

LIBXD_MUXER_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS)\
 CC="$(TARGET_CC)"\
 CXX="$(TARGET_CXX)"\
 CFLAGS="$(TARGET_CFLAGS)"\
 CXXFLAGS="$(TARGET_CXXFLAGS)"\
 LDFLAGS="$(TARGET_LDFLAGS)"

define LIBXD_MUXER_CONFIGURE_CMDS
endef

define LIBXD_MUXER_BUILD_CMDS
	$(MAKE1) $(LIBXD_MUXER_MAKE_ENV) -C $(@D) all
endef

define LIBXD_MUXER_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) install DESTDIR=$(STAGING_DIR) PREFIX=/usr
endef

define LIBXD_MUXER_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
